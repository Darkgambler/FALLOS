###### escribir el nombre del modulo principal sin .v
NAME = integracion
###### escribir todos los modulos empezando por el principal sin
###### .v
ALL_MODULES = integracion xfifo arbitro misc ram
#### EDITE LA VARIABLE PRUEBA CON LA OPCION DESEADA
#### NUMERO DE LA PRUEBA QUE SE QUIERE CORRER:
#### 1. PRUEBA NORMAL DE LLENADO SIN POPS DE SALIDA.
#### 2. PRUEBA ALMOST FULL.
PRUEBA = 2
all: yosys compilar
compilar:
	iverilog -Ttyp testbench.v
	vvp ./a.out
	rm ./a.out
yosys:
	cp ./UTILIDADES/SEED/script.ys ./UTILIDADES/script.ys
	sed -i 's|SUSTITUIR|$(NAME)|g' ./UTILIDADES/script.ys
	yosys -f script ./UTILIDADES/script.ys
	python3 ./UTILIDADES/script.py $(ALL_MODULES)
	sed -i 's|_out|_out_synt|g' "synth_"$(NAME)".v"
mover:
	bash ./UTILIDADES/script.sh $(PRUEBA)
gtkwave:
	gtkwave *.gtkw
