import os
from rich.console import Console
from rich.panel import Panel
from rich.prompt import Prompt
from rich.progress import track
from rich.text import Text

def main():
    console = Console()

    # Caminho para a pasta Downloads no Android
    pasta_downloads = "/storage/emulated/0/Download"

    console.print(Panel.fit("[bold cyan]VISUALIZADOR DE ARQUIVO .TXT PESADO (ANDROID)[/bold cyan]", border_style="cyan"))

    nome_arquivo = Prompt.ask("[bold yellow]Digite o nome do arquivo .txt na pasta Download[/bold yellow]")

    caminho_arquivo = os.path.join(pasta_downloads, nome_arquivo)

    if not os.path.isfile(caminho_arquivo):
        console.print(f"[bold red]Arquivo '{caminho_arquivo}' não encontrado![/bold red]")
        return

    console.print(Panel.fit(f"[green]Abrindo:[/green] {caminho_arquivo}", border_style="green"))

    # Leitura e exibição do conteúdo
    try:
        with open(caminho_arquivo, 'r', encoding='utf-8', errors='ignore') as arquivo:
            linhas = list(arquivo)

        for linha in track(linhas, description="[cyan]Exibindo arquivo...[/cyan]"):
            console.print(Text(linha.strip(), style="white"))

    except Exception as e:
        console.print(f"[bold red]Erro ao ler o arquivo:[/bold red] {e}")
        return

    # 🔍 Pesquisa
    while True:
        termo = Prompt.ask("\n[bold green]Deseja buscar por uma palavra ou frase? (deixe vazio para sair)[/bold green]").strip()
        if not termo:
            console.print("[bold magenta]Encerrando o programa. Até logo![/bold magenta]")
            break

        console.print(f"\n[bold blue]Buscando por:[/bold blue] [yellow]{termo}[/yellow]\n")
        encontrados = 0

        for i, linha in enumerate(linhas, 1):
            if termo.lower() in linha.lower():
                texto = Text(f"Linha {i}: {linha.strip()}")
                texto.highlight_words([termo], style="bold red on yellow")
                console.print(texto)
                encontrados += 1

        if encontrados == 0:
            console.print("[bold red]Nenhuma ocorrência encontrada.[/bold red]")
        else:
            console.print(f"\n[bold green]{encontrados} ocorrência(s) encontradas.[/bold green]")

if __name__ == "__main__":
    main()
