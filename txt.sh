#!/data/data/com.termux/files/usr/bin/bash

echo "🔧 Instalando dependências..."
pkg update -y > /dev/null
pkg install python -y > /dev/null
pip install --quiet rich

echo "📂 Garantindo acesso ao armazenamento..."
termux-setup-storage

SCRIPT_PATH="$HOME/cortar_cpfs.py"

echo "📝 Criando script Python em: $SCRIPT_PATH"
cat > "$SCRIPT_PATH" << 'EOF'
import os
import shutil
from rich.console import Console
from rich.prompt import IntPrompt

console = Console()

ARQUIVO_ORIGINAL = "/sdcard/Download/cpfs_validos.txt"
ARQUIVO_TEMP = os.path.expanduser("~/cpfs_validos.txt")
PASTA_SAIDA = "/sdcard/Download/.TXT"

def mover_para_termux():
    if not os.path.exists(ARQUIVO_ORIGINAL):
        console.print(f"[red]❌ Arquivo não encontrado em:[/red] {ARQUIVO_ORIGINAL}")
        return False
    shutil.copyfile(ARQUIVO_ORIGINAL, ARQUIVO_TEMP)
    console.print(f"[green]✔ Arquivo copiado para Termux:[/green] {ARQUIVO_TEMP}")
    return True

def dividir_arquivo(tamanho_mb):
    os.makedirs(PASTA_SAIDA, exist_ok=True)
    nome_base = "cpfs_validos"
    extensao = ".txt"
    tamanho_bytes = tamanho_mb * 1024 * 1024

    parte = 1
    buffer = []
    bytes_atuais = 0

    with open(ARQUIVO_TEMP, 'r', encoding='utf-8', errors='ignore') as entrada:
        for linha in entrada:
            buffer.append(linha)
            bytes_atuais += len(linha.encode('utf-8'))

            if bytes_atuais >= tamanho_bytes:
                nome_saida = f"{nome_base}{parte}{extensao}"
                caminho_saida = os.path.join(PASTA_SAIDA, nome_saida)
                with open(caminho_saida, 'w', encoding='utf-8') as saida:
                    saida.writelines(buffer)
                console.print(f"[cyan]📁 Criado:[/cyan] {nome_saida}")
                parte += 1
                buffer = []
                bytes_atuais = 0

        if buffer:
            nome_saida = f"{nome_base}{parte}{extensao}"
            caminho_saida = os.path.join(PASTA_SAIDA, nome_saida)
            with open(caminho_saida, 'w', encoding='utf-8') as saida:
                saida.writelines(buffer)
            console.print(f"[cyan]📁 Criado:[/cyan] {nome_saida}")

    console.print(f"\n[bold green]✅ Arquivo dividido com sucesso![/bold green]")
    console.print(f"[blue]Saída:[/blue] {PASTA_SAIDA}")

def main():
    console.print("[bold cyan]📂 Cortador de CPF por MB para Termux[/bold cyan]\n")
    if mover_para_termux():
        tamanho_mb = IntPrompt.ask("📏 Tamanho de cada parte (em MB)", default=1)
        dividir_arquivo(tamanho_mb)

if __name__ == "__main__":
    main()
EOF

echo "🚀 Executando script..."
python "$SCRIPT_PATH"
