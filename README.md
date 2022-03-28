# TFM

Contingut d'interès de les carpetes:

2_Benchmark:
  - Input_config: conté els codis i scripts bàsics i necessaris per generar la configuració inicial de la simulació que permetrà comparar amb els resultats de les referències.

    i) in.[...]: scripts de LAMMPS
    
    ii) table_[...].f90: codis de fortran que generen les taules dels potencials (LJ, CS). A cada codi s'especifiquen els paràmetres utilitzats.
    
    iii) script.gnu: script de GNUplot per generar gràfiques de les quantitats termodinàmiques d'interès. 
    
    
    
script_output.sh: script de bash que busca els segments dins els arxius log.lammps que contenen la informació termodinàmica i copia les dades en un altre arxiu. La sintaxi és la següent:
    
    ./script_output.sh [arxiu origen] [arxiu a generar]
