#! /bin/bash
#Aktuális dátum
DATE=$(date +"%m-%d-%Y")
#Mappa létrehozása ha nem létezik
if [ ! -e "exchanges" ] 
then
    mkdir "exchanges"
fi
#Mappán belül ha az aktuális dátumhoz nincs fájl létrehozva
if [ -e "exchanges/${DATE}.json" ]
then  
    echo "Ma már lekérted az árfolyamot:"
else
    #API, fájl létrehozás, adatok fájlba írása
    RESPONSE=$(curl -s "https://api.ratesapi.io/api/latest?base=EUR&symbols=HUF")
    touch "exchanges/${DATE}.json"
    echo "$RESPONSE" >> "exchanges/${DATE}.json"
    echo "Itt a mai árfolyam:"
fi

#Kiiratás a konzolra "olvasható" módon
BASE=$(cat "exchanges/${DATE}.json" | cut -c10-12)
SYMBOL=$(cat "exchanges/${DATE}.json" | cut -c25-27)
PRICE=$(cat "exchanges/${DATE}.json" | cut -c30-35)
echo "1 ${BASE} - ${PRICE} ${SYMBOL}"
