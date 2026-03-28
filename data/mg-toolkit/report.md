# mg-toolkit CWL Generation Report

## mg-toolkit_original_metadata

### Tool Description
Retrieve original metadata for given study accessions using mg-toolkit.

### Metadata
- **Docker Image**: quay.io/biocontainers/mg-toolkit:0.10.4--pyhdfd78af_0
- **Homepage**: https://github.com/EBI-metagenomics/emg-toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/mg-toolkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mg-toolkit/overview
- **Total Downloads**: 8.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/EBI-metagenomics/emg-toolkit
- **Stars**: N/A
### Original Help Text
```text
usage: mg-toolkit original_metadata [-h] -a ACCESSION [ACCESSION ...]

options:
  -h, --help            show this help message and exit
  -a ACCESSION [ACCESSION ...], --accession ACCESSION [ACCESSION ...]
                        Provide study accession, e.g. PRJEB1787 or ERP001736.
```


## mg-toolkit_sequence_search

### Tool Description
Search non-redundant protein database using HMMER.

### Metadata
- **Docker Image**: quay.io/biocontainers/mg-toolkit:0.10.4--pyhdfd78af_0
- **Homepage**: https://github.com/EBI-metagenomics/emg-toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/mg-toolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mg-toolkit sequence_search [-h] -seq SEQUENCE [SEQUENCE ...]
                                  [-out OUTPUT] [-db {full,all,partial}]
                                  {evalue,bitscore} ...

positional arguments:
  {evalue,bitscore}
    evalue              Search non-redundant protein database using HMMER.
    bitscore            Search non-redundant protein database using HMMER.

options:
  -h, --help            show this help message and exit
  -seq SEQUENCE [SEQUENCE ...], --sequence SEQUENCE [SEQUENCE ...]
                        Provide path to fasta file.
  -out OUTPUT, --output OUTPUT
                        Output csv results file (default:
                        <query_id>_sequence_search.csv
  -db {full,all,partial}, --database {full,all,partial}
                        Choose peptide database (default: full).
```


## mg-toolkit_bulk_download

### Tool Description
Bulk download study or project data from MGnify.

### Metadata
- **Docker Image**: quay.io/biocontainers/mg-toolkit:0.10.4--pyhdfd78af_0
- **Homepage**: https://github.com/EBI-metagenomics/emg-toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/mg-toolkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mg-toolkit bulk_download [-h] -a ACCESSION [-o OUTPUT_PATH]
                                [-p {1.0,2.0,3.0,4.0,4.1,5.0}]
                                [-g {statistics,sequence_data,functional_analysis,taxonomic_analysis,taxonomic_analysis_ssu_rrna,taxonomic_analysis_lsu_rrna,non-coding_rnas,taxonomic_analysis_itsonedb,taxonomic_analysis_unite,taxonomic_analysis_motu,pathways_and_systems}]

options:
  -h, --help            show this help message and exit
  -a ACCESSION, --accession ACCESSION
                        Provide the study/project accession of your interest, e.g. ERP001736, SRP000319. The study must be publicly available in MGnify.
  -o OUTPUT_PATH, --output_path OUTPUT_PATH
                        Location of the output directory, where the downloadable files are written to.
                        DEFAULT: CWD
  -p {1.0,2.0,3.0,4.0,4.1,5.0}, --pipeline {1.0,2.0,3.0,4.0,4.1,5.0}
                        Specify the version of the pipeline you are interested in. 
                        Lets say your study of interest has been analysed with 
                        multiple version, but you are only interested in a particular 
                        version then used this option to filter down the results by 
                        the version you interested in.
                        DEFAULT: Downloads all versions
  -g {statistics,sequence_data,functional_analysis,taxonomic_analysis,taxonomic_analysis_ssu_rrna,taxonomic_analysis_lsu_rrna,non-coding_rnas,taxonomic_analysis_itsonedb,taxonomic_analysis_unite,taxonomic_analysis_motu,pathways_and_systems}, --result_group {statistics,sequence_data,functional_analysis,taxonomic_analysis,taxonomic_analysis_ssu_rrna,taxonomic_analysis_lsu_rrna,non-coding_rnas,taxonomic_analysis_itsonedb,taxonomic_analysis_unite,taxonomic_analysis_motu,pathways_and_systems}
                        Provide a single result group if needed.
                        Supported result groups are:
                         - statistics
                         - sequence_data (all versions)
                         - functional_analysis (all versions)
                         - taxonomic_analysis (1.0-3.0)
                         - taxonomic_analysis_ssu_rrna (>=4.0)
                         - taxonomic_analysis_lsu_rrna (>=4.0)
                         - non-coding_rnas (>=4.0)
                         - taxonomic_analysis_itsonedb (>= 5.0)
                         - taxonomic_analysis_unite (>= 5.0)
                         - taxonomic_analysis_motu  (>= 5.0)
                         - pathways_and_systems (>= 5.0)
                        DEFAULT: Downloads all result groups if not provided.
                        (default: None).
```


## Metadata
- **Skill**: generated
