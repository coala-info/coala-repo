# dr-disco CWL Generation Report

## dr-disco_bam-extract

### Tool Description
Extracts reads from BAM files that overlap with specified regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
- **Homepage**: https://github.com/yhoogstrate/dr-disco
- **Package**: https://anaconda.org/channels/bioconda/packages/dr-disco/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dr-disco/overview
- **Total Downloads**: 99.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/yhoogstrate/dr-disco
- **Stars**: N/A
### Original Help Text
```text
Usage: dr-disco bam-extract [OPTIONS] REGION1 REGION2 BAM_INPUT_FILE
                            BAM_OUTPUT_FILE

Options:
  --restrict-to-targeted-chromosomes
                                  Excludes reads of which a piece was aligned
                                  to other chromosomes than requested by the
                                  regions.
  --help                          Show this message and exit.
```


## dr-disco_the

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
- **Homepage**: https://github.com/yhoogstrate/dr-disco
- **Package**: https://anaconda.org/channels/bioconda/packages/dr-disco/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: dr-disco [OPTIONS] COMMAND [ARGS]...
Try 'dr-disco --help' for help.

Error: No such command 'the'.
```


## dr-disco_classify

### Tool Description
Classify junctions based on alignment data.

### Metadata
- **Docker Image**: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
- **Homepage**: https://github.com/yhoogstrate/dr-disco
- **Package**: https://anaconda.org/channels/bioconda/packages/dr-disco/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dr-disco classify [OPTIONS] TABLE_INPUT_FILE TABLE_OUTPUT_FILE

Options:
  --only-valid                 Only return results marked as 'valid'
  --blacklist-regions TEXT     Blacklist these regions (BED file)
  --blacklist-junctions TEXT   Blacklist these region-to-region junctions
                               (custom format, see files in ./share/)
  --min-chim-overhang INTEGER  Minimum alignment length on each side of the
                               junction. May need to be set to smaller values
                               for read lengths smaller than 75bp. Larger
                               values are more stringent. [default=50]
  --ffpe                       Lowers the threshold for the relative amount of
                               mismatches, as often found in FFPE material.
                               Note that enabling this option will
                               consequently result in more false positives.
  --help                       Show this message and exit.
```


## dr-disco_rerunning

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
- **Homepage**: https://github.com/yhoogstrate/dr-disco
- **Package**: https://anaconda.org/channels/bioconda/packages/dr-disco/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: dr-disco [OPTIONS] COMMAND [ARGS]...
Try 'dr-disco --help' for help.

Error: No such command 'rerunning'.
```


## dr-disco_detect

### Tool Description
Detects potential discoidin domains in BAM input files.

### Metadata
- **Docker Image**: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
- **Homepage**: https://github.com/yhoogstrate/dr-disco
- **Package**: https://anaconda.org/channels/bioconda/packages/dr-disco/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dr-disco detect [OPTIONS] BAM_INPUT_FILE OUTPUT_FILE

Options:
  -m, --min-e-score INTEGER  Minimal score to initiate pulling sub-graphs
                             (larger numbers boost performance but result in
                             suboptimal results) [default=8]
  --help                     Show this message and exit.
```


## dr-disco_fix

### Tool Description
Fixes an alignment file by removing duplicate reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
- **Homepage**: https://github.com/yhoogstrate/dr-disco
- **Package**: https://anaconda.org/channels/bioconda/packages/dr-disco/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dr-disco fix [OPTIONS] INPUT_ALIGNMENT_FILE OUTPUT_ALIGNMENT_FILE

Options:
  -t, --temp-dir PATH  Path in which temp files are stored (default: /tmp)
  --help               Show this message and exit.
```


## dr-disco_integrate

### Tool Description
Integrates gene annotation and reference sequences for fusion gene estimation and classification.

### Metadata
- **Docker Image**: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
- **Homepage**: https://github.com/yhoogstrate/dr-disco
- **Package**: https://anaconda.org/channels/bioconda/packages/dr-disco/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dr-disco integrate [OPTIONS] TABLE_INPUT_FILE TABLE_OUTPUT_FILE

Options:
  --gtf TEXT    Use gene annotation for estimating fusion genes and improve
                classification of exonic (GTF file)
  --fasta TEXT  Use reference sequences to estimate edit distances to splice
                junction motifs (FASTA file)
  --help        Show this message and exit.
```


