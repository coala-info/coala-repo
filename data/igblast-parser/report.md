# igblast-parser CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| igblast-parser | PASS | fixed baseCommand (igblast-parser, not python) and options; IgBLAST output for 100 real airrflow BCR reads (made with igblastn from the igdiscover image) gives 100 rows with matching V/D/J calls; note: the tool drops the first character of each query id |

## igblast-parser

### Tool Description
Parses IGBLAST output.

### Metadata
- **Docker Image**: quay.io/biocontainers/igblast-parser:0.0.4--py39hf95cd2a_6
- **Homepage**: https://github.com/aerijman/igblast-parser
- **Package**: https://anaconda.org/channels/bioconda/packages/igblast-parser/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/igblast-parser/overview
- **Total Downloads**: 14.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/aerijman/igblast-parser
- **Stars**: N/A
### Original Help Text
```text
igblast_output | python <this script> --out <out_filename_prefix>

                    python <this script --in <igblast_output> --out <out_filename_prefix>
```

