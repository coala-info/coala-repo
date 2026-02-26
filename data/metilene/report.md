# metilene CWL Generation Report

## metilene

### Tool Description
metilene - a tool for fast and sensitive detection of differential DNA methylation

### Metadata
- **Docker Image**: quay.io/biocontainers/metilene:0.2.9--h7b50bb2_0
- **Homepage**: http://www.bioinf.uni-leipzig.de/Software/metilene
- **Package**: https://anaconda.org/channels/bioconda/packages/metilene/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metilene/overview
- **Total Downloads**: 22.7K
- **Last updated**: 2025-12-15
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
metilene: no source file provided.
usage: metilene [-M <n>] [-G <n>] [-m <n>] [-d <n>] [-t <n>] [-f <n>] [-c <n>] [-a <string>] [-b <string>] [-B <string>] [-X <n>] [-Y <n>] [-s <n>] [-v <n>]  DataInputfile
  metilene - a tool for fast and sensitive detection of differential DNA methylation

DataInputFile		needs to be SORTED for chromosomes and genomic positions
 -M, --maxdist <n>      maximum distance (default:300)
 -G, --maxseg <n>       maximum segment length in case of memory issues (default:-1)
 -m, --mincpgs <n>      minimum cpgs (default:10)
 -d, --minMethDiff <n>  minimum mean methylation difference (default:0.100000)
 -t, --threads <n>      number of threads (default:1)
 -f, --mode <n>         number of method: 1: de-novo, 2: pre-defined regions, 3: DMCs (default:1)
 -c, --mtc <n>          method of multiple testing correction: 1: Bonferroni, 2: Benjamini-Hochberg (FDR) (default:1)
 -a, --groupA <string>  name of group A (default:"g1")
 -b, --groupB <string>  name of group B (default:"g2")
 -B, --bed <string>     bed-file for mode 2 containing pre-defined regions; needs to be SORTED equally to the DataInputFile (default:none)
 -X, --minNoA <n>       minimal number of values in group A (default:-1)
 -Y, --minNoB <n>       minimal number of values in group B (default:-1)
 -s, --seed <n>         set seed for random generator (default:26061981)
 -v, --valley <n>       valley filter (0.0 - 1.0) (default:0.700000)
 [VERSION]
  0.2.9
 [BUGS]
  Please report bugs to [frank,steve]@bioinf.uni-leipzig.de
 [REFERENCES]
  Implemented by Frank Juehling and Steve Hoffmann
  2015-2016 Bioinformatik Leipzig
```


## Metadata
- **Skill**: generated
