#!/data/data/com.termux/files/usr/bin/bash

# Configurações
NOME="EG WEBCODE"
TITULO="DATA BASE"
ARQUIVO_ZIP="EG-WEBCODE-DATA-BASE.zip"
PASTA="txt_files"

# Cores
RED='\033[1;31m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

# Função para mostrar cabeçalho
mostrar_painel() {
  clear
  echo -e "${CYAN}"
  echo "╔══════════════════════════════════════════════════════╗"
  echo "║               🔐 $TITULO Generator               ║"
  echo "╠══════════════════════════════════════════════════════╣"
  echo "║   Autor  : $NOME"
  echo "║   Início : $(date '+%Y-%m-%d %H:%M:%S')"
  echo "║   Saída  : $ARQUIVO_ZIP"
  echo "╚══════════════════════════════════════════════════════╝"
  echo -e "${NC}"
}

# Mostrar painel
mostrar_painel

# Criar diretório
mkdir -p "$PASTA"

# Iniciar contadores
total=998001
count=0

# Geração dos arquivos
for i in $(seq -w 0 999); do
  for j in $(seq -w 1 999); do
    filename="${i}.${j}.txt"
    touch "$PASTA/$filename"

    # Progresso simples a cada 10.000 arquivos
    ((count++))
    if (( count % 10000 == 0 )); then
      echo -e "${GREEN}[INFO] Criados $count de $total arquivos...${NC}"
    fi
  done
done

# Compactar
echo -e "${CYAN}[ZIP] Compactando os arquivos para $ARQUIVO_ZIP...${NC}"
zip -rq "$ARQUIVO_ZIP" "$PASTA"

# Finalização
echo -e "${GREEN}[OK] Arquivo gerado com sucesso: $ARQUIVO_ZIP${NC}"
echo -e "${CYAN}[FIM] Concluído em: $(date '+%Y-%m-%d %H:%M:%S')${NC}"
