# octopusv CWL Generation Report

## octopusv_correct

### Tool Description
Correct SV events with optional quality filtering.

### Metadata
- **Docker Image**: quay.io/biocontainers/octopusv:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/ylab-hi/octopusV
- **Package**: https://anaconda.org/channels/bioconda/packages/octopusv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/octopusv/overview
- **Total Downloads**: 822
- **Last updated**: 2026-02-06
- **GitHub**: https://github.com/ylab-hi/octopusV
- **Stars**: N/A
### Original Help Text
```text
[15:32:03] INFO     generated new fontManager               font_manager.py:1639
                                                                                
 Usage: octopusv correct [OPTIONS] [INPUT_VCF] [OUTPUT]                         
                                                                                
 Correct SV events with optional quality filtering.                             
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│   input_vcf      [INPUT_VCF]  Input VCF file to correct.                     │
│   output         [OUTPUT]     Output file path.                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --input-file      -i       FILE     Input VCF file to correct.               │
│ --output-file     -o       FILE     Output file path.                        │
│ --pos-tolerance   -pt      INTEGER  Position tolerance for identifying mate  │
│                                     BND events, default=3, recommend not to  │
│                                     set larger than 5                        │
│                                     [default: 3]                             │
│ --min-qual                 FLOAT    Minimum QUAL score to keep variants      │
│ --max-qual                 FLOAT    Maximum QUAL score to keep variants      │
│ --min-support              INTEGER  Minimum supporting reads to keep         │
│                                     variants                                 │
│ --max-support              INTEGER  Maximum supporting reads to keep         │
│                                     variants                                 │
│ --min-depth                INTEGER  Minimum total depth to keep variants     │
│ --max-depth                INTEGER  Maximum total depth to keep variants     │
│ --min-gq                   INTEGER  Minimum genotype quality to keep         │
│                                     variants                                 │
│ --min-svlen                INTEGER  Minimum SV length to keep variants       │
│ --max-svlen                INTEGER  Maximum SV length to keep variants       │
│ --filter-pass                       Only keep variants with FILTER=PASS      │
│ --exclude-nocall                    Exclude variants with ./. genotype       │
│ --help            -h                Show this message and exit.              │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## octopusv_merge

### Tool Description
Merge multiple SVCF files based on specified strategy with consistent SOURCES and SAMPLE ordering.

### Metadata
- **Docker Image**: quay.io/biocontainers/octopusv:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/ylab-hi/octopusV
- **Package**: https://anaconda.org/channels/bioconda/packages/octopusv/overview
- **Validation**: PASS

### Original Help Text
```text
[15:33:29] INFO     generated new fontManager               font_manager.py:1639
                                                                                
 Usage: octopusv merge [OPTIONS] [INPUT_FILES]...                               
                                                                                
 Merge multiple SVCF files based on specified strategy with consistent SOURCES  
 and SAMPLE ordering.                                                           
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│   input_files      [INPUT_FILES]...  List of input SVCF files to merge.      │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│    --input-file              -i      PATH     Input SVCF files to merge.     │
│ *  --output-file             -o      PATH     Output file for merged SV      │
│                                               data.                          │
│                                               [required]                     │
│    --mode                            TEXT     Merge mode: 'caller' for same  │
│                                               sample different callers,      │
│                                               'sample' for different         │
│                                               samples.                       │
│                                               [default: caller]              │
│    --caller-names                    TEXT     Comma-separated caller names   │
│                                               (only for caller mode). Must   │
│                                               match input file count.        │
│    --sample-names                    TEXT     Comma-separated sample names   │
│                                               (only for sample mode). Must   │
│                                               match input file count.        │
│    --intersect                                Apply intersection strategy    │
│                                               for merging.                   │
│    --union                                    Apply union strategy for       │
│                                               merging.                       │
│    --specific                        PATH     Extract SVs that are           │
│                                               specifically supported by      │
│                                               provided files.                │
│    --min-support                     INTEGER  Minimum number of files that   │
│                                               must support an SV.            │
│    --exact-support                   INTEGER  Exact number of files that     │
│                                               must support an SV.            │
│    --max-support                     INTEGER  Maximum number of files that   │
│                                               can support an SV.             │
│    --expression                      TEXT     Logical expression for complex │
│                                               file combinations (e.g., '(A   │
│                                               AND B) AND NOT (C OR D)')      │
│    --max-distance                    INTEGER  Maximum allowed distance       │
│                                               between start or end positions │
│                                               for merging events.            │
│                                               [default: 50]                  │
│    --max-length-ratio                FLOAT    Maximum allowed ratio between  │
│                                               event lengths for merging      │
│                                               events.                        │
│                                               [default: 1.3]                 │
│    --min-jaccard                     FLOAT    Minimum required Jaccard index │
│                                               for overlap to merge events.   │
│                                               [default: 0.7]                 │
│    --tra-delta                       INTEGER  Position uncertainty threshold │
│                                               for TRA events (in base        │
│                                               pairs).                        │
│                                               [default: 50]                  │
│    --tra-min-overlap                 FLOAT    Minimum overlap ratio for TRA  │
│                                               events.                        │
│                                               [default: 0.5]                 │
│    --tra-strand-consistency                   Whether to require strand      │
│                                               consistency for TRA events.    │
│                                               [default: True]                │
│    --bnd-delta                       INTEGER  Position uncertainty threshold │
│                                               for BND events (in base        │
│                                               pairs).                        │
│                                               [default: 50]                  │
│    --upsetr                                   Generate UpSet plot            │
│                                               visualization of input file    │
│                                               intersections.                 │
│    --upsetr-output                   PATH     Output path for UpSet plot. If │
│                                               not provided, will use         │
│                                               output_file basename with      │
│                                               _upset.png suffix.             │
│    --help                    -h               Show this message and exit.    │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## octopusv_benchmark

