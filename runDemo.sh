#!/bin/bash
logPath=logs
bkpPath=logs/bkp
logC=logC.txt
logS=logS.txt
sizeBkp=5

function rotaciona {
   arq=$1
   arq=${arq##*/}
   if [ -e $bkpPath/$arq$sizeBkp ]; then
      rm $bkpPath/$arq$sizeBkp
      for x in `seq $sizeBkp -1 2`
      do         
         mv $bkpPath/$arq$[$x-1] $bkpPath/$arq$x
      done
   fi
   w=1
   while [ -e $bkpPath/$arq$w ];
   do
      w=$[$w+1]
   done
   mv $1 $bkpPath/$arq$w
}

if [ -e $logPath/$logC ]; then
   rotaciona $logPath/$logC $bkpPath
fi

if [ -e $logPath/$logS ]; then
   rotaciona $logPath/$logS $bkpPath
fi

java -cp lib/ifx-framework-1.2-1.jar:dist/AtmSimulator.jar:lib/jdom.jar:lib/xercesImpl.jar config.Main cfg/demo/server/DemoServerStateMachine.xml cfg/config_server.xml cfg/configurators_server.xml >> $logPath/$logS 2>&1 &

sleep 3

java -cp lib/ifx-framework-1.2-1.jar:lib/jdom.jar:lib/jgraph.jar:lib/junit.jar:lib/jxfsclient2.1.3.jar:lib/jxfsserver2.1.3.jar:lib/jxfssupport2.1.3.jar:lib/poolman.jar:lib/xercesImpl.jar:dist/AtmSimulator.jar config.Main cfg/demo/client/DemoClientStateMachine.xml cfg/config.xml cfg/configurators.xml >> $logPath/$logC 2>&1 &
