#!/bin/bash

usage="
Usage: `basename $0` [options] DD MM YYYY
       
Create a template folder which contains all the files needed to run the pipeline. 

Some information still needs to be entered and modified in the files. These are:

TO BE ADDED

Options:
  -h, --help            Print short help message and exit

DD  : Day of the month with two digits
MM  : Month of the year with two digits
YYYY: Year with four digits
"
BRANCH=LEEF-2_dev
REF=heads/$BRANCH
FILE=$BRANCH.zip

if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
  echo "${usage}"
  exit 0
fi


if [ $# != 3 ]
  then
    echo "ERROR = exactly three arguments need to be specified: DD MM YYYY!"
    exit
fi

DD=$1
echo $DD
if [ ${#DD} -ne 2 ]; then 
	echo "ERROR - DD (the day) has wrong length - length has to be exactly 2!"; exit
fi

if ! [[ $DD =~ ^[0-9]+$ ]]; then
   echo "ERROR - DD (the day) has to consists of two digits!" ; exit 1
fi

if [[ $DD > 32 ]]; then
   echo "ERROR - DD (the day) can not be larger than 31!" ; exit 1
fi

MM=$2
echo $MM
if [ ${#MM} -ne 2 ]; then 
	echo "ERROR - MM (the month) has wrong length - length has to be exactly 2!"; exit
fi

if ! [[ $MM =~ ^[0-9]+$ ]]; then
   echo "ERROR - MM (the month) has to consists of two digits!" ; exit 1
fi

if [[ $MM > 12 ]]; then
   echo "ERROR - MM (the month) can not be larger than 12!" ; exit 1
fi

YYYY=$3
echo $YYYY
if [ ${#YYYY} -ne 4 ]; then 
	echo "ERROR - YYYY (the year) has wrong length - length has to be exactly 4!"; exit
fi

if ! [[ $YYYY =~ ^[0-9]+$ ]]; then
   echo "ERROR - YYYY (the year) has to consists of four digits!" ; exit 1
fi

if [[ $YYYY > 2022 ]]; then
   echo "ERROR - YYYY (the year) can not be larger than 2022!" ; exit 1
fi

if [[ $YYYY < 2021 ]]; then
   echo "ERROR - YYYY (the year) can not be larger than 2021!" ; exit 1
fi

YY=${YYYY: -2}
TIMESTAMP=$YYYY$MM$DD
DATUM=$DD.$MM.$YY
TEMPLATEDIR=$TIMESTAMP


if [[ -d "$TEMPLATEDIR" ]]
then
    echo "ERROR - folder $TEMPLATEDIR Exists. Please delete or rename it!"
    exit
fi


echo "#####################"
echo Timestamp: $TIMESTAMP
echo Datum    : $DATUM
echo File     : $FILE
echo "#####################"

## Download zip file when needed

if [ -e "$FILE" ]; then
		echo "#####################"
    echo "$FILE does exist."
    echo "Using existing template."
    echo "To dowenload new template, delete the file $FILE."
		echo "#####################"
else 
		echo "#####################"
    echo "$FILE does not exist. Dowenloading it!"
    echo "This will take some time."
		echo "#####################"
		wget https://github.com/LEEF-UZH/LEEF.parameter/archive/refs/$REF.zip -O $FILE
fi 

## unzip file 

unzip $FILE

## move parameter into $TEMPLATEDIR

mv LEEF.parameter-$BRANCH/parameter ./$TEMPLATEDIR
rm -rf ./LEEF.parameter-$BRANCH

## set timestamps

### $TEMPLATEDIR/0.general.parameter folder

sed -i '' "s/%%TIMESTAMP%%/$TIMESTAMP/g" $TEMPLATEDIR/00.general.parameter/sample_metadata.yml

### $TEMPLATEDIR/0.raw.data/bemovi.mag.16 folder

sed -i '' "s/%%TIMESTAMP%%/$TIMESTAMP/g" $TEMPLATEDIR/0.raw.data/bemovi.mag.16/video.description.txt
sed -i '' "s/%%DD%%/$DD/g" $TEMPLATEDIR/0.raw.data/bemovi.mag.16/video.description.txt
sed -i '' "s/%%MM%%/$MM/g" $TEMPLATEDIR/0.raw.data/bemovi.mag.16/video.description.txt
sed -i '' "s/%%YY%%/$YY/g" $TEMPLATEDIR/0.raw.data/bemovi.mag.16/video.description.txt

### $TEMPLATEDIR/0.raw.data/bemovi.mag.25 folder

sed -i '' "s/%%TIMESTAMP%%/$TIMESTAMP/g" $TEMPLATEDIR/0.raw.data/bemovi.mag.25/video.description.txt
sed -i '' "s/%%DD%%/$DD/g" $TEMPLATEDIR/0.raw.data/bemovi.mag.25/video.description.txt
sed -i '' "s/%%MM%%/$MM/g" $TEMPLATEDIR/0.raw.data/bemovi.mag.25/video.description.txt
sed -i '' "s/%%YY%%/$YY/g" $TEMPLATEDIR/0.raw.data/bemovi.mag.25/video.description.txt


## Done
echo "#####################"
echo "Done!"
echo "The file $FILE has not been deleted and will be re-used!"
echo "#####################"
