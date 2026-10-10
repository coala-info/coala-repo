# mgkit CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mgkit_count-utils_cat | PASS | synthetic data: featureCounts table for the gene ids of the real mgkit test GFF; chained map, cat and to_csv gave correct sums |
| mgkit_count-utils_map | PASS | synthetic data: featureCounts table for the gene ids of the real mgkit test GFF; chained map, cat and to_csv gave correct sums |
| mgkit_count-utils_to_csv | PASS | synthetic data: featureCounts table for the gene ids of the real mgkit test GFF; chained map, cat and to_csv gave correct sums |
| mgkit_dict-utils_reverse | PASS |  |
| mgkit_dict-utils_split | PASS |  |
| mgkit_fasta-utils_filter | PASS |  |
| mgkit_fasta-utils_info | PASS |  |
| mgkit_fasta-utils_rename | PASS |  |
| mgkit_fasta-utils_split | PASS |  |
| mgkit_fasta-utils_translate | PASS |  |
| mgkit_fasta-utils_uid | PASS |  |
| mgkit_snp_parser | PASS | synthetic data: planted VCF and GFF on real mgkit test contigs; fixed samples_id to repeat -m for each sample |

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


## mgkit_count-utils_cat

### Tool Description
Combine multiple count tables files

### Metadata
- **Docker Image**: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
- **Homepage**: https://github.com/frubino/mgkit
- **Package**: https://anaconda.org/channels/bioconda/packages/mgkit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: count-utils cat [OPTIONS] [COUNT_FILES]...

  Combine multiple count tables files

Options:
  -v, --verbose
  -o, --output PATH  Output file  [required]
  --help             Show this message and exit.
```

## mgkit_count-utils_map

### Tool Description
Map counts with information a dictionary file

### Metadata
- **Docker Image**: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
- **Homepage**: https://github.com/frubino/mgkit
- **Package**: https://anaconda.org/channels/bioconda/packages/mgkit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: count-utils map [OPTIONS] [COUNT_FILE] [OUTPUT_FILE]

  Map counts with information a dictionary file

Options:
  -v, --verbose
  -m, --map-file FILENAME  Map file to use  [required]
  -t, --taxa-map FILENAME  Taxa map file
  -s, --separator TEXT     Field separator for map file Key/Value  [default:
                           ]
  -sv, --split-value       Values are string to be split
  --help                   Show this message and exit.
```

## mgkit_count-utils_to_csv

### Tool Description
Convert Parquet tables into CSV

### Metadata
- **Docker Image**: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
- **Homepage**: https://github.com/frubino/mgkit
- **Package**: https://anaconda.org/channels/bioconda/packages/mgkit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: count-utils to_csv [OPTIONS] PARQUET_FILE [CSV_FILE]

  Convert Parquet tables into CSV

Options:
  -v, --verbose
  --help         Show this message and exit.
```

## mgkit_dict-utils_reverse

### Tool Description
Reverse Key/Value in a dictionary file

### Metadata
- **Docker Image**: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
- **Homepage**: https://github.com/frubino/mgkit
- **Package**: https://anaconda.org/channels/bioconda/packages/mgkit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dict-utils reverse [OPTIONS] [INPUT_FILE] [OUTPUT_FILE]

  Reverse Key/Value in a dictionary file

Options:
  -v, --verbose
  -s, --separator TEXT          Field separator for map file Key/Value
                                [default:       ]
  -os, --output-separator TEXT  Field separator for Output map file Key/Value
                                [default:        ]
  -r, --randomise
  --help                        Show this message and exit.
```

## mgkit_dict-utils_split

### Tool Description
Split values in a dictionary file

### Metadata
- **Docker Image**: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
- **Homepage**: https://github.com/frubino/mgkit
- **Package**: https://anaconda.org/channels/bioconda/packages/mgkit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dict-utils split [OPTIONS] [INPUT_FILE] [OUTPUT_FILE]

  Split values in a dictionary file

Options:
  -v, --verbose
  -s, --separator TEXT          Field separator for map file Key/Value
                                [default:       ]
  -vs, --value-separator TEXT   Field separator values  [default: ,]
  --no-separator                Values are string to be split by character
  -os, --output-separator TEXT  Field separator for Output map file Key/Value
                                [default:        ]
  --help                        Show this message and exit.
