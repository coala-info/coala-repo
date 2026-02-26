# mgkit CWL Generation Report

## mgkit_fasta-utils

### Tool Description
Main function for FASTA file utilities

### Metadata
- **Docker Image**: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
- **Homepage**: https://github.com/frubino/mgkit
- **Package**: https://anaconda.org/channels/bioconda/packages/mgkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mgkit/overview
- **Total Downloads**: 75.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/frubino/mgkit
- **Stars**: N/A
### Original Help Text
```text
Usage: fasta-utils [OPTIONS] COMMAND [ARGS]...

  Main function

Options:
  --version  Show the version and exit.
  --cite
  --help     Show this message and exit.

Commands:
  filter     Filters a FASTA file [file-file]
  info       Gets information of FASTA file [file-file]
  rename     Rename Sequence headers of FASTA file [file-file] Adds 2...
  split      Splits a FASTA file [fasta-file] in a number of fragments
  translate  Translate FASTA file [fasta-file] in all 6 frames to...
  uid        Changes each header of a FASTA file [file-file] to a uid...
```


## mgkit_count-utils

### Tool Description
Main function for count-utils, providing utilities to combine, map, and convert count tables.

### Metadata
- **Docker Image**: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
- **Homepage**: https://github.com/frubino/mgkit
- **Package**: https://anaconda.org/channels/bioconda/packages/mgkit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: count-utils [OPTIONS] COMMAND [ARGS]...

  Main function

Options:
  --version  Show the version and exit.
  --cite
  --help     Show this message and exit.

Commands:
  cat     Combine multiple count tables files
  map     Map counts with information a dictionary file
  to_csv  Convert Parquet tables into CSV
```


## mgkit_dict-utils

### Tool Description
Main function for dictionary utility commands

### Metadata
- **Docker Image**: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
- **Homepage**: https://github.com/frubino/mgkit
- **Package**: https://anaconda.org/channels/bioconda/packages/mgkit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dict-utils [OPTIONS] COMMAND [ARGS]...

  Main function

Options:
  --version  Show the version and exit.
  --cite
  --help     Show this message and exit.

Commands:
  reverse  Reverse Key/Value in a dictionary file
  split    Split values in a dictionary file
```


## mgkit_snp_parser

### Tool Description
DEPRECATED, use `pnps-gen vcf` SNPs analysis, requires a vcf file

### Metadata
- **Docker Image**: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
- **Homepage**: https://github.com/frubino/mgkit
- **Package**: https://anaconda.org/channels/bioconda/packages/mgkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snp_parser [-h] [-o OUTPUT_FILE] [-q MIN_QUAL] [-f MIN_FREQ]
                  [-r MIN_READS] -g GFF_FILE -p VCF_FILE -a REFERENCE -m
                  SAMPLES_ID [-c COV_SUFF] [-s] [-v | --quiet] [--cite]
                  [--manual] [--version]

DEPRECATED, use `pnps-gen vcf` SNPs analysis, requires a vcf file

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        Ouput file (default: snp_data.pickle)
  -q MIN_QUAL, --min-qual MIN_QUAL
                        Minimum SNP quality (Phred score) (default: 30)
  -f MIN_FREQ, --min-freq MIN_FREQ
                        Minimum allele frequency (default: 0.01)
  -r MIN_READS, --min-reads MIN_READS
                        Minimum number of reads to accept the SNP (default: 4)
  -g GFF_FILE, --gff-file GFF_FILE
                        GFF file with annotations (default: None)
  -p VCF_FILE, --vcf-file VCF_FILE
                        Merged VCF file (default: None)
  -a REFERENCE, --reference REFERENCE
                        Fasta file with the GFF Reference (default: None)
  -m SAMPLES_ID, --samples-id SAMPLES_ID
                        the ids of the samples used in the analysis (default:
                        None)
  -c COV_SUFF, --cov-suff COV_SUFF
                        Per sample coverage suffix in the GFF (default: _cov)
  -s, --bcftools-vcf    bcftools call was used to produce the VCF file
                        (default: False)
  -v, --verbose         more verbose - includes debug messages (default: 20)
  --quiet               less verbose - only error and critical messages
                        (default: None)
  --cite                Show citation for the framework
  --manual              Show the script manual
  --version             show program's version number and exit
```

