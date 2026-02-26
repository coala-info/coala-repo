# ptgaul CWL Generation Report

## ptgaul_ptGAUL.sh

### Tool Description
this pipeline is used for plastome assembly using long read data.

### Metadata
- **Docker Image**: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
- **Homepage**: https://github.com/Bean061/ptgaul
- **Package**: https://anaconda.org/channels/bioconda/packages/ptgaul/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ptgaul/overview
- **Total Downloads**: 4.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Bean061/ptgaul
- **Stars**: N/A
### Original Help Text
```text
Usage: ptGAUL.sh -r (REFERENCE FILE) -l (LONG READ FILE)

                 [-t threads int] [-g genome size int]
                 [-c coverage int] [-f filter threshold int]
                 [-o output directory string]

this pipeline is used for plastome assembly using long read data.

optional arguments: 
-h, --help            <show this help message and exit>
-r, --reference       <MANDATORY: reference contigs or scaffolds in fasta format>
-l, --longreads       <MANDATORY: raw long reads in fasta/fastq/fq.gz format>
-t, --threads         <number of threads, default:1>
-g, --genomesize      <expected genome size of plastome (bp), default:160000>
-c, --coverage        <a rough coverage of data used for plastome assembly, default:50>
-f, --filtered        <the raw long reads will be filtered if the lengths are less than this number (bp); default: 3000>
-o, --outputdir       <output directory of results, defult is current directory>


                     _____           _        _         _    _
  ___      _       /  ___  \       / _ \     | |       | |  | |
 / _ \    | |     / /     \ \     / / \ \    | |       | |  | |
/ / \ \ __| |__  | |       \_|    / / \ \    | |       | |  | |
||   |||__   __| | |             / / _ \ \   | |       | |  | |
| \_/ /   | |    | |      ___    /  ___  \   | |       | |  | |
|  __/    | |_   | |     |__ |  / /     \ \  \ \       / /  | |        _
| |       |   |   \ \ ___ / /   / /     \ \   \ \ ___ / /   | | _____ | |
|_|       |__/     \ _____ /   /_/       \_\   \ _____ /    | _________ |






                     _____           _        _         _    _
  ___      _       /  ___  \       / _ \     | |       | |  | |
 / _ \    | |     / /     \ \     / / \ \    | |       | |  | |
/ / \ \ __| |__  | |       \_|    / / \ \    | |       | |  | |
||   |||__   __| | |             / / _ \ \   | |       | |  | |
| \_/ /   | |    | |      ___    /  ___  \   | |       | |  | |
|  __/    | |_   | |     |__ |  / /     \ \  \ \       / /  | |        _
| |       |   |   \ \ ___ / /   / /     \ \   \ \ ___ / /   | | _____ | |
|_|       |__/     \ _____ /   /_/       \_\   \ _____ /    | _________ |
```


## ptgaul_combine_gfa.py

### Tool Description
This script is used to merge the edges from assembly graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
- **Homepage**: https://github.com/Bean061/ptgaul
- **Package**: https://anaconda.org/channels/bioconda/packages/ptgaul/overview
- **Validation**: PASS

### Original Help Text
```text
usage: combine_gfa.py [-h] [-e INPUT_EDGES] [-d SORTED_DEPTH_FILE]
                      [-o OUTPUTDIR]

This script is used to merge the edges from assembly graph.

optional arguments:
  -h, --help            show this help message and exit
  -e INPUT_EDGES, --input_edges_file INPUT_EDGES
                        input edge fasta file
  -d SORTED_DEPTH_FILE, --sorted_depth SORTED_DEPTH_FILE
                        input depth file
  -o OUTPUTDIR, --outputdir OUTPUTDIR
                        output directory
```


## ptgaul_minimap2

