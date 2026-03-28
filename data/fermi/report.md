# fermi CWL Generation Report

## fermi_build

### Tool Description
Build an FM-index for a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
- **Homepage**: https://github.com/quantumlib/OpenFermion
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fermi/overview
- **Total Downloads**: 9.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/quantumlib/OpenFermion
- **Stars**: N/A
### Original Help Text
```text
Usage:   fermi build [options] <in.fa>

Options: -b INT    use a small marker per 2^(INT+3) bytes [3]
         -f        force to overwrite the output file (effective with -o)
         -i FILE   append the FM-index to the existing FILE [null]
         -l INT    trim read down to INT bp [inf]
         -o FILE   output file name [null]
         -O        do not trim 1bp for reads whose forward and reverse are identical
         -s INT    number of symbols to process at a time [250000000]
```


## fermi_ropebwt

### Tool Description
Compresses DNA sequences using the Burrows-Wheeler Transform.

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
- **Homepage**: https://github.com/quantumlib/OpenFermion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:   ropebwt [options] <in.fq.gz>

Options: -a STR     algorithm: bpr or bcr [bpr]
         -r INT     max number of runs in leaves (bpr only) [512]
         -n INT     max number children per internal node (bpr only) [64]
         -o FILE    output file [stdout]
         -f FILE    temporary sequence file name (bcr only) [null]
         -v INT     verbose level (bcr only) [2]
         -b         binary output (5+3 runs starting after 4 bytes)
         -t         enable threading (bcr only)
         -F         skip forward strand
         -R         skip reverse strand
         -N         cut at ambiguous bases
         -O         suppress end trimming when forward==reverse
         -T         print the tree stdout (bpr only)
```


## fermi_chkbwt

### Tool Description
Check the BWT index file

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
- **Homepage**: https://github.com/quantumlib/OpenFermion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:   fermi chkbwt [options] <idxbase.bwt>

Options: -M        load the FM-index as a memory mapped file
         -r        check rank
         -p        print the BWT to the stdout
```


## fermi_merge

### Tool Description
Merge BWT indexes

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
- **Homepage**: https://github.com/quantumlib/OpenFermion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:   fermi merge [-f] [-o out.bwt] [-t nThreads] <in0.bwt> <in1.bwt> [...]

Options: -f        force to overwrite the output file (effective with -o)
         -o FILE   output file name [null]
         -t INT    number of threads to use
```


## fermi_unpack

### Tool Description
Unpack a BWT sequence file

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
- **Homepage**: https://github.com/quantumlib/OpenFermion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:   fermi unpack [-M] [-i index] <seqs.bwt>

Options: -i INT    index of the read to output, starting from 0 [null]
         -M        load the FM-index as a memory mapped file
```


## fermi_exact

### Tool Description
Exact algorithm for sequence alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
- **Homepage**: https://github.com/quantumlib/OpenFermion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
exact: invalid option -- '-'
exact: invalid option -- 'h'
exact: invalid option -- 'e'
exact: invalid option -- 'l'
exact: invalid option -- 'p'
Usage: fermi exact [-Ms] <idxbase.bwt> <src.fa>
```


## fermi_correct

### Tool Description
Correct errors in reads using an FMD-index.

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
- **Homepage**: https://github.com/quantumlib/OpenFermion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:   fermi correct [options] <reads.fmd> <reads.fq>

Options: -k INT      k-mer length; -1 for auto [-1]
         -O INT      minimum (k+1)-mer occurrences [3]
         -t INT      number of threads [1]
         -C FLOAT    max fraction of corrected bases [0.30]
         -l INT      trim read down to INT bp; 0 to disable [0]
         -s INT      step size for the jumping heuristic; 0 to disable [5]
         -K          keep bad/unfixable reads
```


## fermi_seqrank

### Tool Description
Sorts an FMD-index for Fermi.

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
- **Homepage**: https://github.com/quantumlib/OpenFermion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
seqrank: invalid option -- '-'
seqrank: invalid option -- 'h'
seqrank: invalid option -- 'e'
seqrank: invalid option -- 'l'
seqrank: invalid option -- 'p'
Usage: fermi seqsort [-t nThreads=1] <reads.fmd>
```


## fermi_unitig

### Tool Description
Generate unitigs from an FMD-index.

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
- **Homepage**: https://github.com/quantumlib/OpenFermion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:   fermi unitig [options] <reads.fmd>

Options: -l INT      min match [30]
         -t INT      number of threads [1]
         -r FILE     rank file [null]
```


## fermi_clean

### Tool Description
Clean a de Bruijn graph

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
- **Homepage**: https://github.com/quantumlib/OpenFermion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:   fermi clean [options] <in.mog>

