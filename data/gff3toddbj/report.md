# gff3toddbj CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gff3toddbj_compare-ddbj | PASS | repo augustus.ann and maker.ann give a mismatch statistics report |
| gff3toddbj_genbank-to-ddbj | PASS | NCBI NC_045512.2 GenBank record converts to a DDBJ annotation with source and CDS entries |
| gff3toddbj_gff3-to-ddbj | PASS | repo augustus golden test: output identical to the expected augustus.ann; FASTA now staged writable for its index |
| gff3toddbj_list-products | Failed | tool bug: prints a generator object instead of the product list |
| gff3toddbj_normalize-entry-names | PASS | synthetic data: one entry name in the repo augustus.ann changed to dbj\\\\|AB1\\\\|loc 4 is renamed to dbj:AB1:loc:4 |
| gff3toddbj_split-fasta | PASS | synthetic data: repo augustus GFF3 plus an appended FASTA block; split GFF3 equals the original and the FASTA is intact |

## gff3toddbj_gff3-to-ddbj

### Tool Description
Converts GFF3 files to DDBJ format.

### gff3toddbj_split-fasta

### Tool Description
Split the FASTA block (after ##FASTA) from a GFF3 file and save both the FASTA and the slimmed GFF3.

### Metadata
- **Docker Image**: quay.io/biocontainers/gff3toddbj:0.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/yamaton/gff3toddbj
- **Package**: https://anaconda.org/channels/bioconda/packages/gff3toddbj/overview
- **Validation**: PASS

### Original Help Text
```text
usage: split-fasta [-h] [--suffix SUFFIX] [-v] gff3

Split FASTA from GFF3

positional arguments:
  gff3             Input GFF3

options:
  -h, --help       show this help message and exit
  --suffix SUFFIX  Suffix added to the output filenames
  -v, --version    Show version
```

## gff3toddbj_normalize-entry-names

### Tool Description
Normalize the entry names (first column) of a DDBJ annotation file: invalid letters (= | > " space and brackets) are replaced by a colon.

### Metadata
- **Docker Image**: quay.io/biocontainers/gff3toddbj:0.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/yamaton/gff3toddbj
- **Package**: https://anaconda.org/channels/bioconda/packages/gff3toddbj/overview
- **Validation**: PASS

### Original Help Text
```text
usage: normalize-entry-names [-h] [--suffix SUFFIX] [-v] file

positional arguments:
  file             Input annotation file

options:
  -h, --help       show this help message and exit
  --suffix SUFFIX  Suffix to output filenames
  -v, --version    Show version
```

## gff3toddbj_list-products

### Tool Description
List the products (product qualifiers) found in a GFF3 file.

### Metadata
- **Docker Image**: quay.io/biocontainers/gff3toddbj:0.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/yamaton/gff3toddbj
- **Package**: https://anaconda.org/channels/bioconda/packages/gff3toddbj/overview
- **Validation**: PASS

### Original Help Text
```text
usage: list-products [-h] [-v] gff3

positional arguments:
  gff3           Input GFF3 file

options:
  -h, --help     show this help message and exit
  -v, --version  Show version
```

## gff3toddbj_genbank-to-ddbj

### Tool Description
Convert a GenBank file to the DDBJ annotation format.

### Metadata
- **Docker Image**: quay.io/biocontainers/gff3toddbj:0.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/yamaton/gff3toddbj
- **Package**: https://anaconda.org/channels/bioconda/packages/gff3toddbj/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genbank-to-ddbj [-h] [--gbk FILE] [--metadata FILE] [-p STR]
                       [--transl_table INT] [--config_filter FILE] [-o FILE]
                       [-v] [--log STR]

options:
  -h, --help            show this help message and exit
  --gbk, --gbff, --genbank FILE
                        Input GenBank file
  --metadata FILE       Input metadata in TOML describing COMMON and other
                        entires
  -p, --prefix, --locus_tag_prefix STR
                        Prefix of locus_tag. See
                        https://www.ddbj.nig.ac.jp/ddbj/locus_tag-e.html
  --transl_table INT    Genetic Code ID. 1 by default, and 11 for bacteria.
                        See https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprint
                        gc.cgi
  --config_filter FILE  A set of Feature-Qualifier pairs allowed in the
                        output. See https://www.ddbj.nig.ac.jp/assets/files/pd
                        f/ddbj/fq-e.pdf
  -o, --out, --output FILE
                        Specify annotation file name as output
  -v, --version         Show version
  --log STR             [debug] Choose log level from (DEBUG, INFO, WARNING,
                        ERROR) (default: INFO).
```

## gff3toddbj_compare-ddbj

### Tool Description
Compare two DDBJ annotation files and report statistics on entries, features and locations.

### Metadata
- **Docker Image**: quay.io/biocontainers/gff3toddbj:0.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/yamaton/gff3toddbj
- **Package**: https://anaconda.org/channels/bioconda/packages/gff3toddbj/overview
- **Validation**: PASS

### Original Help Text
```text
usage: compare-ddbj [-h] [--no-rename-entry] [--patch-features] [--log STR]
                    ddbj1 ddbj2

positional arguments:
  ddbj1              Input DDBJ annotation 1
  ddbj2              Input DDBJ annotation 2

options:
  -h, --help         show this help message and exit
  --no-rename-entry  Disable renaming of entries by extracting accession part
                     assuming dbj|accession|locus format
  --patch-features   Remove short (< 10bp) introns by patching feature gaps
  --log STR          [debug] Choose log level from (DEBUG, INFO, WARNING,
                     ERROR) (default: INFO).
```

## Metadata
- **Docker Image**: quay.io/biocontainers/gff3toddbj:0.4.3--pyhdfd78af_0
- **Homepage**: https://github.com/yamaton/gff3toddbj
- **Package**: https://anaconda.org/channels/bioconda/packages/gff3toddbj/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gff3toddbj/overview
- **Total Downloads**: 15.0K
- **Last updated**: 2026-01-14
- **GitHub**: https://github.com/yamaton/gff3toddbj
- **Stars**: N/A
### Original Help Text
```text
usage: gff3-to-ddbj [-h] [--gff3 FILE] --fasta FILE [--metadata FILE] [-p STR]
                    [--transl_table INT] [--config_rename FILE]
                    [--config_filter FILE] [-o FILE] [-v] [--log STR]

options:
  -h, --help            show this help message and exit
  --gff3, --gff FILE    Input GFF3 file
  --fasta FILE          Input FASTA file
  --metadata FILE       Input metadata in TOML describing COMMON and other
                        entires
  -p, --prefix, --locus_tag_prefix STR
                        Prefix of locus_tag. See
                        https://www.ddbj.nig.ac.jp/ddbj/locus_tag-e.html
  --transl_table INT    Genetic Code ID. 1 by default, and 11 for bacteria.
                        See https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprint
                        gc.cgi
  --config_rename FILE  Rename setting for features and qualifiers
  --config_filter FILE  A set of Feature-Qualifier pairs allowed in the
                        output. See https://www.ddbj.nig.ac.jp/assets/files/pd
                        f/ddbj/fq-e.pdf
  -o, --out, --output FILE
                        Specify annotation file name as output
  -v, --version         Show version
  --log STR             [debug] Choose log level from (DEBUG, INFO, WARNING,
                        ERROR) (default: INFO).
```

