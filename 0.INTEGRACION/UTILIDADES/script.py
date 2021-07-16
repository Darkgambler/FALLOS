import sys
import os

#### archivo: nombre del archivo al que vamos a sustituir algo
#### texto_original: texto o palabra original que queremos sustituir
#### texto_sustituto: texto nuevo que queremos sustituir
def sustituir_texto( archivo, texto_original, texto_sustituto ):

    source = open( archivo, "r" )
    target = open( "temporal", "w" )

        

    x = source.readline()
    while ( x != '' ):
        x = x.replace( texto_original, texto_sustituto )
        target.write( x )
        x = source.readline()

    source.close()
    target.close()

    os.remove( archivo )
    os.rename( "temporal", archivo )
    return 0


n = len( sys.argv )
print( n )

archivo = "synth_"+sys.argv[1]+".v"
print( archivo )
for i in range( 1,n ):
    sustituir_texto( archivo, sys.argv[i], "synth_"+sys.argv[i] )
