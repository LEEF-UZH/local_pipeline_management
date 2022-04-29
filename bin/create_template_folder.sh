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


echo
echo Timestamp: $TIMESTAMP
echo Datum    : $DATUM
echo


## Create $TEMPLATEDIR folder

mkdir $TEMPLATEDIR

## Create $TEMPLATEDIR/0.general.parameter folder

mkdir $TEMPLATEDIR/00.general.parameter
wget \
	https://raw.githubusercontent.com/LEEF-UZH/LEEF.parameter/main/parameter/00.general.parameter/compositions.csv \
	https://raw.githubusercontent.com/LEEF-UZH/LEEF.parameter/main/parameter/00.general.parameter/experimental_design.csv \
	https://raw.githubusercontent.com/LEEF-UZH/LEEF.parameter/main/parameter/00.general.parameter/sample_metadata.yml \
	https://raw.githubusercontent.com/LEEF-UZH/LEEF.parameter/main/README.md \
	-P $TEMPLATEDIR/00.general.parameter

sed -i '' "s/%%TIMESTAMP%%/$TIMESTAMP/g" $TEMPLATEDIR/00.general.parameter/sample_metadata.yml

## Create $TEMPLATEDIR/0.raw.data folder

mkdir $TEMPLATEDIR/0.raw.data

## Create $TEMPLATEDIR/0.raw.data/bemovi.mag.16 folder

mkdir $TEMPLATEDIR/0.raw.data/bemovi.mag.16
wget \
	https://raw.githubusercontent.com/LEEF-UZH/LEEF.parameter/main/parameter/bemovi.mag.16/video.description.txt \
	https://raw.githubusercontent.com/LEEF-UZH/LEEF.parameter/main/parameter/bemovi.mag.16/bemovi_extract.mag.16.yml \
	-P $TEMPLATEDIR/0.raw.data/bemovi.mag.16
	
wget \
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/bemovi.mag.16/svm_video_classifiers_18c_20220419_MergedData.rds?raw=true \
	-O $TEMPLATEDIR/0.raw.data/bemovi.mag.16/svm_video_classifiers_18c_20220419_MergedData.rds

# wget \
# 	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/bemovi.mag.16/svm_video_classifiers_18c_20220419_MergedData.rds?raw=true \
# 	-O $TEMPLATEDIR/0.raw.data/bemovi.mag.16/svm_video_classifiers_18c_20220419_MergedData.rds
	
	
sed -i '' "s/%%TIMESTAMP%%/$TIMESTAMP/g" $TEMPLATEDIR/0.raw.data/bemovi.mag.16/video.description.txt
sed -i '' "s/%%DD%%/$DD/g" $TEMPLATEDIR/0.raw.data/bemovi.mag.16/video.description.txt
sed -i '' "s/%%MM%%/$MM/g" $TEMPLATEDIR/0.raw.data/bemovi.mag.16/video.description.txt
sed -i '' "s/%%YY%%/$YY/g" $TEMPLATEDIR/0.raw.data/bemovi.mag.16/video.description.txt

## Create $TEMPLATEDIR/0.raw.data/bemovi.mag.25 folder

mkdir $TEMPLATEDIR/0.raw.data/bemovi.mag.25
wget \
	https://raw.githubusercontent.com/LEEF-UZH/LEEF.parameter/main/parameter/bemovi.mag.25/video.description.txt \
	https://raw.githubusercontent.com/LEEF-UZH/LEEF.parameter/main/parameter/bemovi.mag.25/bemovi_extract.mag.25.yml \
	https://raw.githubusercontent.com/LEEF-UZH/LEEF.parameter/main/parameter/bemovi.mag.25/bemovi_extract.mag.25.cropped.yml \
	https://raw.githubusercontent.com/LEEF-UZH/LEEF.parameter/main/parameter/bemovi.mag.25/bemovi_extract.mag.25.non_cropped.yml \
	-P $TEMPLATEDIR/0.raw.data/bemovi.mag.25
	
wget \
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/bemovi.mag.25/svm_video_classifiers_18c_25x_20220419_MergedData.rds?raw=true \
	-O $TEMPLATEDIR/0.raw.data/bemovi.mag.25/svm_video_classifiers_18c_25x_20220419_MergedData.rds

# wget \
# 	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/bemovi.mag.25/svm_video_classifiers_18c_25x_20220419_MergedData.rds?raw=true \
# 	-O $TEMPLATEDIR/0.raw.data/bemovi.mag.25/svm_video_classifiers_18c_25x_20220419_MergedData.rds


sed -i '' "s/%%TIMESTAMP%%/$TIMESTAMP/g" $TEMPLATEDIR/0.raw.data/bemovi.mag.25/video.description.txt
sed -i '' "s/%%DD%%/$DD/g" $TEMPLATEDIR/0.raw.data/bemovi.mag.25/video.description.txt
sed -i '' "s/%%MM%%/$MM/g" $TEMPLATEDIR/0.raw.data/bemovi.mag.25/video.description.txt
sed -i '' "s/%%YY%%/$YY/g" $TEMPLATEDIR/0.raw.data/bemovi.mag.25/video.description.txt

## Create $TEMPLATEDIR/0.raw.data/flowcam folder

mkdir $TEMPLATEDIR/0.raw.data/flowcam

wget \
	https://raw.githubusercontent.com/LEEF-UZH/LEEF.parameter/main/parameter/flowcam/flowcam.yml \
	https://raw.githubusercontent.com/LEEF-UZH/LEEF.parameter/main/parameter/flowcam/flowcam_dilution.csv \
	-P $TEMPLATEDIR/0.raw.data/flowcam

wget \
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/flowcam/svm_flowcam_classifiers_18c_16x_20220419_MergedData.rds?raw=true \
	-O $TEMPLATEDIR/0.raw.data/flowcam/svm_flowcam_classifiers_18c_16x_20220419_MergedData.rds

# wget \
# 	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/flowcam/svm_flowcam_classifiers_18c_16x_20220419_MergedData.rds?raw=true \
# 	-O $TEMPLATEDIR/0.raw.data/flowcam/svm_flowcam_classifiers_18c_16x_20220419_MergedData.rds
	
## Create $TEMPLATEDIR/0.raw.data/flowcytometer folder

mkdir 0.raw.data/flowcytometer
wget \
	https://raw.githubusercontent.com/LEEF-UZH/LEEF.parameter/main/parameter/flowcytometer/gates_coordinates.csv \
	https://raw.githubusercontent.com/LEEF-UZH/LEEF.parameter/main/parameter/flowcytometer/metadata_flowcytometer.csv \
	-P $TEMPLATEDIR/0.raw.data/flowcytometer

## Create $TEMPLATEDIR/0.raw.data/manualcount folder

mkdir $TEMPLATEDIR/0.raw.data/manualcount
wget \
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/manualcount/manual_count.xlsx?raw=true \
	-O $TEMPLATEDIR/0.raw.data/manualcount/manual_count.xlsx

## Create $TEMPLATEDIR/0.raw.data/o2meter folder

mkdir $TEMPLATEDIR/0.raw.data/o2meter

