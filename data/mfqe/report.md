# mfqe CWL Generation Report

## mfqe

### Tool Description
Extract multiple sets of fastq or fasta reads by name

### Metadata
- **Docker Image**: quay.io/biocontainers/mfqe:0.5.0--h7b50bb2_5
- **Homepage**: https://github.com/wwood/mfqe
- **Package**: https://anaconda.org/channels/bioconda/packages/mfqe/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mfqe/overview
- **Total Downloads**: 20.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/wwood/mfqe
- **Stars**: N/A
### Original Help Text
```text
mfqe 0.5.0
Ben J. Woodcroft <benjwoodcroft near gmail.com>
Extract multiple sets of fastq reads by name

USAGE:
    
Usage for FASTQ:
  zcat my.fastq.gz |mfqe --sequence-name-lists <LIST1> .. --output-fastq-files <OUTPUT1> ..

Extract one or more sets of reads from a FASTQ (or FASTA) file by specifying their read names.

Read name files are uncompressed text files with read names (without comments).
Output is gzip-compressed unless --output-uncompressed is specified, input is uncompressed.

Other FASTQ options:
               
--input-fastq <PATH>: Use this file as input FASTQ [default: Use STDIN]

An analogous set of options is implemented for FASTA:

--output-fasta-files <OUTPUT1> ..
--input-fasta <PATH>



FLAGS:
    -h, --help                   Prints help information
    -u, --output-uncompressed    Output sequences uncompressed [default: gzip compress outputs]
    -V, --version                Prints version information

OPTIONS:
        --fasta-read-name-lists <fasta-read-name-lists>...
            List of files each containing sequence IDs [alias for --sequence-name-lists]

        --fastq-read-name-lists <fastq-read-name-lists>...
            List of files each containing sequence IDs [alias for --sequence-name-lists]

        --input-fasta <input-fasta>
            File containing uncompressed input FASTA sequences [default: Use STDIN]

        --input-fastq <input-fastq>
            File containing uncompressed input FASTQ sequences [default: Use STDIN]

        --output-fasta-files <output-fasta-files>...          List of files to write FASTA to
        --output-fastq-files <output-fastq-files>...          List of files to write FASTQ to
    -l, --sequence-name-lists <sequence-name-lists>...        List of files each containing sequence IDs
```

