#!/data/data/com.termux/files/usr/bin/bash

# Configurações
NOME="EG WEBCODE"
TITULO="DATA BASE"
ARQUIVO_ZIP="EG-WEBCODE-DATA-BASE.zip"
PASTA="txt_files"

# Cores para formatação
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

# Criar pasta
mkdir -p "$PASTA"

# Contador
total=999000
count=0

# Loop para gerar arquivos de 000.001.txt até 999.999.txt
for i in $(seq -w 0 999); do
  for j in $(seq -w 1 999); do
    nome_arquivo="${i}.${j}.txt"
    touch "$PASTA/$nome_arquivo"
    ((count++))

    # Mostrar progresso a cada 10.000
    if (( count % 10000 == 0 )); then
      echo -e "${GREEN}[INFO] Criados $count de $total arquivos...${NC}"
    fi
  done
done

# Compactar
echo -e "${CYAN}[ZIP] Compactando os arquivos em $ARQUIVO_ZIP...${NC}"
zip -rq "$ARQUIVO_ZIP" "$PASTA"

# Finalização
echo -e "${GREEN}[OK] Arquivo gerado com sucesso: $ARQUIVO_ZIP${NC}"
echo -e "${CYAN}[FIM] Concluído em: $(date '+%Y-%m-%d %H:%M:%S')${NC}"
