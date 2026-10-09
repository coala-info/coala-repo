# hybracter CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| hybracter_config | Failed | tool bug: it only copies the default config.yaml; documented options such as --min_length and --skip_qc are accepted but silently ignored |
| hybracter_hybrid | Not completed | pipeline, skipped |
| hybracter_hybrid-single | Not completed | pipeline, skipped |
| hybracter_install | Not completed | runs a Snakemake workflow that downloads the plassembler database (several GB) and conda environments from the network; skipped as pipeline/too heavy |
| hybracter_long | Not completed | pipeline, skipped |
| hybracter_long-single | Not completed | pipeline, skipped |

## hybracter_hybrid

### Tool Description
Run hybracter with hybrid long and paired end short reads

### Metadata
- **Docker Image**: quay.io/biocontainers/hybracter:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/hybracter
- **Package**: https://anaconda.org/channels/bioconda/packages/hybracter/overview
- **Validation**: PASS

### Original Help Text
```text


 _           _                    _            
| |__  _   _| |__  _ __ __ _  ___| |_ ___ _ __ 
| '_ \| | | | '_ \| '__/ _` |/ __| __/ _ \ '__|
| | | | |_| | |_) | | | (_| | (__| ||  __/ |   
|_| |_|\__, |_.__/|_|  \__,_|\___|\__\___|_|   
       |___/

Usage: hybracter hybrid [OPTIONS] [SNAKE_ARGS]...

  Run hybracter with hybrid long and paired end short reads

Options:
  -i, --input TEXT                Input csv  [required]
  --datadir TEXT                  Directory/ies where FASTQs are. Can specify
                                  1 directory (long and short FASTQs in the
                                  same directory) or 2 (long and short FASTQs
                                  in separate directories). If you specify 2,
                                  they must be separated by a comma e.g.
                                  dirlong,dirshort. Will be added to the
                                  filenames in the input csv.
  --no_pypolca                    Do not use pypolca to polish assemblies with
                                  short reads
  --logic [best|last]             Hybracter logic to select best assembly. Use
                                  --last to pick the last polishing round. Use
                                  --best to pick best assembly based on ALE
                                  (hybrid).   [default: last]
  -o, --output PATH               Output directory  [default: hybracter_out]
  --configfile TEXT               Custom config file [default: config.yaml]
  -t, --threads INTEGER           Number of threads to use  [default: 1]
  --min_length INTEGER            min read length for long reads  [default:
                                  1000]
  --min_quality INTEGER           min read quality score for long reads in bp.
                                  [default: 9]
  --skip_qc                       Do not run porechop_abi, filtlong and fastp
                                  to QC the reads
  -d, --databases PATH            Plassembler Databases directory.
  --subsample_depth INTEGER       subsampled long read depth to subsample with
                                  Filtlong. By default is 100x.  [default:
                                  100]
  --min_depth INTEGER             minimum long read depth to continue the run.
                                  By default is 0x. Hybracter will error and
                                  exit if a sample has less than
                                  min_depth*chromosome_size bases of long-
                                  reads left AFTER filtlong and porechop-ABI
                                  steps are run.  [default: 0]
  --medakaModel [r1041_e82_400bps_bacterial_methylation|r1041_e82_400bps_sup_v5.0.0|r1041_e82_400bps_hac_v5.0.0|r1041_e82_400bps_hac_v4.3.0|r1041_e82_400bps_sup_v4.3.0|r1041_e82_400bps_hac_v4.2.0|r1041_e82_400bps_sup_v4.2.0|r941_sup_plant_g610|r941_min_fast_g507|r941_prom_fast_g507|r941_min_fast_g303|r941_min_high_g303|r941_min_high_g330|r941_prom_fast_g303|r941_prom_high_g303|r941_prom_high_g330|r941_min_high_g344|r941_min_high_g351|r941_min_high_g360|r941_prom_high_g344|r941_prom_high_g360|r941_prom_high_g4011|r10_min_high_g303|r10_min_high_g340|r103_min_high_g345|r103_min_high_g360|r103_prom_high_g360|r103_fast_g507|r103_hac_g507|r103_sup_g507|r104_e81_fast_g5015|r104_e81_sup_g5015|r104_e81_hac_g5015|r104_e81_sup_g610|r1041_e82_400bps_hac_g615|r1041_e82_400bps_fast_g615|r1041_e82_400bps_fast_g632|r1041_e82_260bps_fast_g632|r1041_e82_400bps_hac_g632|r1041_e82_400bps_sup_g615|r1041_e82_260bps_hac_g632|r1041_e82_260bps_sup_g632|r1041_e82_400bps_hac_v4.0.0|r1041_e82_400bps_sup_v4.0.0|r1041_e82_260bps_hac_v4.0.0|r1041_e82_260bps_sup_v4.0.0|r1041_e82_260bps_hac_v4.1.0|r1041_e82_260bps_sup_v4.1.0|r1041_e82_400bps_hac_v4.1.0|r1041_e82_400bps_sup_v4.1.0|r941_min_high_g340_rle|r941_min_hac_g507|r941_min_sup_g507|r941_prom_hac_g507|r941_prom_sup_g507|r941_e81_fast_g514|r941_e81_hac_g514|r941_e81_sup_g514]
                                  Medaka Model.  [default:
                                  r1041_e82_400bps_sup_v5.0.0]
  --flyeModel [--nano-hq|--nano-corr|--nano-raw|--pacbio-raw|--pacbio-corr|--pacbio-hifi]
                                  Flye Assembly Parameter  [default: --nano-
                                  hq]
  --contaminants PATH             Contaminants FASTA file to map long
                                  readsagainst to filter out. Choose
                                  --contaminants lambda to filter out phage
                                  lambda long reads.
  --dnaapler_custom_db PATH       Custom amino acid FASTA file of sequences to
                                  be used as a database with dnaapler custom.
  --no_medaka                     Do not polish the long read assembly with
                                  Medaka.
  --auto                          Automatically estimate the chromosome size
                                  using KMC.
  --depth_filter FLOAT            Depth filter to pass to Plassembler. Filters
                                  out all putative plasmid contigs below this
                                  fraction of the chromosome read depth (needs
                                  to be below in both long and short read sets
                                  for hybrid).
  --mac                           If you are running Hybracter on Mac -
                                  installs v1.8.0 of Medaka as higher versions
                                  break.
  --medaka_override               Use this if you do NOT want to use the
                                  --bacteria option with Medaka. Instead your
                                  specified --medakaModel will be used.
  --extra_params_flye TEXT        Use this if want to add extra parameters to
                                  Flye.
  --use-conda / --no-use-conda    Use conda for Snakemake rules  [default:
                                  use-conda]
  --conda-prefix PATH             Custom conda env directory
  --snake-default TEXT            Customise Snakemake runtime args  [default:
                                  --rerun-incomplete, --printshellcmds,
                                  --nolock, --show-failed-logs, --conda-
                                  frontend conda]
  -h, --help                      Show this message and exit.

  CLUSTER EXECUTION:
  hybracter hybrid ... --profile [profile]
  For information on Snakemake profiles see:
  https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles
  
  RUN EXAMPLES:
  Required:           hybracter hybrid --input [file]
  Specify output directory:    hybracter hybrid ... --output [directory]
  Specify threads:    hybracter hybrid ... --threads [threads]
  Disable conda:      hybracter hybrid ... --no-use-conda 
  Change defaults:    hybracter hybrid ... --snake-default="-k --nolock"
  Add Snakemake args: hybracter hybrid ... --dry-run --keep-going --touch
  Specify targets:    hybracter hybrid ... all print_targets
  Available targets:
      all             Run everything (default)
      print_targets   List available targets
```

## hybracter_hybrid-single

### Tool Description
Run hybracter hybrid on 1 isolate

### Metadata
- **Docker Image**: quay.io/biocontainers/hybracter:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/hybracter
- **Package**: https://anaconda.org/channels/bioconda/packages/hybracter/overview
- **Validation**: PASS

### Original Help Text
```text


 _           _                    _            
| |__  _   _| |__  _ __ __ _  ___| |_ ___ _ __ 
| '_ \| | | | '_ \| '__/ _` |/ __| __/ _ \ '__|
| | | | |_| | |_) | | | (_| | (__| ||  __/ |   
|_| |_|\__, |_.__/|_|  \__,_|\___|\__\___|_|   
       |___/

Usage: hybracter hybrid-single [OPTIONS] [SNAKE_ARGS]...

  Run hybracter hybrid on 1 isolate

Options:
  -l, --longreads TEXT            FASTQ file of longreads  [required]
  -1, --short_one TEXT            R1 FASTQ file of paired end short reads
                                  [required]
  -2, --short_two TEXT            R2 FASTQ file of paired end short reads
                                  [required]
  -s, --sample TEXT               Sample name.  [default: sample]
  -c, --chromosome INTEGER        Approximate lower-bound chromosome length
                                  (in base pairs).  [default: 1000000]
  --no_pypolca                    Do not use pypolca to polish assemblies with
                                  short reads
  --logic [best|last]             Hybracter logic to select best assembly. Use
                                  --best to pick best assembly based on ALE
                                  (hybrid) or pyrodigal mean length (long).
                                  Use --last to pick the last polishing round
                                  regardless.  [default: last]
  -o, --output PATH               Output directory  [default: hybracter_out]
  --configfile TEXT               Custom config file [default: config.yaml]
  -t, --threads INTEGER           Number of threads to use  [default: 1]
  --min_length INTEGER            min read length for long reads  [default:
                                  1000]
  --min_quality INTEGER           min read quality score for long reads in bp.
                                  [default: 9]
  --skip_qc                       Do not run porechop_abi, filtlong and fastp
                                  to QC the reads
  -d, --databases PATH            Plassembler Databases directory.
  --subsample_depth INTEGER       subsampled long read depth to subsample with
                                  Filtlong. By default is 100x.  [default:
                                  100]
  --min_depth INTEGER             minimum long read depth to continue the run.
                                  By default is 0x. Hybracter will error and
                                  exit if a sample has less than
                                  min_depth*chromosome_size bases of long-
                                  reads left AFTER filtlong and porechop-ABI
                                  steps are run.  [default: 0]
  --medakaModel [r1041_e82_400bps_bacterial_methylation|r1041_e82_400bps_sup_v5.0.0|r1041_e82_400bps_hac_v5.0.0|r1041_e82_400bps_hac_v4.3.0|r1041_e82_400bps_sup_v4.3.0|r1041_e82_400bps_hac_v4.2.0|r1041_e82_400bps_sup_v4.2.0|r941_sup_plant_g610|r941_min_fast_g507|r941_prom_fast_g507|r941_min_fast_g303|r941_min_high_g303|r941_min_high_g330|r941_prom_fast_g303|r941_prom_high_g303|r941_prom_high_g330|r941_min_high_g344|r941_min_high_g351|r941_min_high_g360|r941_prom_high_g344|r941_prom_high_g360|r941_prom_high_g4011|r10_min_high_g303|r10_min_high_g340|r103_min_high_g345|r103_min_high_g360|r103_prom_high_g360|r103_fast_g507|r103_hac_g507|r103_sup_g507|r104_e81_fast_g5015|r104_e81_sup_g5015|r104_e81_hac_g5015|r104_e81_sup_g610|r1041_e82_400bps_hac_g615|r1041_e82_400bps_fast_g615|r1041_e82_400bps_fast_g632|r1041_e82_260bps_fast_g632|r1041_e82_400bps_hac_g632|r1041_e82_400bps_sup_g615|r1041_e82_260bps_hac_g632|r1041_e82_260bps_sup_g632|r1041_e82_400bps_hac_v4.0.0|r1041_e82_400bps_sup_v4.0.0|r1041_e82_260bps_hac_v4.0.0|r1041_e82_260bps_sup_v4.0.0|r1041_e82_260bps_hac_v4.1.0|r1041_e82_260bps_sup_v4.1.0|r1041_e82_400bps_hac_v4.1.0|r1041_e82_400bps_sup_v4.1.0|r941_min_high_g340_rle|r941_min_hac_g507|r941_min_sup_g507|r941_prom_hac_g507|r941_prom_sup_g507|r941_e81_fast_g514|r941_e81_hac_g514|r941_e81_sup_g514]
                                  Medaka Model.  [default:
                                  r1041_e82_400bps_sup_v5.0.0]
  --flyeModel [--nano-hq|--nano-corr|--nano-raw|--pacbio-raw|--pacbio-corr|--pacbio-hifi]
                                  Flye Assembly Parameter  [default: --nano-
                                  hq]
  --contaminants PATH             Contaminants FASTA file to map long
                                  readsagainst to filter out. Choose
                                  --contaminants lambda to filter out phage
                                  lambda long reads.
  --dnaapler_custom_db PATH       Custom amino acid FASTA file of sequences to
                                  be used as a database with dnaapler custom.
  --no_medaka                     Do not polish the long read assembly with
                                  Medaka.
  --auto                          Automatically estimate the chromosome size
                                  using KMC.
  --depth_filter FLOAT            Depth filter to pass to Plassembler. Filters
                                  out all putative plasmid contigs below this
                                  fraction of the chromosome read depth (needs
                                  to be below in both long and short read sets
                                  for hybrid).
  --mac                           If you are running Hybracter on Mac -
                                  installs v1.8.0 of Medaka as higher versions
                                  break.
  --medaka_override               Use this if you do NOT want to use the
                                  --bacteria option with Medaka. Instead your
                                  specified --medakaModel will be used.
  --extra_params_flye TEXT        Use this if want to add extra parameters to
                                  Flye.
  --use-conda / --no-use-conda    Use conda for Snakemake rules  [default:
                                  use-conda]
  --conda-prefix PATH             Custom conda env directory
  --snake-default TEXT            Customise Snakemake runtime args  [default:
                                  --rerun-incomplete, --printshellcmds,
                                  --nolock, --show-failed-logs, --conda-
                                  frontend conda]
  -h, --help                      Show this message and exit.

  CLUSTER EXECUTION:
  hybracter hybrid-single ... --profile [profile]
  For information on Snakemake profiles see:
  https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles
  
  RUN EXAMPLES:
  Required:           hybracter hybrid-single -l [FASTQ file of longreads]
  Required:           hybracter hybrid-single -1 [R1 FASTQ file of paired end short reads]
  Required:           hybracter hybrid-single -2 [R2 FASTQ file of paired end short reads]
  Specify output directory:    hybracter hybrid-single  ... --output [directory]
  Specify threads:    hybracter hybrid-single  ... --threads [threads]
  Disable conda:      hybracter hybrid-single  ... --no-use-conda 
  Change defaults:    hybracter hybrid-single  ... --snake-default="-k --nolock"
  Add Snakemake args: hybracter hybrid-single  ... --dry-run --keep-going --touch
  Specify targets:    hybracter hybrid-single  ... all print_targets
  Available targets:
      all             Run everything (default)
      print_targets   List available targets
```

## hybracter_long

### Tool Description
Run hybracter with only long reads

### Metadata
- **Docker Image**: quay.io/biocontainers/hybracter:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/hybracter
- **Package**: https://anaconda.org/channels/bioconda/packages/hybracter/overview
- **Validation**: PASS

### Original Help Text
```text


 _           _                    _            
| |__  _   _| |__  _ __ __ _  ___| |_ ___ _ __ 
| '_ \| | | | '_ \| '__/ _` |/ __| __/ _ \ '__|
| | | | |_| | |_) | | | (_| | (__| ||  __/ |   
|_| |_|\__, |_.__/|_|  \__,_|\___|\__\___|_|   
       |___/

Usage: hybracter long [OPTIONS] [SNAKE_ARGS]...

  Run hybracter with only long reads

Options:
  -i, --input TEXT                Input csv  [required]
  --datadir TEXT                  Directory where FASTQs are. Will be added to
                                  the filenames in the input csv.
  -o, --output PATH               Output directory  [default: hybracter_out]
  --configfile TEXT               Custom config file [default: config.yaml]
  -t, --threads INTEGER           Number of threads to use  [default: 1]
  --min_length INTEGER            min read length for long reads  [default:
                                  1000]
  --min_quality INTEGER           min read quality score for long reads in bp.
                                  [default: 9]
  --skip_qc                       Do not run porechop_abi, filtlong and fastp
                                  to QC the reads
  -d, --databases PATH            Plassembler Databases directory.
  --subsample_depth INTEGER       subsampled long read depth to subsample with
                                  Filtlong. By default is 100x.  [default:
                                  100]
  --min_depth INTEGER             minimum long read depth to continue the run.
                                  By default is 0x. Hybracter will error and
                                  exit if a sample has less than
                                  min_depth*chromosome_size bases of long-
                                  reads left AFTER filtlong and porechop-ABI
                                  steps are run.  [default: 0]
  --medakaModel [r1041_e82_400bps_bacterial_methylation|r1041_e82_400bps_sup_v5.0.0|r1041_e82_400bps_hac_v5.0.0|r1041_e82_400bps_hac_v4.3.0|r1041_e82_400bps_sup_v4.3.0|r1041_e82_400bps_hac_v4.2.0|r1041_e82_400bps_sup_v4.2.0|r941_sup_plant_g610|r941_min_fast_g507|r941_prom_fast_g507|r941_min_fast_g303|r941_min_high_g303|r941_min_high_g330|r941_prom_fast_g303|r941_prom_high_g303|r941_prom_high_g330|r941_min_high_g344|r941_min_high_g351|r941_min_high_g360|r941_prom_high_g344|r941_prom_high_g360|r941_prom_high_g4011|r10_min_high_g303|r10_min_high_g340|r103_min_high_g345|r103_min_high_g360|r103_prom_high_g360|r103_fast_g507|r103_hac_g507|r103_sup_g507|r104_e81_fast_g5015|r104_e81_sup_g5015|r104_e81_hac_g5015|r104_e81_sup_g610|r1041_e82_400bps_hac_g615|r1041_e82_400bps_fast_g615|r1041_e82_400bps_fast_g632|r1041_e82_260bps_fast_g632|r1041_e82_400bps_hac_g632|r1041_e82_400bps_sup_g615|r1041_e82_260bps_hac_g632|r1041_e82_260bps_sup_g632|r1041_e82_400bps_hac_v4.0.0|r1041_e82_400bps_sup_v4.0.0|r1041_e82_260bps_hac_v4.0.0|r1041_e82_260bps_sup_v4.0.0|r1041_e82_260bps_hac_v4.1.0|r1041_e82_260bps_sup_v4.1.0|r1041_e82_400bps_hac_v4.1.0|r1041_e82_400bps_sup_v4.1.0|r941_min_high_g340_rle|r941_min_hac_g507|r941_min_sup_g507|r941_prom_hac_g507|r941_prom_sup_g507|r941_e81_fast_g514|r941_e81_hac_g514|r941_e81_sup_g514]
                                  Medaka Model.  [default:
                                  r1041_e82_400bps_sup_v5.0.0]
  --flyeModel [--nano-hq|--nano-corr|--nano-raw|--pacbio-raw|--pacbio-corr|--pacbio-hifi]
                                  Flye Assembly Parameter  [default: --nano-
                                  hq]
  --contaminants PATH             Contaminants FASTA file to map long
                                  readsagainst to filter out. Choose
                                  --contaminants lambda to filter out phage
                                  lambda long reads.
  --dnaapler_custom_db PATH       Custom amino acid FASTA file of sequences to
                                  be used as a database with dnaapler custom.
  --no_medaka                     Do not polish the long read assembly with
                                  Medaka.
  --auto                          Automatically estimate the chromosome size
                                  using KMC.
  --depth_filter FLOAT            Depth filter to pass to Plassembler. Filters
                                  out all putative plasmid contigs below this
                                  fraction of the chromosome read depth (needs
                                  to be below in both long and short read sets
                                  for hybrid).
  --mac                           If you are running Hybracter on Mac -
                                  installs v1.8.0 of Medaka as higher versions
                                  break.
  --medaka_override               Use this if you do NOT want to use the
                                  --bacteria option with Medaka. Instead your
                                  specified --medakaModel will be used.
  --extra_params_flye TEXT        Use this if want to add extra parameters to
                                  Flye.
  --use-conda / --no-use-conda    Use conda for Snakemake rules  [default:
                                  use-conda]
  --conda-prefix PATH             Custom conda env directory
  --snake-default TEXT            Customise Snakemake runtime args  [default:
                                  --rerun-incomplete, --printshellcmds,
                                  --nolock, --show-failed-logs, --conda-
                                  frontend conda]
  --logic [best|last]             Hybracter logic to select best assembly. Use
                                  --best to pick best assembly based on ALE
                                  (hybrid) or pyrodigal mean length (long).
                                  Use --last to pick the last polishing round
                                  regardless.  [default: best]
  -h, --help                      Show this message and exit.

  CLUSTER EXECUTION:
  hybracter hybrid ... --profile [profile]
  For information on Snakemake profiles see:
  https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles
  
  RUN EXAMPLES:
  Required:           hybracter long --input [file]
  Specify output directory:    hybracter long ... --output [directory]
  Specify threads:    hybracter long ... --threads [threads]
  Disable conda:      hybracter long ... --no-use-conda 
  Change defaults:    hybracter long ... --snake-default="-k --nolock"
  Add Snakemake args: hybracter long ... --dry-run --keep-going --touch
  Specify targets:    hybracter long ... all print_targets
  Available targets:
      all             Run everything (default)
      print_targets   List available targets
```

## hybracter_long-single

### Tool Description
Run hybracter long on 1 isolate

### Metadata
- **Docker Image**: quay.io/biocontainers/hybracter:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/hybracter
- **Package**: https://anaconda.org/channels/bioconda/packages/hybracter/overview
- **Validation**: PASS

### Original Help Text
```text


 _           _                    _            
| |__  _   _| |__  _ __ __ _  ___| |_ ___ _ __ 
| '_ \| | | | '_ \| '__/ _` |/ __| __/ _ \ '__|
| | | | |_| | |_) | | | (_| | (__| ||  __/ |   
|_| |_|\__, |_.__/|_|  \__,_|\___|\__\___|_|   
       |___/

Usage: hybracter long-single [OPTIONS] [SNAKE_ARGS]...

  Run hybracter long on 1 isolate

Options:
  -l, --longreads TEXT            FASTQ file of longreads  [required]
  -s, --sample TEXT               Sample name.  [default: sample]
  -c, --chromosome INTEGER        FApproximate lower-bound chromosome length
                                  (in base pairs).  [default: 1000000]
  -o, --output PATH               Output directory  [default: hybracter_out]
  --configfile TEXT               Custom config file [default: config.yaml]
  -t, --threads INTEGER           Number of threads to use  [default: 1]
  --min_length INTEGER            min read length for long reads  [default:
                                  1000]
  --min_quality INTEGER           min read quality score for long reads in bp.
                                  [default: 9]
  --skip_qc                       Do not run porechop_abi, filtlong and fastp
                                  to QC the reads
  -d, --databases PATH            Plassembler Databases directory.
  --subsample_depth INTEGER       subsampled long read depth to subsample with
                                  Filtlong. By default is 100x.  [default:
                                  100]
  --min_depth INTEGER             minimum long read depth to continue the run.
                                  By default is 0x. Hybracter will error and
                                  exit if a sample has less than
                                  min_depth*chromosome_size bases of long-
                                  reads left AFTER filtlong and porechop-ABI
                                  steps are run.  [default: 0]
  --medakaModel [r1041_e82_400bps_bacterial_methylation|r1041_e82_400bps_sup_v5.0.0|r1041_e82_400bps_hac_v5.0.0|r1041_e82_400bps_hac_v4.3.0|r1041_e82_400bps_sup_v4.3.0|r1041_e82_400bps_hac_v4.2.0|r1041_e82_400bps_sup_v4.2.0|r941_sup_plant_g610|r941_min_fast_g507|r941_prom_fast_g507|r941_min_fast_g303|r941_min_high_g303|r941_min_high_g330|r941_prom_fast_g303|r941_prom_high_g303|r941_prom_high_g330|r941_min_high_g344|r941_min_high_g351|r941_min_high_g360|r941_prom_high_g344|r941_prom_high_g360|r941_prom_high_g4011|r10_min_high_g303|r10_min_high_g340|r103_min_high_g345|r103_min_high_g360|r103_prom_high_g360|r103_fast_g507|r103_hac_g507|r103_sup_g507|r104_e81_fast_g5015|r104_e81_sup_g5015|r104_e81_hac_g5015|r104_e81_sup_g610|r1041_e82_400bps_hac_g615|r1041_e82_400bps_fast_g615|r1041_e82_400bps_fast_g632|r1041_e82_260bps_fast_g632|r1041_e82_400bps_hac_g632|r1041_e82_400bps_sup_g615|r1041_e82_260bps_hac_g632|r1041_e82_260bps_sup_g632|r1041_e82_400bps_hac_v4.0.0|r1041_e82_400bps_sup_v4.0.0|r1041_e82_260bps_hac_v4.0.0|r1041_e82_260bps_sup_v4.0.0|r1041_e82_260bps_hac_v4.1.0|r1041_e82_260bps_sup_v4.1.0|r1041_e82_400bps_hac_v4.1.0|r1041_e82_400bps_sup_v4.1.0|r941_min_high_g340_rle|r941_min_hac_g507|r941_min_sup_g507|r941_prom_hac_g507|r941_prom_sup_g507|r941_e81_fast_g514|r941_e81_hac_g514|r941_e81_sup_g514]
                                  Medaka Model.  [default:
                                  r1041_e82_400bps_sup_v5.0.0]
  --flyeModel [--nano-hq|--nano-corr|--nano-raw|--pacbio-raw|--pacbio-corr|--pacbio-hifi]
                                  Flye Assembly Parameter  [default: --nano-
                                  hq]
  --contaminants PATH             Contaminants FASTA file to map long
                                  readsagainst to filter out. Choose
                                  --contaminants lambda to filter out phage
                                  lambda long reads.
  --dnaapler_custom_db PATH       Custom amino acid FASTA file of sequences to
                                  be used as a database with dnaapler custom.
  --no_medaka                     Do not polish the long read assembly with
                                  Medaka.
  --auto                          Automatically estimate the chromosome size
                                  using KMC.
  --depth_filter FLOAT            Depth filter to pass to Plassembler. Filters
                                  out all putative plasmid contigs below this
                                  fraction of the chromosome read depth (needs
                                  to be below in both long and short read sets
                                  for hybrid).
  --mac                           If you are running Hybracter on Mac -
                                  installs v1.8.0 of Medaka as higher versions
                                  break.
  --medaka_override               Use this if you do NOT want to use the
                                  --bacteria option with Medaka. Instead your
                                  specified --medakaModel will be used.
  --extra_params_flye TEXT        Use this if want to add extra parameters to
                                  Flye.
  --use-conda / --no-use-conda    Use conda for Snakemake rules  [default:
                                  use-conda]
  --conda-prefix PATH             Custom conda env directory
  --snake-default TEXT            Customise Snakemake runtime args  [default:
                                  --rerun-incomplete, --printshellcmds,
                                  --nolock, --show-failed-logs, --conda-
                                  frontend conda]
  --logic [best|last]             Hybracter logic to select best assembly. Use
                                  --best to pick best assembly based on ALE
                                  (hybrid) or pyrodigal mean length (long).
                                  Use --last to pick the last polishing round
                                  regardless.  [default: best]
  -h, --help                      Show this message and exit.

  CLUSTER EXECUTION:
  hybracter long-single ... --profile [profile]
  For information on Snakemake profiles see:
  https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles
  
  RUN EXAMPLES:
  Required:           hybracter long-single -l [FASTQ file of longreads]
  Specify output directory:    hybracter long-single  ... --output [directory]
  Specify threads:    hybracter long-single  ... --threads [threads]
  Disable conda:      hybracter long-single  ... --no-use-conda 
  Change defaults:    hybracter long-single  ... --snake-default="-k --nolock"
  Add Snakemake args: hybracter long-single  ... --dry-run --keep-going --touch
  Specify targets:    hybracter long-single  ... all print_targets
  Available targets:
      all             Run everything (default)
      print_targets   List available targets
```

## hybracter_config

### Tool Description
Copy the system default config file

### Metadata
- **Docker Image**: quay.io/biocontainers/hybracter:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/hybracter
- **Package**: https://anaconda.org/channels/bioconda/packages/hybracter/overview
- **Validation**: PASS

### Original Help Text
```text


 _           _                    _            
| |__  _   _| |__  _ __ __ _  ___| |_ ___ _ __ 
| '_ \| | | | '_ \| '__/ _` |/ __| __/ _ \ '__|
| | | | |_| | |_) | | | (_| | (__| ||  __/ |   
|_| |_|\__, |_.__/|_|  \__,_|\___|\__\___|_|   
       |___/

Usage: hybracter config [OPTIONS] [SNAKE_ARGS]...

  Copy the system default config file

Options:
  -o, --output PATH               Output directory  [default: hybracter_out]
  --configfile TEXT               Custom config file [default: config.yaml]
  -t, --threads INTEGER           Number of threads to use  [default: 1]
  --min_length INTEGER            min read length for long reads  [default:
                                  1000]
  --min_quality INTEGER           min read quality score for long reads in bp.
                                  [default: 9]
  --skip_qc                       Do not run porechop_abi, filtlong and fastp
                                  to QC the reads
  -d, --databases PATH            Plassembler Databases directory.
  --subsample_depth INTEGER       subsampled long read depth to subsample with
                                  Filtlong. By default is 100x.  [default:
                                  100]
  --min_depth INTEGER             minimum long read depth to continue the run.
                                  By default is 0x. Hybracter will error and
                                  exit if a sample has less than
                                  min_depth*chromosome_size bases of long-
                                  reads left AFTER filtlong and porechop-ABI
                                  steps are run.  [default: 0]
  --medakaModel [r1041_e82_400bps_bacterial_methylation|r1041_e82_400bps_sup_v5.0.0|r1041_e82_400bps_hac_v5.0.0|r1041_e82_400bps_hac_v4.3.0|r1041_e82_400bps_sup_v4.3.0|r1041_e82_400bps_hac_v4.2.0|r1041_e82_400bps_sup_v4.2.0|r941_sup_plant_g610|r941_min_fast_g507|r941_prom_fast_g507|r941_min_fast_g303|r941_min_high_g303|r941_min_high_g330|r941_prom_fast_g303|r941_prom_high_g303|r941_prom_high_g330|r941_min_high_g344|r941_min_high_g351|r941_min_high_g360|r941_prom_high_g344|r941_prom_high_g360|r941_prom_high_g4011|r10_min_high_g303|r10_min_high_g340|r103_min_high_g345|r103_min_high_g360|r103_prom_high_g360|r103_fast_g507|r103_hac_g507|r103_sup_g507|r104_e81_fast_g5015|r104_e81_sup_g5015|r104_e81_hac_g5015|r104_e81_sup_g610|r1041_e82_400bps_hac_g615|r1041_e82_400bps_fast_g615|r1041_e82_400bps_fast_g632|r1041_e82_260bps_fast_g632|r1041_e82_400bps_hac_g632|r1041_e82_400bps_sup_g615|r1041_e82_260bps_hac_g632|r1041_e82_260bps_sup_g632|r1041_e82_400bps_hac_v4.0.0|r1041_e82_400bps_sup_v4.0.0|r1041_e82_260bps_hac_v4.0.0|r1041_e82_260bps_sup_v4.0.0|r1041_e82_260bps_hac_v4.1.0|r1041_e82_260bps_sup_v4.1.0|r1041_e82_400bps_hac_v4.1.0|r1041_e82_400bps_sup_v4.1.0|r941_min_high_g340_rle|r941_min_hac_g507|r941_min_sup_g507|r941_prom_hac_g507|r941_prom_sup_g507|r941_e81_fast_g514|r941_e81_hac_g514|r941_e81_sup_g514]
                                  Medaka Model.  [default:
                                  r1041_e82_400bps_sup_v5.0.0]
  --flyeModel [--nano-hq|--nano-corr|--nano-raw|--pacbio-raw|--pacbio-corr|--pacbio-hifi]
                                  Flye Assembly Parameter  [default: --nano-
                                  hq]
  --contaminants PATH             Contaminants FASTA file to map long
                                  readsagainst to filter out. Choose
                                  --contaminants lambda to filter out phage
                                  lambda long reads.
  --dnaapler_custom_db PATH       Custom amino acid FASTA file of sequences to
                                  be used as a database with dnaapler custom.
  --no_medaka                     Do not polish the long read assembly with
                                  Medaka.
  --auto                          Automatically estimate the chromosome size
                                  using KMC.
  --depth_filter FLOAT            Depth filter to pass to Plassembler. Filters
                                  out all putative plasmid contigs below this
                                  fraction of the chromosome read depth (needs
                                  to be below in both long and short read sets
                                  for hybrid).
  --mac                           If you are running Hybracter on Mac -
                                  installs v1.8.0 of Medaka as higher versions
                                  break.
  --medaka_override               Use this if you do NOT want to use the
                                  --bacteria option with Medaka. Instead your
                                  specified --medakaModel will be used.
  --extra_params_flye TEXT        Use this if want to add extra parameters to
                                  Flye.
  --use-conda / --no-use-conda    Use conda for Snakemake rules  [default:
                                  use-conda]
  --conda-prefix PATH             Custom conda env directory
  --snake-default TEXT            Customise Snakemake runtime args  [default:
                                  --rerun-incomplete, --printshellcmds,
                                  --nolock, --show-failed-logs, --conda-
                                  frontend conda]
  -h, --help                      Show this message and exit.
```

## Metadata
- **Skill**: generated

## hybracter_install

### Tool Description
Downloads and installs the plassembler database

### Metadata
- **Docker Image**: quay.io/biocontainers/hybracter:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/hybracter
- **Package**: https://anaconda.org/channels/bioconda/packages/hybracter/overview
- **Validation**: PASS

### Original Help Text
```text


 _           _                    _            
| |__  _   _| |__  _ __ __ _  ___| |_ ___ _ __ 
| '_ \| | | | '_ \| '__/ _` |/ __| __/ _ \ '__|
| | | | |_| | |_) | | | (_| | (__| ||  __/ |   
|_| |_|\__, |_.__/|_|  \__,_|\___|\__\___|_|   
       |___/


Usage: hybracter install [OPTIONS] [SNAKE_ARGS]...

  Downloads and installs the plassembler database

Options:
  --use-conda / --no-use-conda  Use conda for Snakemake rules  [default: use-
                                conda]
  --snake-default TEXT          Customise Snakemake runtime args  [default:
                                --rerun-incomplete, --printshellcmds,
                                --nolock, --show-failed-logs, --conda-frontend
                                conda]
  -d, --databases TEXT          Directory where the Plassembler Database will
                                be installed to (optional).
  -m, --medaka                  Download medaka models.
  --mac                         If you are running Hybracter on Mac - installs
                                v1.8.0 of Medaka as higher versions break.
  -o, --output PATH             Temporary directory where intermediate files
                                will be stored for hybracter install.  This
                                will be deleted.  [default:
                                hybracter_install_intermediate_files]
  --configfile TEXT             Custom config file [default:
                                (outputDir)/config.yaml]
  -h, --help                    Show this message and exit.

  installs the plassembler database
  hybracter install ... 
  
  RUN EXAMPLES:
  Database:           hybracter install -d [directory]

hybracter version 0.12.0
```
