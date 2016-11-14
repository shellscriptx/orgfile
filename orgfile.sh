#!/bin/bash

#------------------------------------------------------
# Data:          14 de Novembro de 2016
# Criado por:    Juliano Santos [SHAMAN]
# Script:        orgfile.sh
# Descrição:     Organiza seus arquivos por extensão.
# Página:        https://www.facebook.com/shellscriptx
# Email:         shellscriptx@gmail.com
#------------------------------------------------------

# Nome do script
SCRIPT=$(basename "$0")

# Documentação de ajuda do script
view_help()
{
	echo "Uso: $0 --origem dir1 --destino dir2 --tipo extensao1,extensao2,..."
	echo "Lẽ todos os arquivos do diretório/subdiretórios, criando uma pasta com base"
	echo "na extensão do arquivo e move para suas respectivas pastas."
	echo
	echo "Os argumentos obrigatórios para opções longas e curtas são obrigatórios."
	echo "-o, --origem <dir>       diretório contendo os arquivos a serem movidos."
	echo "-d, --destino <dir>      diretório de destino dos arquivos a serem movidos."
	echo "-t, --tipo <extensao>    define uma extensão ou uma lista de extensões a serem lidas."
	echo "                         se o parâmetro for omitido, aplica em todas as extensões."
	echo
	echo "Organizando todos os arquivos de texto (doc) e músicas (mp3)"
	echo "Exemplo:"
	echo "$ $0 -o /home/usuario/docemusic -d /home/usuario -t doc,mp3"
	echo
	echo "Criado por: SHAMAN"
	echo "Página: <https://www.facebook.com/shellscriptx/>"
	echo "Email: <shellscriptx@gmail.com>"
	
	exit 0	
}

# Os campos <destino> e <origem> são obrigatórios.
[ $# -lt 4 ] && view_help

# Lẽ os parâmetros passados e armazena e OPTS.
OPTS=$(getopt -l 'origem:,destino:,tipo:,ajuda' -o 'o:d:t:a' -n $SCRIPT -- "$@")

# Atribui os argumentos aos parâmetros da posição.
eval set -- "$OPTS"

# Descola um nível o índice dos elementos.
shift $((OPTIND - 1))

# Lẽ os parâmetros
while [ $# -gt $OPTIND ]
do
	case $1 in
		-o|--origem)
			FROM="$2"	# Armazena o diretório de origem
			shift 2		# Desloca +2
			;;
		-d|--destino)
			TO="$2"		# Armazena o diretório de destino
			shift 2		# Desloca +2
			;;
		-t|--tipo)		# Parâmetro não obrigatório.
			TYPE="$2"	# Armazena a extensão ou extensões.
			shift 2		# Desloca +2
			;;
		-a|--ajuda)
			view_help	# Chama a documentação.
			;;
		*)
			# Se houve erros, exibe mensagem e finaliza o script.
			echo "Tente: '$0 --ajuda' para mais informações."
			exit 0
			;;
	esac
done

# Verificando se os diretório são válidos.
[ -d "$FROM" ] || { echo "$SCRIPT: '$FROM': diretório de origem inválido."; exit 1; }
[ -d "$TO" ] || { echo "$SCRIPT: '$TO': diretório de destino inválido."; exit 1; }

# Mensagem de confirmação.
echo "Essa ação irá mover os arquivos:"
echo "Extensão: ${TYPE:-Todas as extensões}"
echo "De: $FROM"
echo "Para: $TO"
echo
read -n1 -p 'Deseja continuar (s/N)?' RES
echo

case $RES in
	s|S)
		# Se o parâmetro '-t|--tipo' for informado.
		if [ "$TYPE" ]; then
			# Substitui todas as ',' (virgulas) por '|' (PIPE) para contrução da REGEX.
			# Exemplo: mp3,doc,avi -> mp3|doc|avi
			TYPE=${TYPE//,/|}
			# Constroi a função para listar os arquivos e armazena em 'FIND'

			# Lista todos os arquivos pelo tipo ou tipos armazenados em 'TYPE', ignorando arquivos ocultos.
			FIND=$(find "$FROM" -type f -regextype egrep -regex ".*\.($TYPE)$" ! -regex '^.*\/\..*')
		else
			# Se o parâmetro '-t|--tipo' for omitido.
			# Lista todos os arquivos de todos os tipos, ignorando arquivos ocultos.
			FIND=$(find "$FROM" -type f -iname '*.*' -regextype egrep ! -regex '^.*\/\..*')
		fi

		# Executa a função 'FIND' e armazena os arquivos em 'file'.
		for file in $FIND
		do
			# Armazena a extensão do arquivo que posteriormente será usada para criar a pasta.
			EXT=${file##*.}

			# Cria a pasta ignorando erros se ela existir.
			mkdir -p "${TO%/}/$EXT"
	
			# Move o arquivo para sua respectiva pasta, por medida de segurança, optei por não
			# sobrescrever arquivos existentes, altere o parâmetro '-n' por sua conta e risco.
			mv -n "$file" "${TO%/}/$EXT"
		done
		;;
esac

exit 0
#FIM
