# linkage2allegro CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| linkage2allegro | Failed | tool bug: on real Merlin output the marker column of the LOD file stays blank, because the closest-marker search skips markers that sit exactly on a LOD position |

## linkage2allegro

### Tool Description
Converts linkage format files to other formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/linkage2allegro:2017.3--py35_0
- **Homepage**: https://github.com/BioTools-Tek/linkage-converter
- **Package**: https://anaconda.org/channels/bioconda/packages/linkage2allegro/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/linkage2allegro/overview
- **Total Downloads**: 20.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BioTools-Tek/linkage-converter
- **Stars**: N/A
### Original Help Text
```text
2017.3

/usr/local/bin/linkage2allegro <pedin> <mapin> <PROGRAM> [OPTIONS]

PROGRAM:  genehunter, merlin, simwalk, swiftlink
OPTIONS:
    -l lodfile
    -h haplofile
    -d descentfile
```


## Metadata
- **Skill**: generated
