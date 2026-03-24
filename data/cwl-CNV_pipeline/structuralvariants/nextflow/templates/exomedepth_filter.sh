#!/bin/bash
LC_ALL=C
export LC_ALL

INPUT_FILE=$1
SAMPLE_FILE=$2
SAMPLE_FILE_SORT=$(echo "$SAMPLE_FILE" | sed "s/txt/sorted.txt/")
MIN_LEN=$3
MAX_LEN=$4
MIN_BF=$5
TEMP_FILE=$(echo "$INPUT_FILE" | sed "s/csv/filtered.csv/")
TEMP_FILE_SORT=$(echo "$TEMP_FILE" | sed "s/filtered/filterd.sorted/")
OUTPUT_FILE=$(echo "$TEMP_FILE" | sed "s/csv/bed/")

tail -n +2 $INPUT_FILE | sed 's/"//g' | awk -F"," -v maxLen=$MAX_LEN -v minLen=$MIN_LEN -v minBf=$MIN_BF '{ \
chr=$7; \
start=$5; \
end=$6; \
sample=$13; \
bf=$9; \
len=(end-start)/1000; \
type=$3=="deletion"?"DEL":"DUP"; \
tool="exomeDepth"; \

if(len>minLen && \
    len<maxLen && \
    bf>=minBf){
      print chr"\t"start"\t"end"\t"sample"\t"type"\t"bf"\t"tool}}' > ${TEMP_FILE}

# mapping case_id with sample_id
# join -1 4 -2 2 -o 1.1,1.2,1.3,2.1,1.5,1.6,1.7 <(sort -k 4 $TEMP_FILE) <(sort -k 2 $SAMPLE_FILE) > ${OUTPUT_FILE}
sort -k 4 $TEMP_FILE | sed '/^[[:space:]]*$/d' > ${TEMP_FILE_SORT}
sort -k 2 $SAMPLE_FILE | sed '/^[[:space:]]*$/d' > ${SAMPLE_FILE_SORT}
join -1 4 -2 2 ${TEMP_FILE_SORT} ${SAMPLE_FILE_SORT} -o 1.1,1.2,1.3,2.1,1.5,1.6,1.7 > ${OUTPUT_FILE}
