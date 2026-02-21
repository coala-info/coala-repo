# blend-bio CWL Generation Report

## blend-bio

### Tool Description
FAIL to generate CWL: blend-bio not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/blend-bio:1.0.0--h577a1d6_3
- **Homepage**: https://github.com/CMU-SAFARI/BLEND
- **Package**: https://anaconda.org/channels/bioconda/packages/blend-bio/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/blend-bio/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/CMU-SAFARI/BLEND
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: blend-bio not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: blend-bio not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## blend-bio_blend

### Tool Description
A fast and accurate tool for mapping and overlapping long and short reads using strobemers and minimizers.

### Metadata
- **Docker Image**: quay.io/biocontainers/blend-bio:1.0.0--h577a1d6_3
- **Homepage**: https://github.com/CMU-SAFARI/BLEND
- **Package**: https://anaconda.org/channels/bioconda/packages/blend-bio/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: blend [options] <target.fa>|<target.idx> [query.fa] [...]
Options:
  Indexing:
    -H           use homopolymer-compressed k-mer (preferrable for PacBio)
    -k INT       k-mer size (no larger than 28) [15]
    -w INT       minimizer window size [500]
    --neighbors INT Combines INT amount of k-mers to generate a seed. [10]
    --fixed-bits INT BLEND uses INT number of bits when generating hash values of seeds rather than using 2*k number of bits. Useful when collision rate needs to be decreased than 2*k bits. Setting this option to 0 uses 2*k bits for hash values. [0]
    --strobemers link minimizers rather than the preceding k-mers of a single minimizer. (Number of minimizers to link is defined by --neighbors.)
    --immediate use the hash values of consecutive k-mers to generate the hash values of seeds (defualt behavior).
    -I NUM       split index for every ~NUM input bases [4G]
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
    -x STR       preset (always applied before other options []
                 - map-pb/map-ont - PacBio CLR/Nanopore vs reference mapping
                 - map-hifi - PacBio HiFi reads vs reference mapping
                 - ava-pb/ava-ont/ava-hifi - PacBio/Nanopore/HiFi read overlap
                 - sr - genomic short-read mapping
```

