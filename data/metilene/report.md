# metilene CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| metilene | PASS |  |
| metilene_input.pl | PASS | synthetic data: bedGraph files cut from the real metilene test matrix (3 samples per group); merged matrix has 9022 rows and every value equals the source matrix; new CWL |
| metilene_output.pl | PASS | metilene test DMR table filtered to 35 DMRs, same count as an awk filter on the same thresholds; table, bedgraph and plot written; new CWL |

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


## metilene_input.pl

### Tool Description
Merge sorted bedGraph files of two groups into the metilene input matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/metilene:0.2.9--h7b50bb2_0
- **Homepage**: http://www.bioinf.uni-leipzig.de/Software/metilene
- **Package**: https://anaconda.org/channels/bioconda/packages/metilene/overview
- **Validation**: PASS

### Original Help Text
```text

    usage:  perl metilene_input.pl --in1 <list> --in2 <list> [--out <string>] [--h1 <string>] [--h2 <string>] [-b <path/prefix>]

    [INPUT]     --in1       comma-seperated list of sorted (!) bedgraph input files of group 1
                --in2       comma-seperated list of sorted (!) bedgraph input files of group 2
                --out       path/file of out file (metilene input) (default: metilene_g1_g2.input, g1 set by -h1 option, g2 set by -h2 option)
                --h1        identifier of group 1 (default: g1)
                --h2        identifier of group 2 (default: g2)
                -b          path/executable of bedtools executable (default: in PATH)
```

## metilene_output.pl

### Tool Description
Filter metilene DMR results and write bedgraph, table and plots.

### Metadata
- **Docker Image**: quay.io/biocontainers/metilene:0.2.9--h7b50bb2_0
- **Homepage**: http://www.bioinf.uni-leipzig.de/Software/metilene
- **Package**: https://anaconda.org/channels/bioconda/packages/metilene/overview
- **Validation**: PASS

### Original Help Text
```text

    usage:  perl metilene_output.pl  -q <query_file> [-o <path_prefix>] [-p  <number>] [-c <number>] [-d <number>] [-l <number>] [-a <string>] [-b <string>]

    [INPUT]     -q          path/filename of metilene DMRs
                -o          path/prefix of output files (default: input_path/)
                -p          maximum (<) adj. p-value (q-value) for output of significant DMRs (default: 0.05)
                -c          minimum (>=) cpgs (default:10)
                -d          minimum mean methylation difference (>=) (default:0.1)
                -l          minimum length of DMR [nt] (>=) (post-processing, default: 0)
                -a          name of group A (default:"g1")
                -b          name of group B (default:"g2")
```

## Metadata
- **Skill**: generated
