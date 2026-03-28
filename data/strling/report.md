# strling CWL Generation Report

## strling_extract

### Tool Description
Extract STRs from BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/strling:0.6.0--h7b50bb2_0
- **Homepage**: https://github.com/quinlan-lab/STRling
- **Package**: https://anaconda.org/channels/bioconda/packages/strling/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/strling/overview
- **Total Downloads**: 30.8K
- **Last updated**: 2025-12-13
- **GitHub**: https://github.com/quinlan-lab/STRling
- **Stars**: N/A
### Original Help Text
```text
strling extract

Usage:
  strling extract [options] bam bin

Arguments:
  bam              path to bam file
  bin              path bin to output bin file to be created

Options:
  -f, --fasta=FASTA          path to fasta file (required for CRAM)
  -g, --genome-repeats=GENOME_REPEATS
                             optional path to genome repeats file. if it does not exist, it will be created
  -p, --proportion-repeat=PROPORTION_REPEAT
                             proportion of read that is repetitive to be considered as STR (default: 0.8)
  -q, --min-mapq=MIN_MAPQ    minimum mapping quality (does not apply to STR reads) (default: 40)
  -v, --verbose
  -h, --help                 Show this help
```


## strling_merge

### Tool Description
Merge bin files previously created by `strling extract`

### Metadata
- **Docker Image**: quay.io/biocontainers/strling:0.6.0--h7b50bb2_0
- **Homepage**: https://github.com/quinlan-lab/STRling
- **Package**: https://anaconda.org/channels/bioconda/packages/strling/overview
- **Validation**: PASS

### Original Help Text
```text
strling merge

Usage:
  strling merge [options] [bin ...]

Arguments:
  [bin ...]        One or more bin files previously created by `strling extract`

Options:
  -f, --fasta=FASTA          path to fasta file (required if using CRAM input)
  -w, --window=WINDOW        Number of bp within which to search for reads supporting the other side of a bound. Estimated from the insert size distribution by default. (default: -1)
  -m, --min-support=MIN_SUPPORT
                             minimum number of supporting reads required in at least one individual for a locus to be reported (default: 5)
  --chromosome=CHROMOSOME    chromosome to restrict parsing. helps with memory/parallelization for large cohorts (default: -2)
  -c, --min-clip=MIN_CLIP    minimum number of supporting clipped reads for each side of a locus (default: 0)
  -t, --min-clip-total=MIN_CLIP_TOTAL
                             minimum total number of supporting clipped reads for a locus (default: 0)
  -q, --min-mapq=MIN_MAPQ    minimum mapping quality (does not apply to STR reads) (default: 40)
  -l, --bed=BED              Annoated bed file specifying additional STR loci to genotype. Format is: chr start stop repeatunit [name]
  -o, --output-prefix=OUTPUT_PREFIX
                             prefix for output files. Suffix will be -bounds.txt (default: strling)
  -d, --diff-refs            allow bin files generated on a mixture of reference genomes (by default differing references will produce an error). Reports chromosomes in the first bin or -f if provided
  -v, --verbose
  -h, --help                 Show this help
```


## strling_call

### Tool Description
Call STR alleles from BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/strling:0.6.0--h7b50bb2_0
- **Homepage**: https://github.com/quinlan-lab/STRling
- **Package**: https://anaconda.org/channels/bioconda/packages/strling/overview
- **Validation**: PASS

### Original Help Text
```text
strling call

Usage:
  strling call [options] bam bin

Arguments:
  bam              path to bam file
  bin              bin file previously created by `strling extract`

Options:
  -f, --fasta=FASTA          path to fasta file
  -m, --min-support=MIN_SUPPORT
                             minimum number of supporting reads for a locus to be reported (default: 5)
  -c, --min-clip=MIN_CLIP    minimum number of supporting clipped reads for each side of a locus (default: 0)
  -t, --min-clip-total=MIN_CLIP_TOTAL
                             minimum total number of supporting clipped reads for a locus (default: 0)
  -q, --min-mapq=MIN_MAPQ    minimum mapping quality (does not apply to STR reads) (default: 40)
  -l, --loci=LOCI            Annoated bed file specifying additional STR loci to genotype. Format is: chr start stop repeatunit [name]
  -b, --bounds=BOUNDS        STRling -bounds.txt file (usually produced by strling merge) specifying additional STR loci to genotype.
  -o, --output-prefix=OUTPUT_PREFIX
                             prefix for output files (default: strling)
  -v, --verbose
  -h, --help                 Show this help
```


## strling_index

### Tool Description
Index a FASTA file for STR analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/strling:0.6.0--h7b50bb2_0
- **Homepage**: https://github.com/quinlan-lab/STRling
- **Package**: https://anaconda.org/channels/bioconda/packages/strling/overview
- **Validation**: PASS

### Original Help Text
```text
str index

Usage:
  str index [options] fasta

Arguments:
  fasta            path to fasta file

Options:
  -g, --genome-repeats=GENOME_REPEATS
                             optional path to output genome repeats file. if it does not exist, it will be created (default: ./<FASTA>.str)
  -p, --proportion-repeat=PROPORTION_REPEAT
                             proportion of read that is repetitive to be considered as STR (default: 0.8)
  -h, --help                 Show this help
```


## strling_pull_region

### Tool Description
Extracts a region from a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/strling:0.6.0--h7b50bb2_0
- **Homepage**: https://github.com/quinlan-lab/STRling
- **Package**: https://anaconda.org/channels/bioconda/packages/strling/overview
- **Validation**: PASS

### Original Help Text
```text
strling pull_region

Usage:
  strling pull_region [options] bam region

Arguments:
  bam
  region

Options:
  -f, --fasta=FASTA          path to fasta file, only required for cram
  -o, --output-bam=OUTPUT_BAM
                             path to output bam (default: extracted.bam)
  -h, --help                 Show this help
```


## Metadata
- **Skill**: not generated

## strling

### Tool Description
STRling is a tool for analyzing short tandem repeats (STRs) in sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/strling:0.6.0--h7b50bb2_0
- **Homepage**: https://github.com/quinlan-lab/STRling
- **Package**: https://anaconda.org/channels/bioconda/packages/strling/overview
- **Validation**: PASS
### Original Help Text
```text
extract      :   extract informative STR reads from a BAM/CRAM. This is a required first step.
  merge        :   merge putitive STR loci from multiple samples. Only required for joint calling.
  call         :   call STRs
  index        :   identify large STRs in the reference genome, to produce ref.fasta.str.
  pull_region  :   for debugging; pull all reads (and mates) for a given regions
unknown program '-help'
```