Options: -N INT      read maximum INT neighbors per node [512]
         -d FLOAT    drop a neighbor if relative overlap ratio below FLOAT [0.70]

         -C          clean the graph
         -l INT      minimum tip length [300]
         -e INT      minimum tip read count [4]
         -i INT      minimum internal unitig read count [3]
         -o INT      minimum overlap [60]
         -R FLOAT    minimum relative overlap ratio [0.80]
         -n INT      number of iterations [3]
         -A          aggressive bubble popping
         -S          skip bubble simplification
         -w FLOAT    minimum coverage to keep a bubble [10.00]
         -r FLOAT    minimum fraction to keep a bubble [0.15]
```


## fermi_remap

### Tool Description
Remap reads to contigs using FMD index

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
- **Homepage**: https://github.com/quantumlib/OpenFermion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:   fermi remap [options] <reads.fmd> <contigs.fq>

Options: -l INT      skip ending INT bases of a read pair [50]
         -c INT      minimum paired-end coverage [0]
         -D INT      maximum insert size (external distance) [1000]
         -r FILE     rank [null]
         -t INT      number of threads [1]
```


## fermi_scaf

### Tool Description
Scaffold contigs using FMD-index and remapped MAG files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
- **Homepage**: https://github.com/quantumlib/OpenFermion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:   fermi scaf <in.fmd> <in.remapped.mag> <avg> <std>

Options: -t INT     number of threads [1]
         -m INT     minimum number of supporting reads [5]
         -P         print the links between unitigs
```


## fermi_contrast

### Tool Description
Contrast two FMD-index based genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
- **Homepage**: https://github.com/quantumlib/OpenFermion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:   fermi contrast <idx1.fmd> <idx1.rank> <1-2.sub> <idx2.fmd> <idx2.rank> <2-1.sub>

Options: -o INT    minimum occurrence [3]
         -t INT    number of threads [1]
         -k INT    k-mer length [55]
```


## fermi_bitand

### Tool Description
Bitwise AND operation on two or more .bit files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
- **Homepage**: https://github.com/quantumlib/OpenFermion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: fermi bitand <in1.bit> <in2.bit> [...]
```


## fermi_sub

### Tool Description
Usage: fermi sub [-c] [-t nThreads] <in.fmd> <array.bits>

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
- **Homepage**: https://github.com/quantumlib/OpenFermion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
sub: invalid option -- '-'
sub: invalid option -- 'h'
sub: invalid option -- 'e'
sub: invalid option -- 'l'
sub: invalid option -- 'p'
Usage: fermi sub [-c] [-t nThreads] <in.fmd> <array.bits>
```


## fermi_splitfa

### Tool Description
Split a FASTQ file into multiple FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
- **Homepage**: https://github.com/quantumlib/OpenFermion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: fermi splitfa <in.fq> <out.prefix> [8]
```


## fermi_trimseq

### Tool Description
Trim low-quality bases from the ends of sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
- **Homepage**: https://github.com/quantumlib/OpenFermion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
trimseq: invalid option -- '-'
trimseq: invalid option -- 'h'
trimseq: invalid option -- 'e'
Usage: fermi trimseq [-N] [-q qual=3] [-l minLen=0] <in.fq>
```


## fermi_fltuniq

### Tool Description
Filter unique sequences from a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
- **Homepage**: https://github.com/quantumlib/OpenFermion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
fltuniq: invalid option -- '-'
fltuniq: invalid option -- 'h'
fltuniq: invalid option -- 'e'
fltuniq: invalid option -- 'l'
fltuniq: invalid option -- 'p'
Usage: fermi fltuniq <in.fa>
```


## fermi_pe2cofq

### Tool Description
Convert paired-end FASTQ to COFF format

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
- **Homepage**: https://github.com/quantumlib/OpenFermion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: fermi pe2cofq <in1.fq> <in2.fq>
```


## fermi_cg2cofq

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
- **Homepage**: https://github.com/quantumlib/OpenFermion
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
[M::main] Version: 1.1-r751-beta
[M::main] CMD: fermi cg2cofq --help
[M::main] Real time: 0.000 sec; CPU: 0.045 sec; RSS: 1.875 MB
```


## fermi_example

### Tool Description
Usage: fermi example [-ceU] [-k ecKmer] [-l utgKmer] <in.fq>

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
- **Homepage**: https://github.com/quantumlib/OpenFermion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
example: invalid option -- '-'
example: invalid option -- 'h'
Usage: fermi example [-ceU] [-k ecKmer] [-l utgKmer] <in.fq>
```


## Metadata
- **Skill**: not generated
