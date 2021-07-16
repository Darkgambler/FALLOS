#!bin/bash
rm *.vcd
rm *.gtkw

if [ $1 == "1" ]; then
    cp ./UTILIDADES/SEED_FILES/probadorPRUEBANORMAL.v ./probador.v
    cp ./UTILIDADES/SEED_FILES/000PRUEBANORMAL.gtkw ./000PRUEBANORMAL.gtkw
fi

if [ $1 == "2" ]; then
    cp ./UTILIDADES/SEED_FILES/probadorALMOSTFULL.v ./probador.v
    cp ./UTILIDADES/SEED_FILES/000PRUEBAALMOSTFULL.gtkw ./000PRUEBAALMOSTFULL.gtkw
fi
