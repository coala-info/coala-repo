# tag CWL Generation Report

## tag_bae

### Tool Description
Group features in GFF3 files into loci.

### Metadata
- **Docker Image**: quay.io/biocontainers/tag:0.5.1--py_0
- **Homepage**: https://github.com/standage/tag/
- **Package**: https://anaconda.org/channels/bioconda/packages/tag/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tag/overview
- **Total Downloads**: 8.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/standage/tag
- **Stars**: N/A
### Original Help Text
```text
usage: tag bae [-h] [-o FILE] [-d Δ] [-n N] [-p P] [-r] gff3 [gff3 ...]

positional arguments:
  gff3                 input files in GFF3 format

optional arguments:
  -h, --help           show this help message and exit
  -o FILE, --out FILE  write output in GFF3 to FILE; default is terminal
                       (stdout)
  -d Δ, --delta Δ      extend locus interval by Δ bp in each direction; by
                       default, Δ=0
  -n N, --min-bp N     only group features together in the same locus if they
                       overlap by at least N bp; by default N=25
  -p P, --min-perc P   only group features together in the same locus if they
                       overlap by a fraction of at least P of their overall
                       length; by default P=0.25 (25%)
  -r, --relax          relax parsing stringency
```


## tag_bcollapse

### Tool Description
Collapse overlapping features in GFF3 files into loci.

### Metadata
- **Docker Image**: quay.io/biocontainers/tag:0.5.1--py_0
- **Homepage**: https://github.com/standage/tag/
- **Package**: https://anaconda.org/channels/bioconda/packages/tag/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tag bcollapse [-h] [-o FILE] [-d Δ] [-n N] [-p P] [-r] gff3 [gff3 ...]

positional arguments:
  gff3                 input files in GFF3 format

optional arguments:
  -h, --help           show this help message and exit
  -o FILE, --out FILE  write output in GFF3 to FILE; default is terminal
                       (stdout)
  -d Δ, --delta Δ      extend locus interval by Δ bp in each direction; by
                       default, Δ=0
  -n N, --min-bp N     only group features together in the same locus if they
                       overlap by at least N bp; by default N=25
  -p P, --min-perc P   only group features together in the same locus if they
                       overlap by a fraction of at least P of their overall
                       length; by default P=0.25 (25%)
  -r, --relax          relax parsing stringency
```


## tag_gff3

### Tool Description
Processes GFF3 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/tag:0.5.1--py_0
- **Homepage**: https://github.com/standage/tag/
- **Package**: https://anaconda.org/channels/bioconda/packages/tag/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tag gff3 [-h] [-n] [-o FILE] [-r] [-i] [-s] gff3

positional arguments:
  gff3                 input file in GFF3 format

optional arguments:
  -h, --help           show this help message and exit
  -n, --no-sort        do not enforce sorting of output data
  -o FILE, --out FILE  write output in GFF3 format to FILE; default is
                       terminal (stdout)
  -r, --relax          relax parsing stringency
  -i, --retain-ids     retain feature IDs from input
  -s, --sorted         assume the input data is sorted
```


## tag_locuspocus

### Tool Description
Group features into loci based on overlap and proximity.

### Metadata
- **Docker Image**: quay.io/biocontainers/tag:0.5.1--py_0
- **Homepage**: https://github.com/standage/tag/
- **Package**: https://anaconda.org/channels/bioconda/packages/tag/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tag locuspocus [-h] [-o FILE] [-d Δ] [-n N] [-p P] [-t TYPE] [-r]
                      gff3 [gff3 ...]

positional arguments:
  gff3                  input files in GFF3 format

optional arguments:
  -h, --help            show this help message and exit
  -o FILE, --out FILE   write output in GFF3 to FILE; default is terminal
                        (stdout)
  -d Δ, --delta Δ       extend locus interval by Δ bp in each direction; by
                        default, Δ=0
  -n N, --min-bp N      only group features together in the same locus if they
                        overlap by at least N bp; by default N=25
  -p P, --min-perc P    only group features together in the same locus if they
                        overlap by a fraction of at least P of their overall
                        length; by default P=0.25 (25%)
  -t TYPE, --type TYPE  apply locus parsing to features of type TYPE; by
                        default, parsing is applied to all top-level features
                        regardless of type
  -r, --relax           relax parsing stringency
```


## tag_merge

### Tool Description
Merges multiple GFF3 files into a single GFF3 file.

### Metadata
- **Docker Image**: quay.io/biocontainers/tag:0.5.1--py_0
- **Homepage**: https://github.com/standage/tag/
- **Package**: https://anaconda.org/channels/bioconda/packages/tag/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tag merge [-h] [-o FILE] [-r] gff3 [gff3 ...]

positional arguments:
  gff3                 input files in GFF3 format

optional arguments:
  -h, --help           show this help message and exit
  -o FILE, --out FILE  write output in GFF3 to FILE; default is terminal
                       (stdout)
  -r, --relax          relax parsing stringency
```


## tag_occ

### Tool Description
Extracts features of a given type from a GFF3 file.

### Metadata
- **Docker Image**: quay.io/biocontainers/tag:0.5.1--py_0
- **Homepage**: https://github.com/standage/tag/
- **Package**: https://anaconda.org/channels/bioconda/packages/tag/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tag occ [-h] [-r] gff3 type

positional arguments:
  gff3         input file
  type         feature type

optional arguments:
  -h, --help   show this help message and exit
  -r, --relax  relax parsing stringency
```


## tag_pmrna

### Tool Description
Parses and processes a GFF3 file for pmRNA analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/tag:0.5.1--py_0
- **Homepage**: https://github.com/standage/tag/
- **Package**: https://anaconda.org/channels/bioconda/packages/tag/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tag pmrna [-h] [-r] gff3

positional arguments:
  gff3         input file

optional arguments:
  -h, --help   show this help message and exit
  -r, --relax  relax parsing stringency
```


## tag_pep2nuc

### Tool Description
Converts protein-coordinate GFF3 features to their corresponding nucleotide coordinates in a genome-coordinate GFF3 file.

### Metadata
- **Docker Image**: quay.io/biocontainers/tag:0.5.1--py_0
- **Homepage**: https://github.com/standage/tag/
- **Package**: https://anaconda.org/channels/bioconda/packages/tag/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tag pep2nuc [-h] [-o FILE] [-a ATTR] [-k ATTR] genome protein

positional arguments:
  genome                GFF3 file with CDS or protein features defined on a
                        genomic (contig, scaffold, or chromosome) coordinate
                        system
  protein               GFF3 file with features defined on a protein
                        coordinate system

optional arguments:
  -h, --help            show this help message and exit
  -o FILE, --out FILE   file to which output will be written; by default,
                        output is written to the terminal (stdout)
  -a ATTR, --attr ATTR  CDS/protein attribute in the genome GFF3 file that
                        corresponds to the protein identifier (column 1) of
                        the protein GFF3 file; "ID" by default
  -k ATTR, --keep-prot ATTR
                        keep the original protein ID and write it to the
                        specified attribute in the output
```


## tag_sum

### Tool Description
Briefly summarize a GFF3 file

### Metadata
- **Docker Image**: quay.io/biocontainers/tag:0.5.1--py_0
- **Homepage**: https://github.com/standage/tag/
- **Package**: https://anaconda.org/channels/bioconda/packages/tag/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tag sum [-h] gff3

Briefly summarize a GFF3 file

positional arguments:
  gff3        input file

optional arguments:
  -h, --help  show this help message and exit
```


## Metadata
- **Skill**: generated
