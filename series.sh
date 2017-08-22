#!/bin/sh

echo "Bem vindo ao gerenciador de LivreSeries"

#le a variável de escolha do usuário e atribui a variavel escolha
read -p "Você quer (I)nserir um novo episódio, (E)xcluir uma série ou (C)onsultar qual episódio está? " escolha

#verifica se o usuário inseriu alguma opção válida
if [ $escolha != "I" ] && [ $escolha != "E" ] && [ $escolha != "C" ]
then
    echo "Não é uma opção válida. Use I, C ou E"
    exit
fi

#se a escolha não for uma inserção no banco de dados, o arquivo que guarda as séries não existir,
#sai do programa com um erro
if [ $escolha != "I" ] && [ ! -e "series.txt" ]
then
    echo "Você deve inserir uma série antes de consultá-la"
    exit
fi

#atribui a variável que o usuário escolher a variável série
read -p "Qual a série? " serie

#caso a escolha seja um inserção
if [ $escolha = "I" ]
then
    read -p "Qual a temporada? " temporada
    read -p "Qual o episódio? " episodio
    echo "$serie,S$temporada,E$episodio" >> series.txt
    echo "Serie inserida com sucesso"

#caso a escolha seja uma consulta
elif [ $escolha = "C" ]
then
    encontrado=$(grep $serie series.txt)
    serie=$(echo $encontrado | cut -f 1 -d",")
    temporada=$(echo $encontrado | cut -f 2 -d",")
    episodio=$(echo $encontrado | cut -f 3 -d",")
    echo "EPISODIO: $serie"
    echo "TEMPORADA: $temporada"
    echo "EPISODIO: $episodio"

#caso a escolha seja uma exclusão
#é necessário jogar a saída em um auxiliar e renomeá-lo pois shell não aceita ler e escrever em um mesmo
#arquivo
elif [ $escolha = "E" ]
then
    grep -v $serie series.txt >> aux.txt
    mv aux.txt series.txt

fi
