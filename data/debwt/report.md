# debwt CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| debwt_deBWT | Failed | image problem: the image has no jellyfish, which deBWT calls for k-mer counting, and deBWT crashes with a segfault on the SARS-CoV-2 genome. |

## debwt_deBWT

### Tool Description
Please make sure your sequence don't contain any uncertain characters like 'N'

### Metadata
- **Docker Image**: quay.io/biocontainers/debwt:1.0.1--h577a1d6_8
- **Homepage**: https://github.com/DixianZhu/deBWT
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/debwt/overview
- **Total Downloads**: 8.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/DixianZhu/deBWT
- **Stars**: N/A
### Original Help Text
```text
usage:
deBWT [options] reference
Please make sure your sequence don't contain any uncertain characters like 'N'
options:
-o: output bwt file(binary)
-t (optional): maximum thread number(default 8)
-k (optional): k-mer length (from 12 to 32, default 32)
-j: jellyfish directory
reference: sequence in fasta or fastq format
```