### Tool Description
Benchmark structural variation calls against a truth set using GIAB standards.

### Metadata
- **Docker Image**: quay.io/biocontainers/octopusv:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/ylab-hi/octopusV
- **Package**: https://anaconda.org/channels/bioconda/packages/octopusv/overview
- **Validation**: PASS

### Original Help Text
```text
[15:34:25] INFO     generated new fontManager               font_manager.py:1639
                                                                                
 Usage: octopusv benchmark [OPTIONS] TRUTH_FILE CALL_FILE                       
                                                                                
 Benchmark structural variation calls against a truth set using GIAB standards. 
                                                                                
 This tool implements the GIAB (Genome in a Bottle) consortium's                
 recommendations for                                                            
 structural variant benchmarking. It compares a test VCF file against a truth   
 set                                                                            
 and calculates precision, recall, and F1 scores.                               
                                                                                
 Default thresholds are set according to GIAB standards:                        
 - 500bp maximum reference distance                                             
 - 70% size similarity                                                          
 - 0% reciprocal overlap                                                        
 - 50bp minimum variant size                                                    
 - 50kb maximum variant size                                                    
                                                                                
 Results are written to the specified output directory, including:              
 - True positives from the baseline (tp-base.vcf)                               
 - True positives from the test set (tp-call.vcf)                               
 - False positives (fp.vcf)                                                     
 - False negatives (fn.vcf)                                                     
 - Summary metrics in JSON format (summary.json)                                
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    truth_file      PATH  Path to the truth (ground truth) SVCF file.       │
│                            [required]                                        │
│ *    call_file       PATH  Path to the call (test) SVCF file. [required]     │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --output-dir                -o      PATH     Output directory for         │
│                                                 benchmark results.           │
│                                                 [required]                   │
│    --reference-distance        -r      INTEGER  Max reference location       │
│                                                 distance (default: 500)      │
│                                                 [default: 500]               │
│    --size-similarity           -P      FLOAT    Min pct size similarity      │
│                                                 (minsize/maxsize) (default:  │
│                                                 0.7)                         │
│                                                 [default: 0.7]               │
│    --reciprocal-overlap        -O      FLOAT    Min pct reciprocal overlap   │
│                                                 (default: 0.0)               │
│                                                 [default: 0.0]               │
│    --type-ignore               -t               Variant types don't need to  │
│                                                 match to compare (default:   │
│                                                 False)                       │
│    --size-min                  -s      INTEGER  Minimum variant size to      │
│                                                 consider from test calls     │
│                                                 (default: 50)                │
│                                                 [default: 50]                │
│    --size-max                          INTEGER  Maximum variant size to      │
│                                                 consider (default: 50000)    │
│                                                 [default: 50000]             │
│    --pass-only                                  Only consider variants with  │
│                                                 FILTER == PASS (default:     │
│                                                 False)                       │
│    --enable-sequence-compari…                   Enable sequence similarity   │
│                                                 comparison if sequences      │
│                                                 available (default: False)   │
│    --sequence-similarity       -p      FLOAT    Min sequence similarity when │
│                                                 sequence comparison enabled  │
│                                                 (default: 0.7)               │
│                                                 [default: 0.7]               │
│    --help                      -h               Show this message and exit.  │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## octopusv_stat

### Tool Description
Analyze a single SVCF file and generate comprehensive statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/octopusv:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/ylab-hi/octopusV
- **Package**: https://anaconda.org/channels/bioconda/packages/octopusv/overview
- **Validation**: PASS

### Original Help Text
```text
[15:35:15] INFO     generated new fontManager               font_manager.py:1639
                                                                                
 Usage: octopusv stat [OPTIONS] INPUT_FILE                                      
                                                                                
 Analyze a single SVCF file and generate comprehensive statistics.              
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    input_file      PATH  Input SVCF file to analyze. [required]            │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --output-file  -o      PATH     Output file for statistics. [required]    │
│    --min-size             INTEGER  Minimum SV size to consider.              │
│                                    [default: 50]                             │
│    --max-size             INTEGER  Maximum SV size to consider.              │
│    --report                        Generate an HTML report.                  │
│    --help         -h               Show this message and exit.               │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## octopusv_plot

