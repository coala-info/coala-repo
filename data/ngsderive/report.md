# ngsderive CWL Generation Report

## ngsderive_readlen

### Tool Description
Derives read length distribution from sequencing files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngsderive:4.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/claymcleod/ngsderive
- **Package**: https://anaconda.org/channels/bioconda/packages/ngsderive/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ngsderive/overview
- **Total Downloads**: 30.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/claymcleod/ngsderive
- **Stars**: N/A
### Original Help Text
```text
usage: ngsderive readlen [-h] [-o OUTFILE] [--debug] [-v]
                         [-c MAJORITY_VOTE_CUTOFF] [-n N_READS]
                         ngsfiles [ngsfiles ...]

positional arguments:
  ngsfiles              Next-generation sequencing files to process (BAM or FASTQ).

options:
  -h, --help            show this help message and exit
  -o OUTFILE, --outfile OUTFILE
                        Write to filename rather than standard out. (default: stdout)
  --debug               Enable DEBUG log level. (default: False)
  -v, --verbose         Enable INFO log level. (default: False)
  -c MAJORITY_VOTE_CUTOFF, --majority-vote-cutoff MAJORITY_VOTE_CUTOFF
                        To call a majority readlen, the maximum read length must have at least `majority-vote-cutoff`% reads in support. (default: 70)
  -n N_READS, --n-reads N_READS
                        How many reads to analyze from the start of the file. Any n < 1 to parse whole file. (default: -1)
```


## ngsderive_instrument

### Tool Description
Process Next-generation sequencing files (BAM or FASTQ) to derive instrument information.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngsderive:4.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/claymcleod/ngsderive
- **Package**: https://anaconda.org/channels/bioconda/packages/ngsderive/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ngsderive instrument [-h] [-o OUTFILE] [--debug] [-v] [-n N_READS]
                            ngsfiles [ngsfiles ...]

positional arguments:
  ngsfiles              Next-generation sequencing files to process (BAM or FASTQ).

options:
  -h, --help            show this help message and exit
  -o OUTFILE, --outfile OUTFILE
                        Write to filename rather than standard out. (default: stdout)
  --debug               Enable DEBUG log level. (default: False)
  -v, --verbose         Enable INFO log level. (default: False)
  -n N_READS, --n-reads N_READS
                        How many reads to analyze from the start of the file. Any n < 1 to parse whole file. (default: 10000)
```


## ngsderive_strandedness

### Tool Description
Derive strandedness from NGS files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngsderive:4.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/claymcleod/ngsderive
- **Package**: https://anaconda.org/channels/bioconda/packages/ngsderive/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ngsderive strandedness [-h] [-o OUTFILE] [--debug] [-v] -g GENE_MODEL
                              [--max-tries MAX_TRIES]
                              [--max-iterations-per-try MAX_ITERATIONS_PER_TRY]
                              [-m MINIMUM_READS_PER_GENE] [-n N_GENES]
                              [-q MIN_MAPQ]
                              [--only-protein-coding-genes | --no-only-protein-coding-genes]
                              [--split-by-rg | --no-split-by-rg]
                              ngsfiles [ngsfiles ...]

positional arguments:
  ngsfiles              Next-generation sequencing files to process (BAM or FASTQ).

options:
  -h, --help            show this help message and exit
  -o OUTFILE, --outfile OUTFILE
                        Write to filename rather than standard out. (default: stdout)
  --debug               Enable DEBUG log level. (default: False)
  -v, --verbose         Enable INFO log level. (default: False)
  -g GENE_MODEL, --gene-model GENE_MODEL
                        Gene model as a GFF/GTF file. (default: None)
  --max-tries MAX_TRIES
                        When inconclusive, the test will repeat until this many tries have been reached. Evidence of previous attempts is saved and reused, leading to a larger sample size with multiple attempts. (default: 3)
  --max-iterations-per-try MAX_ITERATIONS_PER_TRY
                        At most, search this many times for genes that satisfy our search criteria. Default is 10 * n-genes. (default: None)
  -m MINIMUM_READS_PER_GENE, --minimum-reads-per-gene MINIMUM_READS_PER_GENE
                        Filter any genes that don't have at least `m` reads. (default: 10)
  -n N_GENES, --n-genes N_GENES
                        How many genes to sample. (default: 1000)
  -q MIN_MAPQ, --min-mapq MIN_MAPQ
                        Minimum MAPQ to consider for reads. (default: 30)
  --only-protein-coding-genes
                        Only consider protein coding genes (default: True)
  --no-only-protein-coding-genes
  --split-by-rg         Contain one entry per read group. (default: True)
  --no-split-by-rg
```


## ngsderive_encoding

