# gff3toddbj CWL Generation Report

## gff3toddbj_gff3-to-ddbj

### Tool Description
Converts GFF3 files to DDBJ format.

### Metadata
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

