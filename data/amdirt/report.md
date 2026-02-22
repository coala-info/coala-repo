# amdirt CWL Generation Report

## amdirt_autofill

### Tool Description
Autofills library and/or sample table(s) using ENA API and accession numbers

### Metadata
- **Docker Image**: quay.io/biocontainers/amdirt:1.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/SPAAM-community/AMDirT
- **Package**: https://anaconda.org/channels/bioconda/packages/amdirt/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amdirt/overview
- **Total Downloads**: 11.9K
- **Last updated**: 2026-02-06
- **GitHub**: https://github.com/SPAAM-community/AMDirT
- **Stars**: 1
### Original Help Text
```text
Usage: amdirt autofill [OPTIONS] [ACCESSION]...

  Autofills library and/or sample table(s) using ENA API and accession numbers
  

  ACCESSION: ENA accession(s). Multiple accessions can be space separated
  (e.g. PRJNA123 PRJNA456)

Options:
  -n, --table_name [ancientmetagenome-environmental|ancientmetagenome-hostassociated|ancientsinglegenome-hostassociated|test]
                                  [default: ancientmetagenome-hostassociated]
  -t, --output_ena_table PATH     path to ENA table output file
  -l, --library_output PATH       path to library output table file
  -s, --sample_output PATH        path to sample output table file
  --help                          Show this message and exit.
```


## amdirt_convert

### Tool Description
Converts filtered samples and libraries tables to eager, ameta, taxprofiler, and fetchNGS input tables

### Metadata
- **Docker Image**: quay.io/biocontainers/amdirt:1.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/SPAAM-community/AMDirT
- **Package**: https://anaconda.org/channels/bioconda/packages/amdirt/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: amdirt convert [OPTIONS] SAMPLES TABLE_NAME

  Converts filtered samples and libraries tables to eager, ameta, taxprofiler, and fetchNGS input tables

  Note: When supplying a pre-filtered libraries table with `--libraries`, the
  corresponding sample table is still required!

  SAMPLES: path to filtered AncientMetagenomeDir samples tsv file
  TABLE_NAME: name of table to convert

Options:
  -t, --tables PATH       (Optional) JSON file listing AncientMetagenomeDir
                          tables
  --libraries FILE        (Optional) Path to a pre-filtered libraries table
                          NOTE: This argument is mutually exclusive with
                          arguments: [librarymetadata].
  --librarymetadata       Generate AncientMetagenomeDir libraries table of all
                          samples in input table NOTE: This argument is
                          mutually exclusive with  arguments: [libraries].
  -o, --output DIRECTORY  conversion output directory  [default: .]
  --bibliography          Generate BibTeX file of all publications in input
                          table
  --dates                 Generate AncientMetagenomeDir dates table of all
                          samples in input table
  --curl                  Generate bash script with curl-based download
                          commands for all libraries of samples in input table
  --aspera                Generate bash script with Aspera-based download
                          commands for all libraries of samples in input table
  --fetchngs              Convert filtered samples and libraries tables to nf-
                          core/fetchngs input tables
  --sratoolkit            Generate bash script with SRA Toolkit fasterq-dump
                          based download commands for all libraries of samples
                          in input table
  --eager                 Convert filtered samples and libraries tables to
                          eager input tables
  --ameta                 Convert filtered samples and libraries tables to
                          aMeta input tables
  --mag                   Convert filtered samples and libraries tables to nf-
                          core/mag input tables
  --taxprofiler           Convert filtered samples and libraries tables to nf-
                          core/taxprofiler input tables
  --help                  Show this message and exit.
```


## amdirt_download

### Tool Description
Download a table from the amdirt repository

### Metadata
- **Docker Image**: quay.io/biocontainers/amdirt:1.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/SPAAM-community/AMDirT
- **Package**: https://anaconda.org/channels/bioconda/packages/amdirt/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: amdirt download [OPTIONS]

  Download a table from the amdirt repository

Options:
  -t, --table [ancientmetagenome-environmental|ancientmetagenome-hostassociated|ancientsinglegenome-hostassociated|test]
                                  AncientMetagenomeDir table to download
                                  [default: ancientmetagenome-hostassociated]
  -y, --table_type [samples|libraries|dates]
                                  Type of table to download  [default:
                                  samples]
  -r, --release [v25.12.2|v25.12.0|v25.09.0|v25.06.0|v25.03.0|v24.12.0|v24.09.0|v24.06.0|v24.03.0|v23.12.0|v23.09.0|v23.06.0|v23.03.0|v22.12.0|v22.09.2|v22.09.1|v22.09]
                                  Release tag to download  [default: v25.12.2]
  -o, --output PATH               Output directory  [default: .]
  --help                          Show this message and exit.
```


## amdirt_merge

### Tool Description
Merges new dataset with existing table

### Metadata
- **Docker Image**: quay.io/biocontainers/amdirt:1.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/SPAAM-community/AMDirT
- **Package**: https://anaconda.org/channels/bioconda/packages/amdirt/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: amdirt merge [OPTIONS] DATASET

  Merges new dataset with existing table
  

  DATASET: path to tsv file of new dataset to merge

Options:
  -n, --table_name [ancientmetagenome-environmental|ancientmetagenome-hostassociated|ancientsinglegenome-hostassociated|test]
                                  [default: ancientmetagenome-hostassociated]
  -t, --table_type [samples|libraries]
                                  [default: libraries]
  -m, --markdown                  Output is in markdown format
  -o, --outdir PATH               path to sample output table file  [default:
                                  .]
  --help                          Show this message and exit.
```


## amdirt_validate

### Tool Description
Run validity check of AncientMetagenomeDir datasets

### Metadata
- **Docker Image**: quay.io/biocontainers/amdirt:1.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/SPAAM-community/AMDirT
- **Package**: https://anaconda.org/channels/bioconda/packages/amdirt/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: amdirt validate [OPTIONS] DATASET SCHEMA

  Run validity check of AncientMetagenomeDir datasets
  
  DATASET: path to tsv file of dataset to check
  SCHEMA: path to JSON schema file

Options:
  -s, --schema_check            Turn on schema checking.
  -d, --line_dup                Turn on line duplicate line checking.
  -c, --columns                 Turn on column presence/absence checking.
  -i, --doi                     Turn on DOI duplicate checking.
  --multi_values TEXT           Check multi-values column for duplicate
                                values.
  -a, --online_archive          Turn on ENA accession validation
  --remote PATH                 [Optional] Path/URL to remote reference sample
                                table for archive accession validation
  -l, --local_json_schema PATH  path to folder with local JSON schemas
  -m, --markdown                Output is in markdown format
  --help                        Show this message and exit.
```


## amdirt_viewer

### Tool Description
A tool to view the AMDIRT Streamlit app.

### Metadata
- **Docker Image**: quay.io/biocontainers/amdirt:1.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/SPAAM-community/AMDirT
- **Package**: https://anaconda.org/channels/bioconda/packages/amdirt/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
2026-02-05 18:01:51.740 
  [33m[1mWarning:[0m to view this Streamlit app on a browser, run it with the following
  command:

    streamlit run /usr/local/bin/amdirt [ARGUMENTS]
Usage: amdirt viewer [OPTIONS]
Try 'amdirt viewer --help' for help.

Error: No such option: --h Did you mean --help?
```


## Metadata
- **Skill**: generated
