# orgfile.sh

## Descrição

O **orgfile.sh** é um script que lê todos os arquivos de um diretório especificado, separando-os em pastas com base em sua extensão. A leitura dos diretório é feita recursivamente, ou seja, diretórios e sub-diretórios serão lidos.

## Recomendações

Antes de começar execute o script sem parâmetro para obter informações sobre seu uso:

```
$ ./orgfile.sh
```

## Parâmetros


Parâmetro|Descrição|
-------------------------------------------------------------------------------|
-o, --origem|Diretório contendo os arquivos a serem movidos.
-d, --destino|Diretório de destino para onde serão movidos os arquivos
-t, --tipo|Define uma extensão ou uma lista de extensões a serem lidas. Se o parâmetro for omitido, aplica em todas as extensões.

## Uso

Ler todos os arquivos com a extensão **doc** e **mp3** contidos no diretório de origem **/home/usuario/docemusic** e posteriormente salvá-los no diretório de destino **/home/usuario/**.


	$ ./orgfile.sh -o /home/usuario/docemusic -d /home/usuario -t doc,mp3

Será criado no diretório de destino **/home/usuario** duas pastas chamdas **doc** e **mp3**, contendo todos os arquivos com suas respectivas extensões.

```
$ ls /home/usuario
mp3/ doc/
```

## Desenvolvido por

Juliano Santos [SHAMAN]

## Bugs
Reporte possíveis erros enviando email para <shellscriptx@gmail.com>

## Página
[Shell Script X](http://shellscriptx.blogspot.com.br)

