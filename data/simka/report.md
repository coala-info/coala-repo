# simka CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| simka | PASS |  |
| simka_simkaMin.py | PASS | output matches the tool's own truth matrix |

## simka

### Tool Description
Simka computes pairwise distances between samples based on k-mers.

### Metadata
- **Docker Image**: quay.io/biocontainers/simka:1.5.3--h077b44d_5
- **Homepage**: https://github.com/GATB/simka
- **Package**: https://anaconda.org/channels/bioconda/packages/simka/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/simka/overview
- **Total Downloads**: 22.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/GATB/simka
- **Stars**: N/A
### Original Help Text
```text
ERROR: Unknown parameter '--help'
ERROR: Option '-in' is mandatory
ERROR: Option '-out-tmp' is mandatory
ERROR: Option '-in' is mandatory

[Simka options]
       -in        (1 arg) :    input file of samples. One sample per line: id1: filename1...
       -out       (1 arg) :    output directory for result files (distance matrices)  [default './simka_results']
       -out-tmp   (1 arg) :    output directory for temporary files
       -keep-tmp  (0 arg) :    keep temporary files
       -data-info (0 arg) :    compute (and display) information before running Simka, such as the number of reads per dataset
       -verbose   (1 arg) :    verbosity level  [default '1']
       -version   (0 arg) :    version
       -help      (0 arg) :    help

   [distance options]
          -simple-dist  (0 arg) :    compute all simple distances (Chord, Hellinger...)
          -complex-dist (0 arg) :    compute all complex distances (Jensen-Shannon...)

   [kmer options]
          -kmer-size          (1 arg) :    size of a kmer  [default '21']
          -abundance-min      (1 arg) :    min abundance a kmer need to be considered  [default '2']
          -abundance-max      (1 arg) :    max abundance a kmer can have to be considered  [default '999999999']
          -kmer-shannon-index (1 arg) :    minimal Shannon index a kmer should have to be kept. Float in [0,2]  [default '0']

   [read options]
          -max-reads         (1 arg) :    maximum number of reads per sample to process. Can be -1: use all reads. Can be 0: estimate it  [default '-1']
          -min-read-size     (1 arg) :    minimal size a read should have to be kept  [default '0']
          -min-shannon-index (1 arg) :    minimal Shannon index a read should have to be kept. Float in [0,2]  [default '0']

   [core options]
          -nb-cores   (1 arg) :    number of cores  [default '0']
          -max-memory (1 arg) :    max memory (MB)  [default '5000']
          -max-count  (1 arg) :    maximum number of simultaneous counting jobs (a higher value improve execution time but increase temporary disk usage)  [default '']
          -max-merge  (1 arg) :    maximum number of simultaneous merging jobs (1 job = 1 core)  [default '']

   [cluster options]
          -count-cmd  (1 arg) :    command to submit counting job  [default '']
          -merge-cmd  (1 arg) :    command to submit merging job  [default '']
          -count-file (1 arg) :    filename to the couting job template  [default '']
          -merge-file (1 arg) :    filename to the merging job template  [default '']
```

## simka_simkaMin.py

### Tool Description
SimkaMin computes approximate pairwise distances between samples from a subsample of k-mers.

### Metadata
- **Docker Image**: quay.io/biocontainers/simka:1.5.3--h077b44d_5
- **Homepage**: https://github.com/GATB/simka
- **Package**: https://anaconda.org/channels/bioconda/packages/simka/overview
- **Validation**: PASS

### Original Help Text
```text
[main options]:
  -in                  (1 arg) :    input file of datasets. One sample per line: id1: filename1...
  -out                 (1 arg) :    output directory for result files (distance matrices) [Default: ./simka_results]
  -seed                (1 arg) :    seed used for random k-mer selection [Default: 100]
  -bin                 (1 arg) :    path to simkaMinCore program (to be specified if not in PATH, or not in standard installation directory <simkaDir>/build/bin/simkaMinCore)

[core options]:
  -nb-cores            (1 arg) :    number of cores [Default: 0]
  -max-memory          (1 arg) :    max memory (MB) [Default: 8000]

[k-mer options]:
  -kmer-size           (1 arg) :    size of a kmer [Default: 21]
  -nb-kmers            (1 arg) :    number of kmers used to compute distances [Default: 1000000]
  -filter              (0 arg) :    filter out k-mer seen one time (potentially erroneous)

[read options]:
  -max-reads           (1 arg) :    maximum number of reads per sample to process [Default: 0]
  -min-read-size       (1 arg) :    minimal size a read should have to be kept [Default: 0]
  -min-shannon-index   (1 arg) :    minimal Shannon index a read should have to be kept. Float in [0,2] [Default: 0]
```

