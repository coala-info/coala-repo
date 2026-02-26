# msi CWL Generation Report

## msi

### Tool Description
MSI_DIR variable not set. Setting it to /usr/local
only -i or -c are mandatory.

### Metadata
- **Docker Image**: quay.io/biocontainers/msi:0.3.8--hdfd78af_0
- **Homepage**: http://github.com/nunofonseca/msi/
- **Package**: https://anaconda.org/channels/bioconda/packages/msi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/msi/overview
- **Total Downloads**: 15.2K
- **Last updated**: 2025-06-18
- **GitHub**: https://github.com/nunofonseca/msi
- **Stars**: N/A
### Original Help Text
```text
MSI_DIR variable not set. Setting it to /usr/local
msi.sh [options] -i raw_data_toplevel_folder -c params_file
only -i or -c are mandatory.

The otpions available are:
 -i tl_dir - toplevel directory with the nanopore data. fastq files will be searched in $tl_dir/*.fastq.gz. It is expected one file per library/barcode.
 -m min_len    - minimum length of the reads
 -M max_len    - maximum length of the reads
 -q min_qual   - minimum quality
 -I metadata   - metadata file*
 -C min_reads  - minimum number of reads that a cluster should have (Default=1)
 -o out_folder -  output folder
 -b blast_database - path to the blast database
 -B blast_min_id   - value passed to blast (minimum % id - value between 0 and 100)
 -E blast_evalue   - value passed to blast (minimum e-value - value < 1)
 -T min_cluster_id2- minimum cluster identity (sequences with a value greater or equal are clustered together - value between 0 and 1) 
 -t threads        - maximum number of threads
 -c param_file      - file with default parameters values (overrides values passed in the command line)
 -r                 - run fastqc to generate qc reports for the fastq files
 -S                 - stop execution before running blast
 -V                 - increase verbosity
 -h  - provides usage information

*metadata file: tsv file were the file name should be found in one column and the column names (first line of the file) X, Y, Z should exist.
```