### Tool Description
Generate plots from the statistics file.

### Metadata
- **Docker Image**: quay.io/biocontainers/octopusv:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/ylab-hi/octopusV
- **Package**: https://anaconda.org/channels/bioconda/packages/octopusv/overview
- **Validation**: PASS

### Original Help Text
```text
[15:36:09] INFO     generated new fontManager               font_manager.py:1639
                                                                                
 Usage: octopusv plot [OPTIONS] INPUT_FILE                                      
                                                                                
 Generate plots from the statistics file.                                       
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    input_file      PATH  Input stat.txt file to plot. [required]           │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --output-prefix  -o      PATH  Output prefix for plot files. [required]   │
│    --help           -h            Show this message and exit.                │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## octopusv_somatic

### Tool Description
Extract somatic SVs by finding tumor-specific variants (tumor - normal intersection).

### Metadata
- **Docker Image**: quay.io/biocontainers/octopusv:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/ylab-hi/octopusV
- **Package**: https://anaconda.org/channels/bioconda/packages/octopusv/overview
- **Validation**: PASS

### Original Help Text
```text
[15:37:02] INFO     generated new fontManager               font_manager.py:1639
                                                                                
 Usage: octopusv somatic [OPTIONS]                                              
                                                                                
 Extract somatic SVs by finding tumor-specific variants (tumor - normal         
 intersection).                                                                 
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --tumor             -t      PATH     Tumor SVCF file. [required]          │
│ *  --normal            -n      PATH     Normal SVCF file. [required]         │
│ *  --output-file       -o      PATH     Output somatic SV file. [required]   │
│    --max-distance              INTEGER  Maximum allowed distance for merging │
│                                         events.                              │
│                                         [default: 50]                        │
│    --max-length-ratio          FLOAT    Maximum allowed ratio between event  │
│                                         lengths.                             │
│                                         [default: 1.3]                       │
│    --min-jaccard               FLOAT    Minimum required Jaccard index for   │
│                                         overlap.                             │
│                                         [default: 0.7]                       │
│    --help              -h               Show this message and exit.          │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## octopusv_svcf2vcf

### Tool Description
Convert SVCF file to VCF format.

### Metadata
- **Docker Image**: quay.io/biocontainers/octopusv:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/ylab-hi/octopusV
- **Package**: https://anaconda.org/channels/bioconda/packages/octopusv/overview
- **Validation**: PASS

### Original Help Text
```text
[15:37:45] INFO     generated new fontManager               font_manager.py:1639
                                                                                
 Usage: octopusv svcf2vcf [OPTIONS]                                             
                                                                                
 Convert SVCF file to VCF format.                                               
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --input-file   -i      PATH  Input SVCF file to convert. [required]       │
│ *  --output-file  -o      PATH  Output VCF file. [required]                  │
│    --help         -h            Show this message and exit.                  │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## octopusv_svcf2bed

### Tool Description
Convert SVCF file to BED format.

### Metadata
- **Docker Image**: quay.io/biocontainers/octopusv:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/ylab-hi/octopusV
- **Package**: https://anaconda.org/channels/bioconda/packages/octopusv/overview
- **Validation**: PASS

### Original Help Text
```text
[15:38:38] INFO     generated new fontManager               font_manager.py:1639
                                                                                
 Usage: octopusv svcf2bed [OPTIONS]                                             
                                                                                
 Convert SVCF file to BED format.                                               
                                                                                
 The output BED file will contain structural variants with their positions.     
 If --minimal is specified, only chromosome, start, and end positions will be   
 included.                                                                      
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --input-file   -i      PATH  Input SVCF file to convert. [required]       │
│ *  --output-file  -o      PATH  Output BED file. [required]                  │
│    --minimal                    Output minimal BED format (only chrom,       │
│                                 start, end)                                  │
│    --help         -h            Show this message and exit.                  │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## octopusv_svcf2bedpe

### Tool Description
Convert SVCF file to BEDPE format.

### Metadata
- **Docker Image**: quay.io/biocontainers/octopusv:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/ylab-hi/octopusV
- **Package**: https://anaconda.org/channels/bioconda/packages/octopusv/overview
- **Validation**: PASS

### Original Help Text
```text
[15:39:28] INFO     generated new fontManager               font_manager.py:1639
                                                                                
 Usage: octopusv svcf2bedpe [OPTIONS]                                           
                                                                                
 Convert SVCF file to BEDPE format.                                             
                                                                                
 The output BEDPE file will contain paired-end structural variants.             
 If --minimal is specified, only coordinate columns will be included.           
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --input-file   -i      PATH  Input SVCF file to convert. [required]       │
│ *  --output-file  -o      PATH  Output BEDPE file. [required]                │
│    --minimal                    Output minimal BEDPE format (only coordinate │
│                                 columns)                                     │
│    --help         -h            Show this message and exit.                  │
╰──────────────────────────────────────────────────────────────────────────────╯
```

