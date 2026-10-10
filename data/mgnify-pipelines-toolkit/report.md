# mgnify-pipelines-toolkit CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mgnify-pipelines-toolkit_get_subunits | PASS | output md5sums match the tool's own tests; added the sequence-categorisation directory output |

## mgnify-pipelines-toolkit_get_subunits

### Tool Description
Extract lsu, ssu and 5s and other models

### Metadata
- **Docker Image**: quay.io/biocontainers/mgnify-pipelines-toolkit:1.4.16--pyhdfd78af_0
- **Homepage**: https://github.com/EBI-Metagenomics/mgnify-pipelines-toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/mgnify-pipelines-toolkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mgnify-pipelines-toolkit/overview
- **Total Downloads**: 15.8K
- **Last updated**: 2026-01-31
- **GitHub**: https://github.com/EBI-Metagenomics/mgnify-pipelines-toolkit
- **Stars**: N/A
### Original Help Text
```text
usage: get_subunits [-h] -i INPUT [-p PREFIX] -n NAME
                    [--separate-subunits-by-models]

Extract lsu, ssu and 5s and other models

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input fasta file
  -p PREFIX, --prefix PREFIX
                        prefix for models
  -n NAME, --name NAME  Accession
  --separate-subunits-by-models
                        Create separate files for each kingdon example:
                        sample_SSU_rRNA_eukarya.RF01960.fasta
```

