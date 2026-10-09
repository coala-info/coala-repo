# manormfast CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| manormfast_MAnormFast | Failed | image problem: the MAnormFast script is Python 2 code and gives SyntaxError on the image's Python 3.6 |

## manormfast_MAnormFast

### Tool Description
MAnormFast is a tool for analyzing MAnorm data.

### Metadata
- **Docker Image**: quay.io/biocontainers/manormfast:0.1.2--py36_1
- **Homepage**: https://github.com/semal/MAnormFast
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/manormfast/overview
- **Total Downloads**: 11.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/semal/MAnormFast
- **Stars**: N/A
### Original Help Text
```text
File "/usr/local/bin/MAnormFast", line 95
    print '@error: folder name "%s" already exist, please change the output folder name!' % output_folder
                                                                                        ^
SyntaxError: Missing parentheses in call to 'print'
```

