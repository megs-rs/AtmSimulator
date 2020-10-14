#!/bin/bash
ant compile > out.txt 2>&1
if [ $? -ne 0 ]; then
   echo "Erro na compilação. Olhe o 'out.txt' para detalhes!"
   exit 1
fi
ant jar >> out.txt 2>&1
if [ $? -ne 0 ]; then
   echo "Erro no JAR. Olhe o 'out.txt' para detalhes!"
   exit 1
fi
