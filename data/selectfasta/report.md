# selectfasta CWL Generation Report

## Metadata
- **Skill**: generated

## selectfasta_selectFasta

### Tool Description
Select fastQ or fasta reads from list, -list or -random is required

### Metadata
- **Docker Image**: quay.io/biocontainers/selectfasta:3.1--h503566f_1
- **Homepage**: https://github.com/andvides/selectFasta/
- **Package**: https://anaconda.org/channels/bioconda/packages/selectfasta/overview
- **Validation**: PASS
### Original Help Text
```text
Select fastQ or fasta reads from list, -list or -random is required

/usr/local/bin/selectFasta
  -h                  (Help)
  -fastq        FILE  (fastq file to select reads from) 
  -list         FILE  (list of reads, fastq or fasta) 
  -random       VAL   (number of random reads to be selected from fasta/fastq file) 
  -fastq2fasta        (convert fastq file to fasta)
  -fasta        FILE  (fasta file to select reads from) 
  -fasta_sel          (from fasta file select reads in -list, if not flag, reads not in list are selected)
```

