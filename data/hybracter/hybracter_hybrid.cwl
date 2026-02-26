cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hybracter
  - hybrid
label: hybracter_hybrid
doc: "Run hybracter with hybrid long and paired end short reads\n\nTool homepage:
  https://github.com/gbouras13/hybracter"
inputs:
  - id: snake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional Snakemake arguments
    inputBinding:
      position: 1
  - id: auto
    type:
      - 'null'
      - boolean
    doc: "Automatically estimate the chromosome size\n                           \
      \       using KMC."
    inputBinding:
      position: 102
      prefix: --auto
  - id: conda_prefix
    type:
      - 'null'
      - Directory
    doc: Custom conda env directory
    inputBinding:
      position: 102
      prefix: --conda-prefix
  - id: configfile
    type:
      - 'null'
      - string
    doc: Custom config file
    default: config.yaml
    inputBinding:
      position: 102
      prefix: --configfile
  - id: contaminants
    type:
      - 'null'
      - File
    doc: "Contaminants FASTA file to map long\n                                  readsagainst
      to filter out. Choose\n                                  --contaminants lambda
      to filter out phage\n                                  lambda long reads."
    inputBinding:
      position: 102
      prefix: --contaminants
  - id: databases
    type:
      - 'null'
      - Directory
    doc: Plassembler Databases directory.
    inputBinding:
      position: 102
      prefix: --databases
  - id: datadir
    type:
      - 'null'
      - string
    doc: "Directory/ies where FASTQs are. Can specify\n                          \
      \        1 directory (long and short FASTQs in the\n                       \
      \           same directory) or 2 (long and short FASTQs\n                  \
      \                in separate directories). If you specify 2,\n             \
      \                     they must be separated by a comma e.g.\n             \
      \                     dirlong,dirshort. Will be added to the\n             \
      \                     filenames in the input csv."
    inputBinding:
      position: 102
      prefix: --datadir
  - id: depth_filter
    type:
      - 'null'
      - float
    doc: "Depth filter to pass to Plassembler. Filters\n                         \
      \         out all putative plasmid contigs below this\n                    \
      \              fraction of the chromosome read depth (needs\n              \
      \                    to be below in both long and short read sets\n        \
      \                          for hybrid)."
    inputBinding:
      position: 102
      prefix: --depth_filter
  - id: dnaapler_custom_db
    type:
      - 'null'
      - File
    doc: "Custom amino acid FASTA file of sequences to\n                         \
      \         be used as a database with dnaapler custom."
    inputBinding:
      position: 102
      prefix: --dnaapler_custom_db
  - id: extra_params_flye
    type:
      - 'null'
      - string
    doc: "Use this if want to add extra parameters to\n                          \
      \        Flye."
    inputBinding:
      position: 102
      prefix: --extra_params_flye
  - id: flyeModel
    type:
      - 'null'
      - string
    doc: Flye Assembly Parameter
    default: --nano-hq
    inputBinding:
      position: 102
      prefix: --flyeModel
  - id: input_csv
    type: string
    doc: Input csv
    inputBinding:
      position: 102
      prefix: --input
  - id: logic
    type:
      - 'null'
      - string
    doc: "Hybracter logic to select best assembly. Use\n                         \
      \         --last to pick the last polishing round. Use\n                   \
      \               --best to pick best assembly based on ALE\n                \
      \                  (hybrid)."
    default: last
    inputBinding:
      position: 102
      prefix: --logic
  - id: mac
    type:
      - 'null'
      - boolean
    doc: "If you are running Hybracter on Mac -\n                                \
      \  installs v1.8.0 of Medaka as higher versions\n                          \
      \        break."
    inputBinding:
      position: 102
      prefix: --mac
  - id: medakaModel
    type:
      - 'null'
      - string
    doc: Medaka Model.
    default: r1041_e82_400bps_sup_v5.0.0
    inputBinding:
      position: 102
      prefix: --medakaModel
  - id: medaka_override
    type:
      - 'null'
      - boolean
    doc: "Use this if you do NOT want to use the\n                               \
      \   --bacteria option with Medaka. Instead your\n                          \
      \        specified --medakaModel will be used."
    inputBinding:
      position: 102
      prefix: --medaka_override
  - id: min_depth
    type:
      - 'null'
      - int
    doc: "minimum long read depth to continue the run. By default is 0x. Hybracter
      will error and\n                                  exit if a sample has less
      than\n                                  min_depth*chromosome_size bases of long-\n\
      \                                  reads left AFTER filtlong and porechop-ABI\n\
      \                                  steps are run."
    default: 0
    inputBinding:
      position: 102
      prefix: --min_depth
  - id: min_length
    type:
      - 'null'
      - int
    doc: min read length for long reads
    default: 1000
    inputBinding:
      position: 102
      prefix: --min_length
  - id: min_quality
    type:
      - 'null'
      - int
    doc: min read quality score for long reads in bp.
    default: 9
    inputBinding:
      position: 102
      prefix: --min_quality
  - id: no_medaka
    type:
      - 'null'
      - boolean
    doc: "Do not polish the long read assembly with\n                            \
      \      Medaka."
    inputBinding:
      position: 102
      prefix: --no_medaka
  - id: no_pypolca
    type:
      - 'null'
      - boolean
    doc: "Do not use pypolca to polish assemblies with\n                         \
      \         short reads"
    inputBinding:
      position: 102
      prefix: --no_pypolca
  - id: no_use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    inputBinding:
      position: 102
      prefix: --no-use-conda
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: hybracter_out
    inputBinding:
      position: 102
      prefix: --output
  - id: skip_qc
    type:
      - 'null'
      - boolean
    doc: "Do not run porechop_abi, filtlong and fastp\n                          \
      \        to QC the reads"
    inputBinding:
      position: 102
      prefix: --skip_qc
  - id: snake_default
    type:
      - 'null'
      - string
    doc: Customise Snakemake runtime args
    default: "--rerun-incomplete, --printshellcmds,\n                            \
      \      --nolock, --show-failed-logs, --conda-\n                            \
      \      frontend conda"
    inputBinding:
      position: 102
      prefix: --snake-default
  - id: subsample_depth
    type:
      - 'null'
      - int
    doc: "subsampled long read depth to subsample with\n                         \
      \         Filtlong. By default is 100x."
    default: 100
    inputBinding:
      position: 102
      prefix: --subsample_depth
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    default: true
    inputBinding:
      position: 102
      prefix: --use-conda
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybracter:0.12.0--pyhdfd78af_0
stdout: hybracter_hybrid.out
