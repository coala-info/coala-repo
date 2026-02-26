# revoluzer CWL Generation Report

## revoluzer

### Tool Description
Simulates rearrangements on a genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/revoluzer:0.1.8--hbcc2d2b_0
- **Homepage**: https://gitlab.com/Bernt/revoluzer/
- **Package**: https://anaconda.org/channels/bioconda/packages/revoluzer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/revoluzer/overview
- **Total Downloads**: 4.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
no input file specified
revoluzer_sim -f inputfile [-i] [-c]
-i use intersection mode (default union)
-c use reversals on the same unor. component (default false)
-C circular genomes
```


## Metadata
- **Skill**: generated

## revoluzer_crex

### Tool Description
Process gene orders in a file or process random rearrangement scenario and compare with reconstruction.

### Metadata
- **Docker Image**: quay.io/biocontainers/revoluzer:0.1.8--hbcc2d2b_0
- **Homepage**: https://gitlab.com/Bernt/revoluzer/
- **Package**: https://anaconda.org/channels/bioconda/packages/revoluzer/overview
- **Validation**: PASS
### Original Help Text
```text
usage
mode 1: process a gene orders in a file
  call: crex -f filename [OPTIONS]
mode 2: process random rearrangement scenario
        and compare with reconstruction
  call: crex [OPTIONS]

general options
--linear -l: handle genomes as linear (default: circular)
--bp   : compute with breakpoint scenario [ZhaoBourque07] (default CREx2)
--crex1: compute with CREx1 (default CREx2)

CREx2 options
--wI WEIGHT: weight of an inversion
--wT WEIGHT:weight of a transposition
--wiT WEIGHT: weight of an inverse transposition
--wTDRL WEIGHT: weight of a TDRL
--noalt: don't compute alternatives for linear nodes


CREx1 options
--prinobp: don't construct breakpoint scenario for prime nodes

mode 1 option
--file   -f: specify a filename 

mode 2 options
--length: length of the generated gene orders
--events: number of random events to apply
--repeat: number of repetitions
--affect: max number of elements affected by a rearrangement
--comp: TDRLs affect complete gene order (default: randomly chosen interval)
--wI, --wT, --wiT, --wTDRL: to set rearrangement weights (see CREx2 options)
```

## revoluzer_trex

### Tool Description
trex method selection

### Metadata
- **Docker Image**: quay.io/biocontainers/revoluzer:0.1.8--hbcc2d2b_0
- **Homepage**: https://gitlab.com/Bernt/revoluzer/
- **Package**: https://anaconda.org/channels/bioconda/packages/revoluzer/overview
- **Validation**: PASS
### Original Help Text
```text
unknown parameter --help
usage: trex -f file [-t file] [-o] [-m maxszen] [-s][-w][-S][-W] [-v verbosity]
 -f file: file containing the genomes (and trees)
 -t file: file containing the trees
 -d file: file for dot output
 -v level of verbosity
 -c: circular genomes
crex options
 -o: get alternative bpscenario for prime nodes
 -m maxszen: maximal number of rev+tdrl scenarios 
trex method selection: 
 -s: strong consistency method
 -w: weak consistency method
 -W: parsimounious weak consistency method
the order of the arguments specifies the execution order
```

## revoluzer_distmat

### Tool Description
Compute distance matrix between genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/revoluzer:0.1.8--hbcc2d2b_0
- **Homepage**: https://gitlab.com/Bernt/revoluzer/
- **Package**: https://anaconda.org/channels/bioconda/packages/revoluzer/overview
- **Validation**: PASS
### Original Help Text
```text
no file given
usage :
distmat -f inputfile [OPTIONS]
input options:
 --lindir : treat data as linear directed genomes (default circular)
 --linund : treat data as linear undirected genomes (default circular)
--sign -s : sign handling. default: 
unsigngeneral options:
   --crex: compute CREx distance
   -b: get number of breakpoints
   -i: get number of intervals (-n|-m must be specified)
interval options
   -n: use conserved intervals
   -m: use common intervals
   -M: use global instead of pairwise perfect distance
--lw : weight intervals by length 
output options:
 --header: print column headers in the distance matrix
 --nexus : print nexus format distance matrix
 --list  : print list format instead of matrix
 --version  : print version and exit
```

