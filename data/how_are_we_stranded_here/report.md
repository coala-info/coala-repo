# how_are_we_stranded_here CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| how_are_we_stranded_here_check_strandedness | PASS |  |
| how_are_we_stranded_here_gff32gtf | PASS |  |
| how_are_we_stranded_here_gtf2bed | PASS |  |

## how_are_we_stranded_here_check_strandedness

### Tool Description
Check if fastq files are stranded

### Metadata
- **Docker Image**: quay.io/biocontainers/how_are_we_stranded_here:1.0.1--pyhfa5458b_0
- **Homepage**: https://github.com/betsig/how_are_we_stranded_here
- **Package**: https://anaconda.org/channels/bioconda/packages/how_are_we_stranded_here/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/how_are_we_stranded_here/overview
- **Total Downloads**: 3.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/betsig/how_are_we_stranded_here
- **Stars**: N/A
### Original Help Text
```text
usage: check_strandedness [-h] -g GTF [-fa TRANSCRIPTS] [-n NREADS] -r1
                          READS_1 -r2 READS_2 [-k KALLISTO_INDEX] [-p]

Check if fastq files are stranded

optional arguments:
  -h, --help            show this help message and exit
  -g GTF, --gtf GTF     Genome annotation GTF file
  -fa TRANSCRIPTS, --transcripts TRANSCRIPTS
                        .fasta file with transcript sequences
  -n NREADS, --nreads NREADS
                        number of reads to sample
  -r1 READS_1, --reads_1 READS_1
                        fastq.gz file (R1)
  -r2 READS_2, --reads_2 READS_2
                        fastq.gz file (R2)
  -k KALLISTO_INDEX, --kallisto_index KALLISTO_INDEX
                        name of kallisto index (will build under this name if
                        file not found)
  -p, --print_commands  Print bash commands as they occur?
```

## how_are_we_stranded_here_gff32gtf

### Tool Description
Convert a GFF3 file to basic GTF format

### Metadata
- **Docker Image**: quay.io/biocontainers/how_are_we_stranded_here:1.0.1--pyhfa5458b_0
- **Homepage**: https://github.com/betsig/how_are_we_stranded_here
- **Package**: https://anaconda.org/channels/bioconda/packages/how_are_we_stranded_here/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gff32gtf [-h] [-o OUTPUT] gff3_file

Convert a GFF3 file to basic GTF format

positional arguments:
  gff3_file             gff3 file to convert

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        file name to write gtf
```

## how_are_we_stranded_here_gtf2bed

### Tool Description
Convert the exon lines of a GTF file to a BED12 file with one line per transcript

### Metadata
- **Docker Image**: quay.io/biocontainers/how_are_we_stranded_here:1.0.1--pyhfa5458b_0
- **Homepage**: https://github.com/betsig/how_are_we_stranded_here
- **Package**: https://anaconda.org/channels/bioconda/packages/how_are_we_stranded_here/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gtf2bed [-h] --gtf GTF --bed BED [-t TRANSCRIPT_ID_MARKER]

optional arguments:
  -h, --help            show this help message and exit
  --gtf GTF             input gtf file
  --bed BED             output bed file
  -t TRANSCRIPT_ID_MARKER, --transcript_id_marker TRANSCRIPT_ID_MARKER
                        text preceeding the transcript id in the 9th field
```

