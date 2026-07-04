#!/bin/bash

while true
do
    BLOCKS_BEFORE=$(bitcoind getblockcount 2>/dev/null)
    sleep 300
    BLOCKS_AFTER=$(bitcoind getblockcount 2>/dev/null)
    
    if [ "$BLOCKS_BEFORE" = "$BLOCKS_AFTER" ] || [ -z "$BLOCKS_AFTER" ]
    then
        echo "Зависло на блоке $BLOCKS_BEFORE. Перезапуск..."
        bitcoind stop
        sleep 60
        pkill -9 bitcoind
        sleep 10
        bitcoind
        sleep 30
    else
        echo "Идет успешно. Текущий блок: $BLOCKS_AFTER"
    fi
done
