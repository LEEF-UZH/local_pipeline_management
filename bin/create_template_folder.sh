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
    echo "ERROR = exactly three arguments need to be specified: DD MM YYY!"
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


TIMESTAMP=$YYYY$MM$DD
DATUM=$DD.$MM.${YYYY: -2}

echo
echo Timestamp: $TIMESTAMP
echo Datum    : $DATUM
echo


## Create folder_template folder

mkdir folder_template

## Create folder_template/0.general.parameter folder

mkdir folder_template/00.general.parameter
wget \
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/00.general.parameter/compositions.csv \
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/00.general.parameter/experimental_design.csv \
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/00.general.parameter/sample_metadata.yml \
	-P folder_template/00.general.parameter
				
## Create folder_template/0.raw.data folder

mkdir folder_template/0.raw.data

## Create folder_template/0.raw.data/bemovi.mag.16 folder

mkdir folder_template/0.raw.data/bemovi.mag.16
wget \
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/bemovi/bemovi.mag.16/0%20-%20video%20description_tempolate/video.description.txt \
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/bemovi/bemovi.mag.16/bemovi_extract.mag.16.yml \
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/bemovi/bemovi.mag.16/svm_video_classifiers_18c_16x.rds\
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/bemovi/bemovi.mag.16/svm_video_classifiers_increasing_16x_best_available.rds\
	-P folder_template/0.raw.data/bemovi.mag.16

## Create folder_template/0.raw.data/bemovi.mag.25 folder

mkdir folder_template/0.raw.data/bemovi.mag.25
wget \
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/bemovi/bemovi.mag.25/0%20-%20video%20description_tempolate/video.description.txt \
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/bemovi/bemovi.mag.25/bemovi_extract.mag.25.yml \
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/bemovi/bemovi.mag.25/bemovi_extract.mag.25.cropped.yml \
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/bemovi/bemovi.mag.25/svm_video_classifiers_18c_25x.rds\
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/bemovi/bemovi.mag.25/svm_video_classifiers_increasing_25x_best_available.rds\
	-P folder_template/0.raw.data/bemovi.mag.25

## Create folder_template/0.raw.data/flowcam folder

mkdir folder_template/0.raw.data/flowcam

wget \
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/flowcam/flowcam.yml \
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/flowcam/flowcam_dilution.csv \
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/flowcam/classifier/18C/svm_flowcam_classifiers_18c.rds \
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/flowcam/classifier/Current_best_classifier_increasing_temperature/svm_flowcam_classifiers_increasing_best_available.rds \
	-P folder_template/0.raw.data/flowcam
	
## Create folder_template/0.raw.data/flowcytometer folder

mkdir 0.raw.data/flowcytometer
wget \
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/flowcytometer/gates_coordinates.csv \
	https://github.com/LEEF-UZH/LEEF.parameter/blob/main/parameter/flowcytometer/metadata_flowcytometer.csv \
	-P folder_template/0.raw.data/flowcytometer

## Create folder_template/0.raw.data/manualcount folder

mkdir folder_template/0.raw.data/manualcount


## Create folder_template/0.raw.data/o2meter folder

mkdir folder_template/0.raw.data/o2meter