```

## mgkit_fasta-utils_filter

### Tool Description
Filters a FASTA file

### Metadata
- **Docker Image**: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
- **Homepage**: https://github.com/frubino/mgkit
- **Package**: https://anaconda.org/channels/bioconda/packages/mgkit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fasta-utils filter [OPTIONS] [FASTA_FILE] [OUTPUT_FILE]

  Filters a FASTA file [file-file]

Options:
  -v, --verbose
  --len-gt INTEGER RANGE      Keeps sequences whose length is greater than
                              [x>=1]
  --len-lt INTEGER RANGE      Keeps sequences whose length is less than
                              [x>=1]
  --header-contains TEXT      Keeps sequences whose header contains the string
  --seq-pattern TEXT          Keeps sequences that contains the string
  -f, --header-file FILENAME  Keep only sequences contained in file list
  -w, --wrap                  Wraps the output sequences to 60 characters
  -s, --trim-tail             Removes header information after first space
  --help                      Show this message and exit.
```

## mgkit_fasta-utils_info

### Tool Description
Gets information of FASTA file

### Metadata
- **Docker Image**: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
- **Homepage**: https://github.com/frubino/mgkit
- **Package**: https://anaconda.org/channels/bioconda/packages/mgkit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fasta-utils info [OPTIONS] [FASTA_FILE] [OUTPUT_FILE]

  Gets information of FASTA file [file-file]

Options:
  -v, --verbose
  -h, --header                    Prints header
  -s, --include-seq               Includes the sequence
  -r, --no-rename                 Do not split sequence name at first space
  -a, --hash-type [sha1|md5|sha256]
                                  [default: sha1]
  -g, --out-gff                   Outputs a GFF file
  -gc, --gc-content               Includes the GC Content
  --help                          Show this message and exit.
```

## mgkit_fasta-utils_rename

### Tool Description
Rename Sequence headers of FASTA file

### Metadata
- **Docker Image**: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
- **Homepage**: https://github.com/frubino/mgkit
- **Package**: https://anaconda.org/channels/bioconda/packages/mgkit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fasta-utils rename [OPTIONS] [FASTA_FILE] [OUTPUT_FILE]

  Rename Sequence headers of FASTA file [file-file] Adds 2 possible elements
  to the sequence header, separated by a character 1) a suffix (random string
  of characters) and 2) a prefix (optional).

  The character used as separator should be a '|' (default), '#' or other
  character that is not truncated in other software (space is).

  In fact, this script will truncate the header at the first space

Options:
  -v, --verbose
  -p, --prefix TEXT               Adds a prefix to the header
  -f, --file-name                 Adds filename as prefix (Useful for adding
                                  the file name
  -s, --separator TEXT            Separator for the elements of the new header
  -l, --suffix-len INTEGER RANGE  Number of random characters to use
                                  [0<=x<=20]
  --help                          Show this message and exit.
```

## mgkit_fasta-utils_split

### Tool Description
Splits a FASTA file in a number of fragments

### Metadata
- **Docker Image**: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
- **Homepage**: https://github.com/frubino/mgkit
- **Package**: https://anaconda.org/channels/bioconda/packages/mgkit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fasta-utils split [OPTIONS] [FASTA_FILE]

  Splits a FASTA file [fasta-file] in a number of fragments

Options:
  -v, --verbose
  -p, --prefix TEXT     Prefix for the file name in output  [default: split]
  -n, --number INTEGER  Number of chunks into which split the FASTA file
                        [default: 10]
  -z, --gzip            gzip output files
  --help                Show this message and exit.
```

## mgkit_fasta-utils_translate

### Tool Description
Translate FASTA file in all 6 frames

### Metadata
- **Docker Image**: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
- **Homepage**: https://github.com/frubino/mgkit
- **Package**: https://anaconda.org/channels/bioconda/packages/mgkit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fasta-utils translate [OPTIONS] [FASTA_FILE] [OUTPUT_FILE]

  Translate FASTA file [fasta-file] in all 6 frames to [output-file]

Options:
  -v, --verbose
  -t, --trans-table [bac_plt|drs_mit|inv_mit|prt_mit|universal|vt_mit|yst_alt|yst_mit]
                                  translation table  [default: universal]
  -1, --one-seq                   Only translate the sequence, instead of all
                                  6 frames
  -w, --no-wrap                   Make a sequence use only 1 line (2 including
                                  header)
  --progress                      Shows Progress Bar
  --help                          Show this message and exit.
```

## mgkit_fasta-utils_uid

### Tool Description
Changes each header of a FASTA file to a uid (unique ID)

### Metadata
- **Docker Image**: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
- **Homepage**: https://github.com/frubino/mgkit
- **Package**: https://anaconda.org/channels/bioconda/packages/mgkit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: fasta-utils uid [OPTIONS] [FASTA_FILE] [OUTPUT_FILE]

  Changes each header of a FASTA file [file-file] to a uid (unique ID)

Options:
  -v, --verbose
  -t, --table FILENAME  Filename of a table to record the changes (by default
                        discards it)
  --help                Show this message and exit.
```

## Metadata
- **Skill**: not generated
