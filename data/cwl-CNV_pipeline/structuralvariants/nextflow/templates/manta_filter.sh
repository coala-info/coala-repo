#!/bin/bash
LC_ALL=C
export LC_ALL

INPUT_FILE=$1
SAMPLE_FILE=$2
MIN_LEN=$3
MAX_LEN=$4
MIN_Q=$5
OUTPUT_FILE=$(echo "$INPUT_FILE" | sed "s/raw/filtered/")

# mapping case_id with sample_id
SAMPLE_ID=$(echo "$OUTPUT_FILE" | cut -d '.' -f 1)
CASE_ID=$(awk -v search="$SAMPLE_ID" '$0 ~ search{print $1}' "$SAMPLE_FILE")

tail -n +2 $INPUT_FILE | awk -v maxLen=$MAX_LEN -v minLen=$MIN_LEN -v minQ=$MIN_Q -v sample="$CASE_ID" '{ \
  chr=$1; \
  start=$2 + 0; \
  end=$6 + 0; \
  q=$8 + 0.0; \
  len=(end-start)/1000.0; \
  type=$11; \
  tool="manta"; \

  if(len>minLen && \
    len<maxLen && \
    q>=minQ && \
    (type=="DEL" || type=="DUP")){
      printf "%s\t%d\t%d\t%s\t%s\t%.2f\t%s\n", chr,start,end,sample,type,q,tool}}' > ${OUTPUT_FILE}
