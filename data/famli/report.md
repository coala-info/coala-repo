# famli CWL Generation Report

## famli_align

### Tool Description
Align a set of reads with DIAMOND, filter alignments with FAMLI, and return the results

### Metadata
- **Docker Image**: biocontainers/famli:v1.0_cv2
- **Homepage**: https://github.com/FredHutch/FAMLI
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/famli/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/FredHutch/FAMLI
- **Stars**: N/A
### Original Help Text
```text
usage: famli [-h] --input INPUT --sample-name SAMPLE_NAME --ref-db REF_DB
             --output-folder OUTPUT_FOLDER [--min-score MIN_SCORE]
             [--blocks BLOCKS] [--query-gencode QUERY_GENCODE]
             [--threads THREADS] [--min-qual MIN_QUAL]
             [--temp-folder TEMP_FOLDER] [--batchsize BATCHSIZE]

Align a set of reads with DIAMOND, filter alignments with FAMLI, and return
the results

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         Location for input file(s). Combine multiple files
                        with +. (Supported: sra://, s3://, or ftp://).
  --sample-name SAMPLE_NAME
                        Name of sample, sets output filename.
  --ref-db REF_DB       Folder containing reference database. (Supported:
                        s3://, ftp://, or local path).
  --output-folder OUTPUT_FOLDER
                        Folder to place results. (Supported: s3://, or local
                        path).
  --min-score MIN_SCORE
                        Minimum alignment score to report.
  --blocks BLOCKS       Number of blocks used when aligning. Value relates to
                        the amount of memory used. Roughly 6Gb RAM used by
                        DIAMOND per block.
  --query-gencode QUERY_GENCODE
                        Genetic code used to translate nucleotides.
  --threads THREADS     Number of threads to use aligning.
  --min-qual MIN_QUAL   Trim reads to a minimum Q score.
  --temp-folder TEMP_FOLDER
                        Folder used for temporary files.
  --batchsize BATCHSIZE
                        Number of reads to process at a time.
```


## famli_filter

### Tool Description
Filter a set of existing alignments in tabular format with FAMLI

### Metadata
- **Docker Image**: biocontainers/famli:v1.0_cv2
- **Homepage**: https://github.com/FredHutch/FAMLI
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: famli [-h] [--input INPUT] [--output OUTPUT] [--threads THREADS]
             [--logfile LOGFILE] [--batchsize BATCHSIZE]
             [--qseqid-ix QSEQID_IX] [--sseqid-ix SSEQID_IX]
             [--sstart-ix SSTART_IX] [--send-ix SEND_IX]
             [--bitscore-ix BITSCORE_IX] [--slen-ix SLEN_IX]
             [--sd-mean-cutoff SD_MEAN_CUTOFF] [--strim-5 STRIM_5]
             [--strim-3 STRIM_3]

Filter a set of existing alignments in tabular format with FAMLI

optional arguments:
  -h, --help            show this help message and exit
  --input INPUT         Location for input alignement file.
  --output OUTPUT       Location for output JSON file.
  --threads THREADS     Number of processors to use.
  --logfile LOGFILE     (Optional) Write log to this file.
  --batchsize BATCHSIZE
                        Number of reads to process at a time.
  --qseqid-ix QSEQID_IX
                        Alignment column for query sequence ID. (0-indexed
                        column ix)
  --sseqid-ix SSEQID_IX
                        Alignment column for subject sequence ID. (0-indexed
                        column ix)
  --sstart-ix SSTART_IX
                        Alignment column for subject start position.
                        (0-indexed column ix, 1-indexed start position)
  --send-ix SEND_IX     Alignment column for subject end position. (0-indexed
                        column ix, 1-indexed end position)
  --bitscore-ix BITSCORE_IX
                        Alignment column for alignment bitscore. (0-indexed
                        column ix)
  --slen-ix SLEN_IX     Alignment column for subject length. (0-indexed column
                        ix)
  --sd-mean-cutoff SD_MEAN_CUTOFF
                        Threshold for filtering max SD / MEAN
  --strim-5 STRIM_5     Amount to trim from 5' end of subject
  --strim-3 STRIM_3     Amount to trim from 3' end of subject
```

