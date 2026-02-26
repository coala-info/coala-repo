# snakealtpromoter CWL Generation Report

## snakealtpromoter_Genomesetup

### Tool Description
Execute the AltPromoterFlow genome setup pipeline to generate genome indices and annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakealtpromoter:1.0.5--pyhdfd78af_0
- **Homepage**: https://github.com/YidanSunResearchLab/SnakeAltPromoter
- **Package**: https://anaconda.org/channels/bioconda/packages/snakealtpromoter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/snakealtpromoter/overview
- **Total Downloads**: 53
- **Last updated**: 2025-11-14
- **GitHub**: https://github.com/YidanSunResearchLab/SnakeAltPromoter
- **Stars**: N/A
### Original Help Text
```text
usage: Genomesetup [-h] -o OUTPUT_DIR --organism ORGANISM
                   --organism_fasta ORGANISM_FASTA --genes_gtf GENES_GTF
                   [--threads THREADS]

Execute the AltPromoterFlow genome setup pipeline to generate genome indices
and annotations.

options:
  -h, --help            show this help message and exit
  -o, --output_dir OUTPUT_DIR
                        Absolute path to the output directory for storing
                        generated genome files.
  --organism ORGANISM   Reference genome assembly (e.g., 'hg38', 'mm10',
                        'dm6').
  --organism_fasta ORGANISM_FASTA
                        Path to the organism FASTA file with 'chr' prefix
                        (e.g., /path/to/hg38.fa).
  --genes_gtf GENES_GTF
                        Path to the GTF file for gene annotations (e.g.,
                        /path/to/gencode.v38.annotation.gtf).
  --threads THREADS     Number of CPU threads for parallel processing
                        (default: 16).
```


## snakealtpromoter_Snakealtpromoter

### Tool Description
Run a comprehensive pipeline for alternative promoter analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakealtpromoter:1.0.5--pyhdfd78af_0
- **Homepage**: https://github.com/YidanSunResearchLab/SnakeAltPromoter
- **Package**: https://anaconda.org/channels/bioconda/packages/snakealtpromoter/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Snakealtpromoter [-h] -i INPUT_DIR -o OUTPUT_DIR --organism ORGANISM
                        --genome_dir GENOME_DIR
                        [--downsample_size DOWNSAMPLE_SIZE] [--fastqc]
                        [--trim] [--threads THREADS]
                        [--method {salmon,proactiv,dexseq,cage,rnaseq}]
                        [--reads {single,paired}] [--min_pFC MIN_PFC]
                        [--max_gFC MAX_GFC] [--lfcshrink]
                        [--sample_sheet SAMPLE_SHEET] [--slurm]
                        [--slurm-account SLURM_ACCOUNT]
                        [--slurm-partition SLURM_PARTITION]
                        [--set-resources SET_RESOURCES]

Run a comprehensive pipeline for alternative promoter analysis.

options:
  -h, --help            show this help message and exit
  -i, --input_dir INPUT_DIR
                        Path to the input directory containing paired-end
                        FASTQ gz files (e.g., /path/to/fastqs/).
  -o, --output_dir OUTPUT_DIR
                        Path to the output directory where results will be
                        saved (e.g., /path/to/output/).
  --organism ORGANISM   Reference genome assembly to use, created by the
                        Genomesetup step. For example: 'hg38', 'dm6', 'ce3',
                        or 'mm10'.
  --genome_dir GENOME_DIR
                        Absolute path to the directory containing pre-
                        generated genome files, created by the Genomesetup
                        step (e.g., /absolute/path/to/genomes/).
  --downsample_size DOWNSAMPLE_SIZE
                        Number of valid pairs to downsample to for analysis.
                        Set to 0 to disable downsampling (default: 0).
  --fastqc              Enable this flag if needs fastqc.
  --trim                Enable this flag if reads were trimmed using Trim
                        Galore. If not set, the pipeline will use downsampled
                        fastqs.
  --threads THREADS     Number of CPU threads to use for parallel processing
                        (default: 30).
  --method {salmon,proactiv,dexseq,cage,rnaseq}
                        Which method to run: salmon / proactiv / dexseq / cage
                        / rnaseq
  --reads {single,paired}
                        Reads are single-ended or paired: single / paired
  --min_pFC MIN_PFC     Additional threshold of minimum fold change of
                        promoter activity for a promoter to be considered
                        alternative promoter (default 2.0)
  --max_gFC MAX_GFC     Additional threshold of maximum fold change of gene
                        expression for a promoter to be considered alternative
                        promoter (default 1.5)
  --lfcshrink           Enable log2 fold change shrinkage during differential
                        analysis.
  --sample_sheet SAMPLE_SHEET
                        Path to sampleSheet.tsv file. Contains 'sampleName',
                        'condition', 'batch', and 'differential' columns.If
                        not provided, a default will be created automatically
                        in the output directory named samplesheet.tsv.
  --slurm               Use Snakemake native SLURM executor (--slurm).
  --slurm-account SLURM_ACCOUNT
                        SLURM account; passed via --default-resources
                        slurm_account=<...>.
  --slurm-partition SLURM_PARTITION
                        SLURM partition; passed via --default-resources
                        slurm_partition=<...>.
  --set-resources SET_RESOURCES
                        Per-rule resource override like
                        '<rule>:slurm_partition=<PART>'. Repeatable. Mirrors
                        Snakemake docs.
```

