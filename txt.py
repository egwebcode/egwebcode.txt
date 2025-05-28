import os
from math import ceil
from rich.console import Console
from rich.prompt import Prompt, IntPrompt

console = Console()

# Caminho padrão de downloads no Android
DOWNLOAD_PATH = "/storage/emulated/0/Download"
OUTPUT_FOLDER = os.path.join(DOWNLOAD_PATH, ".TXT")

def dividir_arquivo(caminho_arquivo, tamanho_mb):
    if not os.path.isfile(caminho_arquivo):
        console.print(f"[red]❌ Arquivo não encontrado em: {caminho_arquivo}[/red]")
        return

    os.makedirs(OUTPUT_FOLDER, exist_ok=True)

    nome_arquivo = os.path.basename(caminho_arquivo)
    nome_base, extensao = os.path.splitext(nome_arquivo)

    tamanho_bytes = tamanho_mb * 1024 * 1024
    parte = 1
    buffer = []
    bytes_atuais = 0
    total_linhas = 0

    with open(caminho_arquivo, 'r', encoding='utf-8', errors='ignore') as entrada:
        for linha in entrada:
            buffer.append(linha)
            bytes_atuais += len(linha.encode('utf-8'))
            total_linhas += 1

            if bytes_atuais >= tamanho_bytes:
                nome_saida = f"{nome_base}{parte}{extensao}"
                caminho_saida = os.path.join(OUTPUT_FOLDER, nome_saida)
                with open(caminho_saida, 'w', encoding='utf-8') as saida:
                    saida.writelines(buffer)
                console.print(f"[green]✔ Criado:[/green] {nome_saida}")
                parte += 1
                buffer = []
                bytes_atuais = 0

        # Salvar restante
        if buffer:
            nome_saida = f"{nome_base}{parte}{extensao}"
            caminho_saida = os.path.join(OUTPUT_FOLDER, nome_saida)
            with open(caminho_saida, 'w', encoding='utf-8') as saida:
                saida.writelines(buffer)
            console.print(f"[green]✔ Criado:[/green] {nome_saida}")

    console.print(f"\n[yellow]📄 Total de linhas lidas:[/yellow] {total_linhas}")
    console.print(f"[bold green]\n🎉 Arquivo dividido com sucesso![/bold green]")
    console.print(f"[blue]📁 Arquivos salvos em:[/blue] {OUTPUT_FOLDER}")

def main():
    console.print("[bold cyan]📂 Divisor de Arquivos TXT para Android (Termux)[/bold cyan]\n")

    nome_arquivo = Prompt.ask("📄 Nome do arquivo .txt (dentro da pasta Download)", default="meuarquivo.txt")
    caminho_completo = os.path.join(DOWNLOAD_PATH, nome_arquivo)

    tamanho_mb = IntPrompt.ask("📏 Tamanho de cada parte (em MB)", default=5)

    dividir_arquivo(caminho_completo, tamanho_mb)

if __name__ == "__main__":
    main()
