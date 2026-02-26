# nanolyse CWL Generation Report

## nanolyse_NanoLyse

### Tool Description
Remove reads mapping to DNA CS. Reads fastq on stdin and writes to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanolyse:1.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/wdecoster/NanoLyse
- **Package**: https://anaconda.org/channels/bioconda/packages/nanolyse/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nanolyse/overview
- **Total Downloads**: 45.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/wdecoster/NanoLyse
- **Stars**: N/A
### Original Help Text
```text
usage: NanoLyse [-h] [-v] [--summary_in SUMMARY_IN]
                [--summary_out SUMMARY_OUT] [-r REFERENCE] [--logfile LOGFILE]

Remove reads mapping to DNA CS. Reads fastq on stdin and writes to stdout.

options:
  --summary_in SUMMARY_IN
                        Summary file to filter
  --summary_out SUMMARY_OUT
                        with --summary_in: name of output file.
  -r, --reference REFERENCE
                        Specify a fasta file against which to filter. Standard is DNA CS.
  --logfile LOGFILE     Specify the path and filename for the log file.

General options:
  -h, --help            show the help and exit
  -v, --version         Print version and exit.

EXAMPLES:
    gunzip -c reads.fastq.gz | NanoLyse | gzip > reads_without_lambda.fastq.gz
    gunzip -c reads.fastq.gz | NanoLyse | NanoFilt -q 12 | gzip > filt_reads_without_lambda.fastq.gz
    gunzip -c reads.fastq.gz | NanoLyse --reference mydb.fa.gz | gzip > reads_without_mydb.fastq.gz
```