### Tool Description
Encodes sequencing files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngsderive:4.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/claymcleod/ngsderive
- **Package**: https://anaconda.org/channels/bioconda/packages/ngsderive/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ngsderive encoding [-h] [-o OUTFILE] [--debug] [-v] [-n N_READS]
                          ngsfiles [ngsfiles ...]

positional arguments:
  ngsfiles              Next-generation sequencing files to process (BAM or FASTQ).

options:
  -h, --help            show this help message and exit
  -o OUTFILE, --outfile OUTFILE
                        Write to filename rather than standard out. (default: stdout)
  --debug               Enable DEBUG log level. (default: False)
  -v, --verbose         Enable INFO log level. (default: False)
  -n N_READS, --n-reads N_READS
                        How many reads to analyze from the start of the file. Any n < 1 to parse whole file. (default: 1000000)
```


## ngsderive_junction-annotation

### Tool Description
Annotate junctions from NGS files based on a gene model.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngsderive:4.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/claymcleod/ngsderive
- **Package**: https://anaconda.org/channels/bioconda/packages/ngsderive/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ngsderive junction-annotation [-h] [-o OUTFILE] [--debug] [-v] -g
                                     GENE_MODEL [-j JUNCTION_FILES_DIR] [-d]
                                     [-i MIN_INTRON] [-q MIN_MAPQ]
                                     [-m MIN_READS]
                                     [-k FUZZY_JUNCTION_MATCH_RANGE] [-c]
                                     ngsfiles [ngsfiles ...]

positional arguments:
  ngsfiles              Next-generation sequencing files to process (BAM or FASTQ).

options:
  -h, --help            show this help message and exit
  -o OUTFILE, --outfile OUTFILE
                        Write to filename rather than standard out. (default: stdout)
  --debug               Enable DEBUG log level. (default: False)
  -v, --verbose         Enable INFO log level. (default: False)
  -g GENE_MODEL, --gene-model GENE_MODEL
                        Gene model as a GFF/GTF file. (default: None)
  -j JUNCTION_FILES_DIR, --junction-files-dir JUNCTION_FILES_DIR
                        Directory to write annotated junction files to. (default: ./)
  -d, --disable-junction-files
                        Disable generating junction files. (default: False)
  -i MIN_INTRON, --min-intron MIN_INTRON
                        Minimum size of intron to be considered a splice. (default: 50)
  -q MIN_MAPQ, --min-mapq MIN_MAPQ
                        Minimum MAPQ to consider for supporting reads. (default: 30)
  -m MIN_READS, --min-reads MIN_READS
                        Filter any junctions that don't have at least `m` reads. (default: 2)
  -k FUZZY_JUNCTION_MATCH_RANGE, --fuzzy-junction-match-range FUZZY_JUNCTION_MATCH_RANGE
                        Consider found splices within `+-k` bases of a known splice event annotated. (default: 0)
  -c, --consider-unannotated-references-novel
                        For the summary report, consider all events on unannotated reference sequences `complete_novel`. Default is to exclude them from the summary. Either way, they will be annotated as `unannotated_reference` in the junctions file. (default: False)
```


## ngsderive_endedness

### Tool Description
Derive the endedness of Next-Generation Sequencing files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngsderive:4.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/claymcleod/ngsderive
- **Package**: https://anaconda.org/channels/bioconda/packages/ngsderive/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ngsderive endedness [-h] [-o OUTFILE] [--debug] [-v] [-n N_READS]
                           [-p PAIRED_DEVIANCE] [-r] [--round-rpt]
                           [--split-by-rg | --no-split-by-rg]
                           ngsfiles [ngsfiles ...]

positional arguments:
  ngsfiles              Next-generation sequencing files to process (BAM or FASTQ).

options:
  -h, --help            show this help message and exit
  -o OUTFILE, --outfile OUTFILE
                        Write to filename rather than standard out. (default: stdout)
  --debug               Enable DEBUG log level. (default: False)
  -v, --verbose         Enable INFO log level. (default: False)
  -n N_READS, --n-reads N_READS
                        How many reads to analyze from the start of the file. Any n < 1 to parse whole file. (default: -1)
  -p PAIRED_DEVIANCE, --paired-deviance PAIRED_DEVIANCE
                        Distance from 0.5 split between number of f+l- reads and f-l+ reads allowed to be called 'Paired-End'. Default of `0.0` only appropriate if the whole file is being processed. (default: 0.0)
  -r, --calc-rpt        Calculate and output Reads-Per-Template. This will produce a more sophisticated estimate for endedness, but uses substantially more memory (can reach up to 60-70% of BAM size in memory consumption). (default: False)
  --round-rpt           Round RPT to the nearest INT before comparing to expected values. Appropriate if using `-n` > 0. (default: False)
  --split-by-rg         Contain one entry per read group. (default: True)
  --no-split-by-rg
```


## Metadata
- **Skill**: generated
