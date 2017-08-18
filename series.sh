#!/bin/sh

echo "Bem vindo ao gerenciador de LivreSeries"
read -p "Você quer (I)nserir um novo episódio, (E)xcluir uma série ou (C)onsultar qual episódio está? " escolha


if [ $escolha != "I" ] && [ $escolha != "E" ] && [ $escolha != "C" ]
then
    echo "Não é uma opção válida. Use I, C ou E"
    exit
fi

if [ $escolha != "I" ] && [ ! -e "series.txt" ]
then
    echo "Você deve inserir uma série antes de consultá-la"
    exit
fi

read -p "Qual a série? " serie

if [ $escolha = "I" ]
then
    read -p "Qual a temporada? " temporada
    read -p "Qual o episódio? " episodio
    echo "$serie,S$temporada,E$episodio" >> series.txt
    echo "Serie inserida com sucesso"

elif [ $escolha = "C" ]
then
    encontrado=$(grep $serie series.txt)
    serie=$(echo $encontrado | cut -f 1 -d",")
    temporada=$(echo $encontrado | cut -f 2 -d",")
    episodio=$(echo $encontrado | cut -f 3 -d",")
    echo "EPISODIO: $serie"
    echo "TEMPORADA: $temporada"
    echo "EPISODIO: $episodio"

elif [ $escolha = "E" ]
then
    grep -v $serie series.txt >> series.txt

fi
