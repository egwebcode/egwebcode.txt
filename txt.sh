#!/data/data/com.termux/files/usr/bin/bash

# Configurações
NOME="EG WEBCODE"
TITULO="DATA BASE"
ARQUIVO_ZIP="EG-WEBCODE-DATA-BASE.zip"
PASTA="txt_files"

# Cores para formatação
GREEN='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

# Mostrar painel
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

# Criar pasta
mkdir -p "$PASTA"

# Contador
total=999000
count=0
inicio=$(date +%s)

# Loop otimizado
for i in $(seq -w 0 999); do
  for j in $(seq -w 1 999); do
    nome_arquivo="${i}.${j}.txt"
    echo "Arquivo: $nome_arquivo" > "$PASTA/$nome_arquivo"  # mais rápido que touch
    ((count++))

    # Mostrar progresso a cada 10000 sem pausa
    if (( count % 10000 == 0 )); then
      agora=$(date +%s)
      duracao=$((agora - inicio))
      echo -e "${GREEN}[INFO] Criados $count de $total arquivos... Tempo: ${duracao}s${NC}"
    fi
  done
done

# Compactar
echo -e "${CYAN}[ZIP] Compactando os arquivos em $ARQUIVO_ZIP...${NC}"
zip -rq "$ARQUIVO_ZIP" "$PASTA"

# Fim
fim=$(date +%s)
total_tempo=$((fim - inicio))

echo -e "${GREEN}[OK] Arquivo gerado com sucesso: $ARQUIVO_ZIP${NC}"
echo -e "${CYAN}[FIM] Concluído em: $(date '+%Y-%m-%d %H:%M:%S') - Tempo total: ${total_tempo}s${NC}"
