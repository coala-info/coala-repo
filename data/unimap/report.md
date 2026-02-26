# unimap CWL Generation Report

## unimap

### Tool Description
Unimap is a tool for mapping long sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/unimap:0.1--h577a1d6_7
- **Homepage**: https://github.com/lh3/unimap
- **Package**: https://anaconda.org/channels/bioconda/packages/unimap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/unimap/overview
- **Total Downloads**: 9.5K
- **Last updated**: 2025-09-30
- **GitHub**: https://github.com/lh3/unimap
- **Stars**: N/A
### Original Help Text
```text
Usage: unimap [options] <target.fa>|<target.idx> [query.fa] [...]
Options:
  Indexing:
    -k INT       k-mer size (no larger than 28) [21]
    -w INT       minimizer window size [11]
    -b INT       number of bits for bloom filter [35]
    -d FILE      dump index to FILE []
    -F INT       high k-mer occurrence threshold when indexing [50]
  Mapping:
    -f INT       max minimizer occurrence [1000]
    -g NUM       stop chain enlongation if there are no minimizers in INT-bp [5000]
    -G NUM       max intron length (effective with -xsplice; changing -r) [200k]
    -r NUM       bandwidth used in chaining and DP-based alignment [100000]
    -n INT       minimal number of minimizers on a chain [3]
    -m INT       minimal chaining score (matching bases minus log gap penalty) [40]
    -p FLOAT     min secondary-to-primary score ratio [0.8]
    -N INT[,INT] retain at most INT secondary alignments [10,25]
  Alignment:
    -A INT       matching score [1]
    -B INT       mismatch penalty [3]
    -O INT[,INT] gap open penalty [5,25]
    -E INT[,INT] gap extension penalty; a k-long gap costs min{O1+k*E1,O2+k*E2} [2,1]
    -z INT[,INT] Z-drop score and inversion Z-drop score [400,200]
    -s INT       minimal peak DP alignment score [200]
    -u CHAR      how to find GT-AG. f:transcript strand, b:both strands, n:don't match GT-AG [n]
  Input/Output:
    -c           perform base-alignment and output CIGAR in the PAF format
    -a           perform base-alignment and output in SAM (PAF by default)
    -o FILE      output alignments to FILE [stdout]
    -R STR       SAM read group line in a format like '@RG\tID:foo\tSM:bar' []
    --cs[=STR]   output the cs tag; STR is 'short' (if absent) or 'long' [none]
    --MD         output the MD tag
    -Y           use soft clipping for supplementary alignments
    -t INT       number of threads [3]
    -K NUM       minibatch size for mapping [1G]
    --version    show version number
  Preset:
    -x STR       preset (always applied before other options; see unimap.1 for details) []
                 - ont/clr:  --rmq=no -r10k -A2 -B4 -O4,24 -E2,1 -z400,200 -s80 -K500M
                 - hifi/ccs: --rmq=no -r10k -A1 -B4 -O6,26 -E2,1 -w21 -K500M
                 - asm5:  -A1 -B19 -O39,81 -E2,1 -N50 -w21
                 - asm10: -A1 -B9  -O16,41 -E2,1 -N50 -w21
                 - asm20: -A1 -B4  -O6,26  -E2,1 -N50
                 - splice:hq/splice: spliced alignment

See `man ./unimap.1' for detailed description of these and other advanced command-line options.
```

