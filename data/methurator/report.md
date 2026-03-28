# methurator CWL Generation Report

## methurator_downsample

### Tool Description
Downsample BAM files and estimate sequencing saturation.

### Metadata
- **Docker Image**: quay.io/biocontainers/methurator:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/VIBTOBIlab/methurator
- **Package**: https://anaconda.org/channels/bioconda/packages/methurator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/methurator/overview
- **Total Downloads**: 248
- **Last updated**: 2026-01-31
- **GitHub**: https://github.com/VIBTOBIlab/methurator
- **Stars**: N/A
### Original Help Text
```text
Usage: methurator downsample [OPTIONS] BAMS...                                 
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ BAMS  Path to a single .bam file or to multiple ones (e.g. files/*.bam).     │
│       (PATH) [required]                                                      │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --outdir                    -o   Default ./output directory. (PATH)          │
│ --fasta                          Fasta file of the reference genome used to  │
│                                  align the samples. If not provided, it will │
│                                  download it according to the specified      │
│                                  genome. (PATH)                              │
│ --genome                         Genome used to align the samples.           │
│                                  (hg19|hg38|GRCh37|GRCh38|mm10|mm39)         │
│ --downsampling-percentages  -ds  Percentages used to downsample the .bam     │
│                                  file. Default: 0.1,0.25,0.5,0.75 (TEXT)     │
│ --minimum-coverage          -mc  Minimum CpG coverage to estimate sequencing │
│                                  saturation. It can be either a single       │
│                                  integer or a list of integers (e.g 1,3,5).  │
│                                  Default: 3 (TEXT)                           │
│ --rrbs/--no-rrbs                 If set to True, MethylDackel extract will   │
│                                  consider the RRBS nature of the data adding │
│                                  the --keepDupes flag. Default: True         │
│ --threads                   -@   Number of threads to use. Default: all      │
│                                  available threads - 2. (INTEGER)            │
│ --keep-temporary-files      -k   If set to True, temporary files will be     │
│                                  kept after the analysis. Default: False     │
│ --verbose                        Enable verbose logging.                     │
│ --version                        Show the version and exit.                  │
│ --help                      -h   Show this message and exit.                 │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## methurator_gt-estimator

### Tool Description
Fit the Chao estimator.

### Metadata
- **Docker Image**: quay.io/biocontainers/methurator:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/VIBTOBIlab/methurator
- **Package**: https://anaconda.org/channels/bioconda/packages/methurator/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: methurator gt-estimator [OPTIONS] BAMS...                               
                                                                                
 Fit the Chao estimator.                                                        
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ BAMS  Path to a single .bam file or to multiple ones (e.g. files/*.bam).     │
│       (PATH) [required]                                                      │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --minimum-coverage      -mc  CpG coverage to estimate sequencing saturation. │
│                              It can be either a single integer or a list of  │
│                              integers (e.g 1,3,5). Default: 3 (TEXT)         │
│ --t-step                     Step size taken when predicting future unique   │
│                              CpGs at increasing depth. Default: 0.05 (FLOAT) │
│ --t-max                      Maximum value of t for prediction. Default:     │
│                              10.0 (FLOAT RANGE 2.0<=x<=1000.0)               │
│ --compute_ci                 Compute confidence intervals. Default: False    │
│ --bootstrap-replicates  -b   Number of bootstrap replicates. Default: 30     │
│                              (INTEGER RANGE 10<=x<=100)                      │
│ --conf                       Confidence level for the bootstrap confidence   │
│                              intervals. Default: 0.95 (FLOAT RANGE           │
│                              0.1<=x<=0.99)                                   │
│ --mu                         Initial value for the mu parameter in the       │
│                              negative binomial distribution for the EM       │
│                              algorithm. Default: 0.5 (FLOAT)                 │
│ --size                       A positive double, the initial value of the     │
│                              parameter size in the negative binomial         │
│                              distribution for the EM algorithm. Default      │
│                              value is 1. (FLOAT)                             │
│ --mt                         An positive integer constraining possible       │
│                              rational function approximations. Default is    │
│                              20. (INTEGER)                                   │
│ --rrbs                       If set to True, MethylDackel extract will       │
│                              consider the RRBS nature of the data adding the │
│                              --keepDupes flag. Default: False                │
│ --threads               -@   Number of threads to use. Default: all          │
│                              available threads - 2. (INTEGER)                │
│ --fasta                      Fasta file of the reference genome used to      │
│                              align the samples. If not provided, it will     │
│                              download it according to the specified genome.  │
│                              (PATH)                                          │
│ --genome                     Genome used to align the samples.               │
│                              (hg19|hg38|GRCh37|GRCh38|mm10|mm39)             │
│ --keep-temporary-files  -k   If set to True, temporary files will be kept    │
│                              after the analysis. Default: False              │
│ --outdir                -o   Default output directory. (PATH)                │
│ --verbose                    Enable verbose logging.                         │
│ --version                    Show the version and exit.                      │
│ --help                  -h   Show this message and exit.                     │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## methurator_plot

### Tool Description
Plot the sequencing saturation curve from downsampling results.

### Metadata
- **Docker Image**: quay.io/biocontainers/methurator:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/VIBTOBIlab/methurator
- **Package**: https://anaconda.org/channels/bioconda/packages/methurator/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: methurator plot [OPTIONS]                                               
                                                                                
 Plot the sequencing saturation curve from downsampling results.                
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --summary  -s  File (yml) containing summary results of downsample command.  │
│                (PATH) [required]                                             │
│ --outdir   -o  Default output directory. (PATH)                              │
│ --verbose      Enable verbose logging.                                       │
│ --version      Show the version and exit.                                    │
│ --help     -h  Show this message and exit.                                   │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## Metadata
- **Skill**: generated