### Tool Description
A versatile pairwise aligner for genomic and transcribed nucleotide sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
- **Homepage**: https://github.com/Bean061/ptgaul
- **Package**: https://anaconda.org/channels/bioconda/packages/ptgaul/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: minimap2 [options] <target.fa>|<target.idx> [query.fa] [...]
Options:
  Indexing:
    -H           use homopolymer-compressed k-mer (preferrable for PacBio)
    -k INT       k-mer size (no larger than 28) [15]
    -w INT       minimizer window size [10]
    -I NUM       split index for every ~NUM input bases [8G]
    -d FILE      dump index to FILE []
  Mapping:
    -f FLOAT     filter out top FLOAT fraction of repetitive minimizers [0.0002]
    -g NUM       stop chain enlongation if there are no minimizers in INT-bp [5000]
    -G NUM       max intron length (effective with -xsplice; changing -r) [200k]
    -F NUM       max fragment length (effective with -xsr or in the fragment mode) [800]
    -r NUM[,NUM] chaining/alignment bandwidth and long-join bandwidth [500,20000]
    -n INT       minimal number of minimizers on a chain [3]
    -m INT       minimal chaining score (matching bases minus log gap penalty) [40]
    -X           skip self and dual mappings (for the all-vs-all mode)
    -p FLOAT     min secondary-to-primary score ratio [0.8]
    -N INT       retain at most INT secondary alignments [5]
  Alignment:
    -A INT       matching score [2]
    -B INT       mismatch penalty (larger value for lower divergence) [4]
    -O INT[,INT] gap open penalty [4,24]
    -E INT[,INT] gap extension penalty; a k-long gap costs min{O1+k*E1,O2+k*E2} [2,1]
    -z INT[,INT] Z-drop score and inversion Z-drop score [400,200]
    -s INT       minimal peak DP alignment score [80]
    -u CHAR      how to find GT-AG. f:transcript strand, b:both strands, n:don't match GT-AG [n]
    -J INT       splice mode. 0: original minimap2 model; 1: miniprot model [1]
  Input/Output:
    -a           output in the SAM format (PAF by default)
    -o FILE      output alignments to FILE [stdout]
    -L           write CIGAR with >65535 ops at the CG tag
    -R STR       SAM read group line in a format like '@RG\tID:foo\tSM:bar' []
    -c           output CIGAR in PAF
    --cs[=STR]   output the cs tag; STR is 'short' (if absent) or 'long' [none]
    --MD         output the MD tag
    --eqx        write =/X CIGAR operators
    -Y           use soft clipping for supplementary alignments
    -t INT       number of threads [3]
    -K NUM       minibatch size for mapping [500M]
    --version    show version number
  Preset:
    -x STR       preset (always applied before other options; see minimap2.1 for details) []
                 - map-pb/map-ont - PacBio CLR/Nanopore vs reference mapping
                 - map-hifi - PacBio HiFi reads vs reference mapping
                 - ava-pb/ava-ont - PacBio/Nanopore read overlap
                 - asm5/asm10/asm20 - asm-to-ref mapping, for ~0.1/1/5% sequence divergence
                 - splice/splice:hq - long-read/Pacbio-CCS spliced alignment
                 - sr - genomic short-read mapping

See `man ./minimap2.1' for detailed description of these and other advanced command-line options.
```


## ptgaul_gunzip

### Tool Description
Decompress FILEs (or stdin)

### Metadata
- **Docker Image**: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
- **Homepage**: https://github.com/Bean061/ptgaul
- **Package**: https://anaconda.org/channels/bioconda/packages/ptgaul/overview
- **Validation**: PASS

### Original Help Text
```text
BusyBox v1.32.1 (2021-04-13 11:15:36 UTC) multi-call binary.

Usage: gunzip [-cfkt] [FILE]...

Decompress FILEs (or stdin)

	-c	Write to stdout
	-f	Force
	-k	Keep input files
	-t	Test file integrity
```


## ptgaul_awk

### Tool Description
Pattern scanning and processing language

### Metadata
- **Docker Image**: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
- **Homepage**: https://github.com/Bean061/ptgaul
- **Package**: https://anaconda.org/channels/bioconda/packages/ptgaul/overview
- **Validation**: PASS

### Original Help Text
```text
BusyBox v1.32.1 (2021-04-13 11:15:36 UTC) multi-call binary.

Usage: awk [OPTIONS] [AWK_PROGRAM] [FILE]...

	-v VAR=VAL	Set variable
	-F SEP		Use SEP as field separator
	-f FILE		Read program from FILE
	-e AWK_PROGRAM
```


## ptgaul_sort

### Tool Description
Sort lines of text

### Metadata
- **Docker Image**: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
- **Homepage**: https://github.com/Bean061/ptgaul
- **Package**: https://anaconda.org/channels/bioconda/packages/ptgaul/overview
- **Validation**: PASS

### Original Help Text
```text
BusyBox v1.32.1 (2021-04-13 11:15:36 UTC) multi-call binary.

Usage: sort [-nrugMcszbdfiokt] [-o FILE] [-k start[.offset][opts][,end[.offset][opts]] [-t CHAR] [FILE]...

Sort lines of text

	-o FILE	Output to FILE
	-c	Check whether input is sorted
	-b	Ignore leading blanks
	-f	Ignore case
	-i	Ignore unprintable characters
	-d	Dictionary order (blank or alphanumeric only)
	-n	Sort numbers
	-g	General numerical sort
	-M	Sort month
	-V	Sort version
	-t CHAR	Field separator
	-k N[,M] Sort by Nth field
	-r	Reverse sort order
	-s	Stable (don't sort ties alphabetically)
	-u	Suppress duplicate lines
	-z	Lines are terminated by NUL, not newline
```


## ptgaul_tr

### Tool Description
Translate, squeeze, or delete characters from stdin, writing to stdout

### Metadata
- **Docker Image**: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
- **Homepage**: https://github.com/Bean061/ptgaul
- **Package**: https://anaconda.org/channels/bioconda/packages/ptgaul/overview
- **Validation**: PASS

### Original Help Text
```text
BusyBox v1.32.1 (2021-04-13 11:15:36 UTC) multi-call binary.

Usage: tr [-cds] STRING1 [STRING2]

Translate, squeeze, or delete characters from stdin, writing to stdout

	-c	Take complement of STRING1
	-d	Delete input characters coded STRING1
	-s	Squeeze multiple output characters of STRING2 into one character
```

