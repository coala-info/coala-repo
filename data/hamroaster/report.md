# hamroaster CWL Generation Report

## hamroaster_hAMRoaster

### Tool Description
hAMRoaster: A tool for harmonizing AMR gene annotations from multiple sources.

### Metadata
- **Docker Image**: quay.io/biocontainers/hamroaster:2.0--hdfd78af_0
- **Homepage**: https://github.com/ewissel/hAMRoaster
- **Package**: https://anaconda.org/channels/bioconda/packages/hamroaster/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hamroaster/overview
- **Total Downloads**: 4.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ewissel/hAMRoaster
- **Stars**: N/A
### Original Help Text
```text
usage: hAMRoaster [-h] [--version] [--fargene FARGENE] [--shortbred SHORTBRED]
                  [--shortbred_map SHORTBRED_MAP] [--abx_map ABX_MAP]
                  [--db_files DB_FILES] --AMR_key AMR_KEY --name NAME
                  --ham_out HAM_OUT [--groupby_sample GROUPBY_SAMPLE]

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --fargene FARGENE     full path to fARGene output, if included
  --shortbred SHORTBRED
                        full path to shortBRED output (tsv), if included
  --shortbred_map SHORTBRED_MAP
                        full path to shortBRED mapping file, if included and
                        not using default
  --abx_map ABX_MAP     full path to Abx:drug class mapping file, if included
  --db_files DB_FILES   Path to ontology index files, exclude "/" on end of
                        path. Expecting "/aro_categories_index.tsv" in the
                        directory pointed to in this param.
  --AMR_key AMR_KEY     full path to key with known AMR phenotypes, REQUIRED
  --name NAME           an identifier for this analysis run, REQUIRED
  --ham_out HAM_OUT     output file from hAMRonization (tsv), REQUIRED
  --groupby_sample GROUPBY_SAMPLE
                        Should results from the mock community key be examined
                        per sample (True), or as one whole community (False)
```

