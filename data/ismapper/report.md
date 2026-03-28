# ismapper CWL Generation Report

## ismapper_ismap

### Tool Description
Basic ISMapper options:

### Metadata
- **Docker Image**: quay.io/biocontainers/ismapper:2.0.2--pyhdfd78af_1
- **Homepage**: https://github.com/jhawkey/IS_mapper/
- **Package**: https://anaconda.org/channels/bioconda/packages/ismapper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ismapper/overview
- **Total Downloads**: 10.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jhawkey/IS_mapper
- **Stars**: N/A
### Original Help Text
```text
usage: ismap [--version] --reads READS [READS ...] --queries QUERIES
             [QUERIES ...] --reference REFERENCE [REFERENCE ...]
             [--output_dir OUTPUT_DIR] [--log LOG] [--help_all HELP_ALL]

Basic ISMapper options:
  --version             show program's version number and exit
  --reads READS [READS ...]
                        Paired end reads for analysing (can be gzipped)
  --queries QUERIES [QUERIES ...]
                        Multifasta file for query gene(s) (eg: insertion
                        sequence) that will be mapped to.
  --reference REFERENCE [REFERENCE ...]
                        Reference genome for typing against in genbank format
  --output_dir OUTPUT_DIR
                        Location for all output files (default is current
                        directory).
  --log LOG             Prefix for log file. If not supplied, prefix will be
                        current date and time.
  --help_all HELP_ALL   Display extended help
```


## ismapper_compiled_table.py

### Tool Description
Create a table of IS hits in all isolates for ISMapper

### Metadata
- **Docker Image**: quay.io/biocontainers/ismapper:2.0.2--pyhdfd78af_1
- **Homepage**: https://github.com/jhawkey/IS_mapper/
- **Package**: https://anaconda.org/channels/bioconda/packages/ismapper/overview
- **Validation**: PASS

### Original Help Text
```text
usage: compiled_table.py [-h] --tables TABLES [TABLES ...] --reference
                         REFERENCE --query QUERY [--gap GAP] [--cds CDS]
                         [--trna TRNA] [--rrna RRNA] [--imprecise IMPRECISE]
                         [--unconfident UNCONFIDENT] --out_prefix OUT_PREFIX

Create a table of IS hits in all isolates for ISMapper

optional arguments:
  -h, --help            show this help message and exit
  --tables TABLES [TABLES ...]
                        tables to compile
  --reference REFERENCE
                        gbk file of reference
  --query QUERY         fasta file for insertion sequence query for
                        compilation
  --gap GAP             distance between regions to call overlapping, default
                        is 0
  --cds CDS             qualifier containing gene information (default
                        product). Also note that all CDS features MUST have a
                        locus_tag
  --trna TRNA           qualifier containing gene information (default
                        product). Also note that all tRNA features MUST have a
                        locus_tag
  --rrna RRNA           qualifier containing gene information (default
                        product). Also note that all rRNA features MUST have a
                        locus_tag
  --imprecise IMPRECISE
                        Binary value for imprecise (*) hit (can be 1, 0 or
                        0.5), default is 1
  --unconfident UNCONFIDENT
                        Binary value for questionable (?) hit (can be 1, 0 or
                        0.5), default is 0
  --out_prefix OUT_PREFIX
                        Prefix for output file
```


## Metadata
- **Skill**: generated
