# mageck-vispr CWL Generation Report

## mageck-vispr_init

### Tool Description
MAGeCK-VISPR is a comprehensive quality control, analysis and visualization pipeline for CRISPR/Cas9 screens.

### Metadata
- **Docker Image**: quay.io/biocontainers/mageck-vispr:0.5.6--py_0
- **Homepage**: https://bitbucket.org/liulab/mageck-vispr
- **Package**: https://anaconda.org/channels/bioconda/packages/mageck-vispr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mageck-vispr/overview
- **Total Downloads**: 50.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: MAGeCK-VISPR is a comprehensive quality control, analysis and visualization pipeline for CRISPR/Cas9 screens. init
       [-h] [--reads READS [READS ...]] [--keep-config] directory

positional arguments:
  directory             Path to the directory where the workflow shall be
                        initialized.

optional arguments:
  -h, --help            show this help message and exit
  --reads READS [READS ...]
                        Paths to FastQ files with reads that shall be added to
                        the config file. You can edit the sample sample names
                        and assignment to experiments in the config file.
  --keep-config         Keep existing config file.
```


## mageck-vispr_annotate-library

### Tool Description
MAGeCK-VISPR is a comprehensive quality control, analysis and visualization pipeline for CRISPR/Cas9 screens.

### Metadata
- **Docker Image**: quay.io/biocontainers/mageck-vispr:0.5.6--py_0
- **Homepage**: https://bitbucket.org/liulab/mageck-vispr
- **Package**: https://anaconda.org/channels/bioconda/packages/mageck-vispr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: MAGeCK-VISPR is a comprehensive quality control, analysis and visualization pipeline for CRISPR/Cas9 screens. annotate-library
       [-h] [--sgrna-len {19,20,AUTO}] [--assembly {mm10,mm9,hg38,hg19}]
       [--bedvalue BEDVALUE] [--bedvalue-column BEDVALUE_COLUMN]
       [--annotation-table-folder ANNOTATION_TABLE_FOLDER]
       [--annotation-table ANNOTATION_TABLE]
       library

positional arguments:
  library               Path to sgRNA library design file (comma separated,
                        columns identifier, sequence, gene).

optional arguments:
  -h, --help            show this help message and exit
  --sgrna-len {19,20,AUTO}
                        Length of sgrnas in library file.
  --assembly {mm10,mm9,hg38,hg19}
                        Assembly to use.
  --bedvalue BEDVALUE   Instead of providing an efficiency value in the output
                        bed file, use the values provided in a given txt
                        file.The txt file must be tab separated, with
                        header.The first column must be sgRNA ID that matches
                        the identifier in sgRNA library design file.
  --bedvalue-column BEDVALUE_COLUMN
                        Provide a column name in the file in --bedvalue option
                        as the column to fill in. For example, the 'LFC'
                        column in sgrna_summary.txt in MAGeCK RRA represents
                        the log fold change value.
  --annotation-table-folder ANNOTATION_TABLE_FOLDER
                        After specifying the sgrna length and assembly,
                        instead of downloading directly from bitbucket, search
                        in the folder for corresponding annotation table.
  --annotation-table ANNOTATION_TABLE
                        As an alternative to specifying the sgrna length and
                        assembly, a path to an annotation table can be
                        provided (tab separated, no header; with columns
                        chromosome, start, end, gene, score, strand,
                        sequence). This can also be a URL. See
                        https://bitbucket.org/liulab/mageck-vispr/downloads
                        for precomputed tables.
```


## Metadata
- **Skill**: generated
