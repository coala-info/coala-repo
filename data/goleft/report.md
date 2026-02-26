# goleft CWL Generation Report

## goleft_covstats

### Tool Description
Estimate coverage statistics from BAM/CRAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/goleft:0.2.6--he881be0_1
- **Homepage**: https://github.com/brentp/goleft
- **Package**: https://anaconda.org/channels/bioconda/packages/goleft/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/goleft/overview
- **Total Downloads**: 115.8K
- **Last updated**: 2025-09-04
- **GitHub**: https://github.com/brentp/goleft
- **Stars**: N/A
### Original Help Text
```text
coverage	insert_mean	insert_sd	insert_5th	insert_95th	template_mean	template_sd	pct_unmapped	pct_bad_reads	pct_duplicate	pct_proper_pair	read_length	bam	sample
Usage: goleft [--n N] [--regions REGIONS] [--fasta FASTA] BAMS [BAMS ...]

Positional arguments:
  BAMS                   bams/crams for which to estimate coverage

Options:
  --n N, -n N            number of reads to sample for length [default: 1000000]
  --regions REGIONS, -r REGIONS
                         optional bed file to specify target regions
  --fasta FASTA, -f FASTA
                         fasta file. required for cram format
  --help, -h             display this help and exit
```


## goleft_depth

### Tool Description
Calculate depth of coverage for BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/goleft:0.2.6--he881be0_1
- **Homepage**: https://github.com/brentp/goleft
- **Package**: https://anaconda.org/channels/bioconda/packages/goleft/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: goleft [--windowsize WINDOWSIZE] [--maxmeandepth MAXMEANDEPTH] [--ordered] [--q Q] [--chrom CHROM] [--mincov MINCOV] [--stats] [--reference REFERENCE] [--processes PROCESSES] [--bed BED] --prefix PREFIX BAM

Positional arguments:
  BAM                    bam for which to calculate depth

Options:
  --windowsize WINDOWSIZE, -w WINDOWSIZE
                         window size in which to calculate high-depth regions [default: 250]
  --maxmeandepth MAXMEANDEPTH, -m MAXMEANDEPTH
                         windows with depth > than this are high-depth. The default reports the depth of all regions.
  --ordered, -o          force output to be in same order as input even with -p.
  --q Q, -Q Q            mapping quality cutoff [default: 1]
  --chrom CHROM, -c CHROM
                         optional chromosome to limit analysis
  --mincov MINCOV        minimum depth considered callable [default: 4]
  --stats, -s            report sequence stats [GC CpG masked] for each window
  --reference REFERENCE, -r REFERENCE
                         path to reference fasta
  --processes PROCESSES, -p PROCESSES
                         number of processors to parallelize.
  --bed BED, -b BED      optional file of positions or regions to restrict depth calculations.
  --prefix PREFIX        prefix for output files depth.bed and callable.bed
  --help, -h             display this help and exit
```


## goleft_depthwed

### Tool Description
Aggregate depth.bed files from goleft depth

### Metadata
- **Docker Image**: quay.io/biocontainers/goleft:0.2.6--he881be0_1
- **Homepage**: https://github.com/brentp/goleft
- **Package**: https://anaconda.org/channels/bioconda/packages/goleft/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: goleft --size SIZE BEDS [BEDS ...]

Positional arguments:
  BEDS                   depth.bed files from goleft depth

Options:
  --size SIZE, -s SIZE   sizes of windows to aggregate to must be >= window in input files.
  --help, -h             display this help and exit
```


## goleft_indexcov

### Tool Description
Estimate coverage for BAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/goleft:0.2.6--he881be0_1
- **Homepage**: https://github.com/brentp/goleft
- **Package**: https://anaconda.org/channels/bioconda/packages/goleft/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: goleft --directory DIRECTORY [--includegl] [--excludepatt EXCLUDEPATT] [--sex SEX] [--chrom CHROM] [--fai FAI] [--extranormalize] BAM [BAM ...]

Positional arguments:
  BAM                    bam(s) or crais for which to estimate coverage

Options:
  --directory DIRECTORY, -d DIRECTORY
                         directory for output files
  --includegl, -e        plot GL chromosomes like: GL000201.1 which are not plotted by default
  --excludepatt EXCLUDEPATT [default: ^chrEBV$|^NC|_random$|Un_|^HLA\-|_alt$|hap\d$]
  --sex SEX, -X SEX      comma delimited names of the sex chromosome(s) used to infer sex. Set to '' if no sex chromosomes are present. [default: X,Y]
  --chrom CHROM, -c CHROM
                         optional chromosome to extract depth. default is entire genome.
  --fai FAI, -f FAI      fasta index file. Required when crais are used.
  --extranormalize, -n   normalize across samples and do local smoothign within sample. this is recommended for CRAI
  --help, -h             display this help and exit
```


## goleft_indexsplit

### Tool Description
Splits indexed BAM/CRAM files into smaller regions based on a reference FASTA index.

### Metadata
- **Docker Image**: quay.io/biocontainers/goleft:0.2.6--he881be0_1
- **Homepage**: https://github.com/brentp/goleft
- **Package**: https://anaconda.org/channels/bioconda/packages/goleft/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: goleft --n N [--fai FAI] [--problematic PROBLEMATIC] INDEXES [INDEXES ...]

Positional arguments:
  INDEXES                bai's/crais to use for splitting genome.

Options:
  --n N, -n N            number of regions to split to.
  --fai FAI              fasta index file.
  --problematic PROBLEMATIC, -p PROBLEMATIC
                         pipe-delimited list of regions to split small.
  --help, -h             display this help and exit
```


## goleft_samplename

### Tool Description
Extract sample name(s) from a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/goleft:0.2.6--he881be0_1
- **Homepage**: https://github.com/brentp/goleft
- **Package**: https://anaconda.org/channels/bioconda/packages/goleft/overview
- **Validation**: PASS

### Original Help Text
```text
samplename 0.2.6
Usage: goleft [--errormulti] BAM

Positional arguments:
  BAM                    bam for to get sample name(s)

Options:
  --errormulti, -e       return an error if there is not exactly 1 sample in the bam.
  --help, -h             display this help and exit
  --version              display version and exit
```

