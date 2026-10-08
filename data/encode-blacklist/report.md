# encode-blacklist CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| encode-blacklist_Blacklist | Failed | image problem: the Blacklist program stops with an illegal instruction (exit 132) on the demo data, even with plain docker run |

## encode-blacklist_Blacklist

### Tool Description
Blacklist is used to generate the ENCODE blacklists for various species.

### Metadata
- **Docker Image**: quay.io/biocontainers/encode-blacklist:2.0--h06902ac_6
- **Homepage**: https://github.com/Boyle-Lab/Blacklist
- **Package**: https://anaconda.org/channels/bioconda/packages/encode-blacklist/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/encode-blacklist/overview
- **Total Downloads**: 8.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Boyle-Lab/Blacklist
- **Stars**: N/A
### Original Help Text
```text
Blacklist is used to generate the ENCODE blacklists for various species.
Usage is ./Blacklist <chr>
The program requires an input/ folder containing indexed bam files.
The program requires a mappability/ folder containing Umap mappability files.
```

