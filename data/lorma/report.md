# lorma CWL Generation Report

## lorma_lorma.sh

### Tool Description
Processes FASTA files with LoRDEC steps.

### Metadata
- **Docker Image**: quay.io/biocontainers/lorma:0.4--2
- **Homepage**: https://www.cs.helsinki.fi/u/lmsalmel/LoRMA/
- **Package**: https://anaconda.org/channels/bioconda/packages/lorma/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lorma/overview
- **Total Downloads**: 6.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/local/bin/lorma.sh [-s] [-n] [-start <19> -end <61> -step <21> -threads <6> -friends <7> -k <19>] *.fasta
	-s saves the sequence data of intermediate LoRDEC steps
	-n skips LoRDEC steps
```


## lorma_LoRMA

### Tool Description
LoRMA options

### Metadata
- **Docker Image**: quay.io/biocontainers/lorma:0.4--2
- **Homepage**: https://www.cs.helsinki.fi/u/lmsalmel/LoRMA/
- **Package**: https://anaconda.org/channels/bioconda/packages/lorma/overview
- **Validation**: PASS

### Original Help Text
```text
ERROR: Unknown parameter '--help'
ERROR: Option '-discarded' is mandatory
ERROR: Option '-output' is mandatory
ERROR: Option '-reads' is mandatory

[LoRMA options]
       -bestfriends (1 arg) :    Number of best friends  [default '3']
       -friends     (1 arg) :    Number of friends  [default '7']
       -k           (1 arg) :    kmer length  [default '31']
       -discarded   (1 arg) :    output file for discarded reads
       -output      (1 arg) :    output file for corrected reads
       -reads       (1 arg) :    file(s) of long reads
       -nb-cores    (1 arg) :    number of cores  [default '1']
       -verbose     (1 arg) :    verbosity level  [default '1']
```


## Metadata
- **Skill**: generated
