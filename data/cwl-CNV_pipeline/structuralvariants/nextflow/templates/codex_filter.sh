#!/bin/bash
LC_ALL=C
export LC_ALL

INPUT_FILE=$1
SAMPLE_FILE=$2
SAMPLE_FILE_SORT=$(echo "$SAMPLE_FILE" | sed "s/txt/sorted.txt/")
MIN_LEN=$3
MAX_LEN=$4
MIN_LRATIO=$5
TEMP_FILE=$(echo "$INPUT_FILE" | sed "s/_Chrom.txt/.filtered.txt/")
TEMP_FILE_SORT=$(echo "$TEMP_FILE" | sed "s/filtered/filtered.sorted/")
OUTPUT_FILE=$(echo "$TEMP_FILE" | sed "s/txt/bed/")

tail -n +2 $INPUT_FILE | awk -v maxLen=$MAX_LEN -v minLen=$MIN_LEN -v minLRatio=$MIN_LRATIO '{ \
chr=$2; \
start=$4; \
end=$5; \
sample=$1; \
len=$6; \
lratio=$12; \
st_exon=$7; \
ed_exon=$8; \
type=$3=="del"?"DEL":"DUP"; \
tool="codex"; \

if(len>minLen && \
   len<maxLen && \
   len/(ed_exon-st_exon)<50 && \
   lratio>=minLRatio){
     print chr"\t"start"\t"end"\t"sample"\t"type"\t"lratio"\t"tool}}' > ${TEMP_FILE}

# mapping case_id with sample_id
# join -1 4 -2 2 -o 1.1,1.2,1.3,2.1,1.5,1.6,1.7 <(sort -k 4 $TEMP_FILE) <(sort -k 2 $SAMPLE_FILE) > ${OUTPUT_FILE}
sort -k 4 $TEMP_FILE | sed '/^[[:space:]]*$/d' > ${TEMP_FILE_SORT}
sort -k 2 $SAMPLE_FILE | sed '/^[[:space:]]*$/d' > ${SAMPLE_FILE_SORT}
join -1 4 -2 2 ${TEMP_FILE_SORT} ${SAMPLE_FILE_SORT} -o 1.1,1.2,1.3,2.1,1.5,1.6,1.7 > ${OUTPUT_FILE}