## dr-disco_to

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
- **Homepage**: https://github.com/yhoogstrate/dr-disco
- **Package**: https://anaconda.org/channels/bioconda/packages/dr-disco/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: dr-disco [OPTIONS] COMMAND [ARGS]...
Try 'dr-disco --help' for help.

Error: No such command 'to'.
```


## dr-disco_is-blacklisted

### Tool Description
When only a single position is given, only matches with blacklisted regions
from blacklist_regions will be reported.

When both POS1 and POS2 are provided, also blacklisted junctions between
POS1 and POS2 as provided in the blacklist_junctions file will be reported.

Positions need to be formated as chr:pos: chr1:1235 or chr1:12,345

Positions can be made strand specific by adding them between curly brackets:
chr1:12,345(+) or chr2:12345(-)

### Metadata
- **Docker Image**: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
- **Homepage**: https://github.com/yhoogstrate/dr-disco
- **Package**: https://anaconda.org/channels/bioconda/packages/dr-disco/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dr-disco is-blacklisted [OPTIONS] POS1 [POS2]

  When only a single position is given, only matches with blacklisted regions
  from blacklist_regions will be reported.

  When both POS1 and POS2 are provided, also blacklisted junctions between
  POS1 and POS2 as provided in the blacklist_junctions file will be reported.

  Positions need to be formated as chr:pos: chr1:1235 or chr1:12,345

  Positions can be made strand specific by adding them between curly brackets:
  chr1:12,345(+) or chr2:12345(-)

Options:
  --blacklist-regions TEXT
  --blacklist-junctions TEXT  Blacklist these region-to-region junctions
                              (custom format, see files in ./share/)
  --help                      Show this message and exit.
```


## dr-disco_logo-sequence

### Tool Description
Generate logo sequences for regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
- **Homepage**: https://github.com/yhoogstrate/dr-disco
- **Package**: https://anaconda.org/channels/bioconda/packages/dr-disco/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dr-disco logo-sequence [OPTIONS] REGION FASTA_INPUT_FILE
                              FASTA_OUTPUT_FILE_NEGATIVE
                              FASTA_OUTPUT_FILE_POSITIVE

Options:
  -n, --offset-negative INTEGER
  -p, --offset-positive INTEGER
  --help                         Show this message and exit.
```


## dr-disco_after

### Tool Description
Command-line tool for disco identification and analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
- **Homepage**: https://github.com/yhoogstrate/dr-disco
- **Package**: https://anaconda.org/channels/bioconda/packages/dr-disco/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dr-disco [OPTIONS] COMMAND [ARGS]...
Try 'dr-disco --help' for help.

Error: No such command 'after'.
```


## dr-disco_be

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
- **Homepage**: https://github.com/yhoogstrate/dr-disco
- **Package**: https://anaconda.org/channels/bioconda/packages/dr-disco/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: dr-disco [OPTIONS] COMMAND [ARGS]...
Try 'dr-disco --help' for help.

Error: No such command 'be'.
```


## dr-disco_subtract

### Tool Description
Subtracts alignments from another alignment file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
- **Homepage**: https://github.com/yhoogstrate/dr-disco
- **Package**: https://anaconda.org/channels/bioconda/packages/dr-disco/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dr-disco subtract [OPTIONS] INPUT_ALIGNMENT_FILE OUTPUT_ALIGNMENT_FILE

Options:
  -t, --temp-dir PATH  Path in which temp files are stored (default: /tmp)
  --help               Show this message and exit.
```


## dr-disco_unfix

### Tool Description
Unfixes alignment files.

### Metadata
- **Docker Image**: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
- **Homepage**: https://github.com/yhoogstrate/dr-disco
- **Package**: https://anaconda.org/channels/bioconda/packages/dr-disco/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: dr-disco unfix [OPTIONS] INPUT_ALIGNMENT_FILE OUTPUT_ALIGNMENT_FILE

Options:
  -t, --temp-dir PATH  Path in which temp files are stored (default: /tmp)
  --help               Show this message and exit.
```


## Metadata
- **Skill**: generated
