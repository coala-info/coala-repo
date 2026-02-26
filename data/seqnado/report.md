# seqnado CWL Generation Report

## seqnado_init

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqnado:1.0.4--pyhdfd78af_0
- **Homepage**: https://alsmith151.github.io/SeqNado/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqnado/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/seqnado/overview
- **Total Downloads**: 11.3K
- **Last updated**: 2026-02-21
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
[32m2026-02-24 22:27:28.103[0m | [1mINFO    [0m | [36mseqnado.cli.commands.init[0m:[36minit[0m:[36m51[0m - [1mConda environment: /usr/local[0m
[32m2026-02-24 22:27:28.103[0m | [1mINFO    [0m | [36mseqnado.cli.commands.init[0m:[36minit[0m:[36m78[0m - [1mApptainer not found on PATH; skipping container setup.[0m
[32m2026-02-24 22:27:28.107[0m | [1mINFO    [0m | [36mseqnado.cli.commands.init[0m:[36minit[0m:[36m112[0m - [1mCopied Snakemake profile to /root/.config/snakemake/profile_aws[0m
[32m2026-02-24 22:27:28.108[0m | [1mINFO    [0m | [36mseqnado.cli.commands.init[0m:[36minit[0m:[36m112[0m - [1mCopied Snakemake profile to /root/.config/snakemake/profile_local_conda[0m
[32m2026-02-24 22:27:28.108[0m | [1mINFO    [0m | [36mseqnado.cli.commands.init[0m:[36minit[0m:[36m112[0m - [1mCopied Snakemake profile to /root/.config/snakemake/profile_local_docker[0m
[32m2026-02-24 22:27:28.108[0m | [1mINFO    [0m | [36mseqnado.cli.commands.init[0m:[36minit[0m:[36m112[0m - [1mCopied Snakemake profile to /root/.config/snakemake/profile_local_environment[0m
[32m2026-02-24 22:27:28.108[0m | [1mINFO    [0m | [36mseqnado.cli.commands.init[0m:[36minit[0m:[36m112[0m - [1mCopied Snakemake profile to /root/.config/snakemake/profile_local_singularity[0m
[32m2026-02-24 22:27:28.109[0m | [1mINFO    [0m | [36mseqnado.cli.commands.init[0m:[36minit[0m:[36m112[0m - [1mCopied Snakemake profile to /root/.config/snakemake/profile_slurm_singularity[0m
[32m2026-02-24 22:27:28.109[0m | [1mINFO    [0m | [36mseqnado.cli.commands.init[0m:[36minit[0m:[36m112[0m - [1mCopied Snakemake profile to /root/.config/snakemake/profile_test[0m
[32m2026-02-24 22:27:28.109[0m | [1mINFO    [0m | [36mseqnado.cli.commands.init[0m:[36minit[0m:[36m152[0m - [1mCreated genome config template (please update paths).[0m
[32m2026-02-24 22:27:28.109[0m | [32m[1mSUCCESS [0m | [36mseqnado.cli.commands.init[0m:[36minit[0m:[36m166[0m - [32m[1mInitialization complete.[0m
```


## seqnado_config

### Tool Description
Configure seqnado settings.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqnado:1.0.4--pyhdfd78af_0
- **Homepage**: https://alsmith151.github.io/SeqNado/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqnado/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seqnado config [OPTIONS] [ASSAY]
Try 'seqnado config --help' for help.
╭─ Error ──────────────────────────────────────────────────────────────────────╮
│ No such option: -h                                                           │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## seqnado_tools

### Tool Description
Available Tools in SeqNado Pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/seqnado:1.0.4--pyhdfd78af_0
- **Homepage**: https://alsmith151.github.io/SeqNado/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqnado/overview
- **Validation**: PASS

### Original Help Text
```text
[1;36mAvailable Tools in SeqNado Pipeline[0m

[1;36m1[0m[1m. Download[0m
  [36mfasterq-dump        [0m Fast extraction of sequences from SRA files

[1;36m2[0m[1m. Quality Control[0m
  [36mfastq-screen        [0m Screen sequencing reads against a set of databases
  [36mfastqc              [0m Quality control for high-throughput sequencing data
  [36mqualimap            [0m Quality assessment tool for next-generation sequencing 
data

[1;36m3[0m[1m. Preprocessing[0m
  [36mcutadapt            [0m Remove adapter sequences from sequencing reads
  [36mflash               [0m Fast length adjustment of short reads [1m([0mFLASH[1m)[0m to improve 
genome assemblies
  [36mtrim-galore         [0m Wrapper around Cutadapt and FastQC for quality and 
adapter trimming

[1;36m4[0m[1m. Alignment[0m
  [36mbowtie2             [0m Fast and sensitive read mapping to large genomes
  [36mminimap2            [0m Fast pairwise sequence alignment tool
  [36mpicard              [0m Tools for manipulating high-throughput sequencing data 
and formats
  [36msamtools            [0m Tools for interacting with SAM/BAM format files
  [36mstar                [0m Ultrafast universal RNA-seq aligner

[1;36m5[0m[1m. Analysis[0m
  [36mbamnado             [0m SeqNado BAM file manipulation and analysis tool
  [36mbcftools            [0m Tools for BCF/VCF format variant files
  [36mbedtools            [0m Tools for genomic arithmetic and feature analysis
  [36mcooler              [0m Tools for high-resolution interactions and HiC contact 
matrices
  [36mfindPeaks           [0m Identify genomic peaks in ChIP-seq or ATAC-seq data 
[1m([0mHOMER[1m)[0m
  [36mhomer               [0m Tools for ChIP-seq, DNase-seq, and other genomic analysis
  [36mlanceotron          [0m Peak caller for high-resolution chromatin analysis
  [36mmacs                [0m Model-based analysis of ChIP-Seq data
  [36mmageck              [0m Model-based Analysis of Genome-wide CRISPR-Cas9 Knockout 
data
  [36mmakeTagDirectory    [0m Prepare and organize ChIP-seq tag directories [1m([0mHOMER[1m)[0m
  [36mmccnado             [0m Micro-Capture-C [1m([0mMCC[1m)[0m sequencing data processing tool
  [36mmeme                [0m MEME Suite motif discovery and analysis tools
  [36mmethyldackel        [0m Tools for analyzing DNA methylation from bisulfite 
sequencing data
  [36mseacr               [0m Sparse enrichment analysis for CUT&RUN

[1;36m6[0m[1m. Visualization[0m
  [36mdeeptools           [0m Tools for processing and visualizing deep sequencing data
  [36mplotnado            [0m SeqNado genome browser visualization and plotting tool
  [36mtrackhub            [0m Python library to work with track hubs
  [36mtracknado           [0m Track hub creation tool for UCSC Genome Browser

[1;36m7[0m[1m. Reporting[0m
  [36mmultiqc             [0m Aggregate quality control reports from multiple QC tools
  [36mquarto              [0m Scientific and technical publishing system for reports

[1;36m8[0m[1m. Quantification[0m
  [36mfeatureCounts       [0m Count reads overlapping genomic features [1m([0mgenes/exons[1m)[0m
  [36mquantnado           [0m SeqNado multiomics quantification and dataset creation 
tool
  [36msalmon              [0m Quantification of gene expression from RNA-seq data
  [36msubread             [0m High-performance read alignment, quantification and 
mutation discovery

[1;36m9[0m[1m. Utilities[0m
  [36mapptainer           [0m Container runtime for running Singularity/Apptainer 
images on HPC clusters
  [36mbedToBigBed         [0m Convert BED format files to compressed BigBed format
  [36mpigz                [0m Parallel gzip compression utility
  [36msnakemake           [0m Workflow management system for reproducible and scalable 
data analysis
  [36mucsc-tools          [0m UCSC genome browser command-line utilities

Use [32m'seqnado tools TOOL'[0m to see help for a specific tool.
Use [32m'seqnado tools TOOL --options'[0m to see tool options from the container.
```


## seqnado_download

### Tool Description
Download FASTQ files from GEO/SRA using a metadata TSV file and optionally generate a design file.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqnado:1.0.4--pyhdfd78af_0
- **Homepage**: https://alsmith151.github.io/SeqNado/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqnado/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seqnado download [OPTIONS] METADATA_TSV                                 
                                                                                
 Download FASTQ files from GEO/SRA using a metadata TSV file and optionally     
 generate a design file.                                                        
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    metadata_tsv      PATH  TSV file from GEO/ENA with columns:             │
│                              run_accession, sample_title, library_name, and  │
│                              library_layout (PAIRED or SINGLE).              │
│                              [required]                                      │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --outdir              -o      PATH                  Output directory for     │
│                                                     downloaded FASTQ files.  │
│                                                     [default: fastqs]        │
│ --assay               -a      TEXT                  Assay type for           │
│                                                     generating design file   │
│                                                     after download. If not   │
│                                                     provided, only downloads │
│                                                     FASTQs.                  │
│ --design-output       -d      PATH                  Output path for design   │
│                                                     CSV (default:            │
│                                                     metadata_{assay}.csv in  │
│                                                     outdir).                 │
│ --cores               -c      INTEGER               Number of cores/parallel │
│                                                     jobs.                    │
│                                                     [default: 4]             │
│ --preset                      [a|lc|ld|le|ls|ss|t]  Snakemake job profile    │
│                                                     preset.                  │
│                                                     [default: le]            │
│ --profile,--profiles          PATH                  Path to a Snakemake      │
│                                                     profile directory        │
│                                                     (overrides --preset).    │
│ --dry-run             -n                            Show actions without     │
│                                                     executing them.          │
│ --verbose             -v                            Increase logging         │
│                                                     verbosity.               │
│ --help                                              Show this message and    │
│                                                     exit.                    │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## seqnado_design

### Tool Description
Generate a SeqNado design CSV from FASTQ files for ASSAY. If no assay is provided, multiomics mode is used.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqnado:1.0.4--pyhdfd78af_0
- **Homepage**: https://alsmith151.github.io/SeqNado/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqnado/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seqnado design [OPTIONS] [ASSAY] [FASTQ ...]                            
                                                                                
 Generate a SeqNado design CSV from FASTQ files for ASSAY. If no assay is       
 provided, multiomics mode is used.                                             
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│   assay      [ASSAY]      Assay type. Options: rna, atac, snp, chip, cat,    │
│                           meth, mcc, crispr, multiomics. If omitted,         │
│                           multiomics mode is used.                           │
│   files      [FASTQ ...]                                                     │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --output               -o                        PATH  Output CSV filename   │
│                                                        (default:             │
│                                                        metadata_{assay}.csv… │
│ --ip-to-control                                  TEXT  List of               │
│                                                        antibody,control      │
│                                                        pairings for IP       │
│                                                        assays (e.g. ChIP).   │
│                                                        Format:               │
│                                                        'antibody1:control1,… │
│                                                        If provided will      │
│                                                        assign a control with │
│                                                        a specified name to   │
│                                                        that ip in the        │
│                                                        metadata. If not      │
│                                                        provided, controls    │
│                                                        will be assigned      │
│                                                        based on a            │
│                                                        best-effort matching  │
│                                                        of sample names.      │
│ --group-by                                       TEXT  Group samples by a    │
│                                                        regular expression or │
│                                                        a column name.        │
│ --auto-discover            --no-auto-discover          Search common folders │
│                                                        if none provided.     │
│                                                        [default:             │
│                                                        auto-discover]        │
│ --interactive              --no-interactive            Interactively offer   │
│                                                        to add missing        │
│                                                        columns using schema  │
│                                                        defaults.             │
│                                                        [default:             │
│                                                        interactive]          │
│ --accept-all-defaults                                  Non-interactive:      │
│                                                        auto-add only columns │
│                                                        that have a schema    │
│                                                        default.              │
│ --deseq2-pattern                                 TEXT  Regex pattern to      │
│                                                        extract DESeq2 groups │
│                                                        from sample names.    │
│                                                        First capture group   │
│                                                        will be used.         │
│                                                        Example:              │
│                                                        r'-(\w+)-rep' for     │
│                                                        'sample-GROUP-rep1'   │
│ --verbose              -v                              Increase logging      │
│                                                        verbosity.            │
│ --help                                                 Show this message and │
│                                                        exit.                 │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## seqnado_pipeline

### Tool Description
Run the data processing pipeline for ASSAY (Snakemake under the hood). Any additional arguments are passed to Snakemake (e.g., `seqnado pipeline rna -n` for dry-run, `--unlock`, etc.).

### Metadata
- **Docker Image**: quay.io/biocontainers/seqnado:1.0.4--pyhdfd78af_0
- **Homepage**: https://alsmith151.github.io/SeqNado/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqnado/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seqnado pipeline [OPTIONS] [ASSAY]                                      
                                                                                
 Run the data processing pipeline for ASSAY (Snakemake under the hood). Any     
 additional arguments are passed to Snakemake (e.g., `seqnado pipeline rna -n`  
 for dry-run, `--unlock`, etc.).                                                
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│   assay      [ASSAY]  Assay type (required for single-assay, optional for    │
│                       Multiomic mode)                                        │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --configfile                              PATH             Path to a SeqNado │
│                                                            config YAML       │
│                                                            (default:         │
│                                                            config_<ASSAY>.y… │
│ --version                                                  Print SeqNado     │
│                                                            version and exit. │
│ --preset                                  [a|lc|ld|le|ls|  Snakemake job     │
│                                           ss|t]            profile preset.   │
│                                                            [default: le]     │
│ --profile,--pro…                          PATH             Path to a         │
│                                                            Snakemake profile │
│                                                            directory         │
│                                                            (overrides        │
│                                                            --preset).        │
│ --clean-symlinks      --no-clean-syml…                     Remove symlinks   │
│                                                            created by        │
│                                                            previous runs.    │
│                                                            [default:         │
│                                                            no-clean-symlink… │
│ --scale-resourc…  -s                      FLOAT            Scale memory/time │
│                                                            (env:             │
│                                                            SCALE_RESOURCES). │
│                                                            [default: 1.0]    │
│ --verbose         -v                                       Increase logging  │
│                                                            verbosity.        │
│ --queue           -q                      TEXT             Slurm             │
│                                                            queue/partition   │
│                                                            for the `ss`      │
│                                                            preset.           │
│                                                            [default: short]  │
│ --print-cmd                                                Print the         │
│                                                            Snakemake command │
│                                                            before running    │
│                                                            it.               │
│ --help                                                     Show this message │
│                                                            and exit.         │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## seqnado_genomes

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqnado:1.0.4--pyhdfd78af_0
- **Homepage**: https://alsmith151.github.io/SeqNado/
- **Package**: https://anaconda.org/channels/bioconda/packages/seqnado/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: seqnado genomes [OPTIONS] COMMAND [ARGS]...                             
                                                                                
 Manage genome configurations                                                   
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                  │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ───────────────────────────────────────────────────────────────────╮
│ list         Show packaged and user genome presets.                          │
│ edit         Open user genome config in $EDITOR.                             │
│ build        Download genome and build indices via Snakemake.                │
│ fastqscreen  Generate FastqScreen configuration file.                        │
╰──────────────────────────────────────────────────────────────────────────────╯
```

