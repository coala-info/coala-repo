cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hybracter
  - long
label: hybracter_long
doc: "Run hybracter with only long reads\n\nTool homepage: https://github.com/gbouras13/hybracter"
inputs:
  - id: snake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Snakemake arguments
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
    doc: "Directory where FASTQs are. Will be added to\n                         \
      \         the filenames in the input csv."
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
    inputBinding:
      position: 102
      prefix: --flyeModel
  - id: input
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
      \         --best to pick best assembly based on ALE\n                      \
      \            (hybrid) or pyrodigal mean length (long).\n                   \
      \               Use --last to pick the last polishing round\n              \
      \                    regardless."
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
    inputBinding:
      position: 102
      prefix: --min_depth
  - id: min_length
    type:
      - 'null'
      - int
    doc: min read length for long reads
    inputBinding:
      position: 102
      prefix: --min_length
  - id: min_quality
    type:
      - 'null'
      - int
    doc: min read quality score for long reads in bp.
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
  - id: no_use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    inputBinding:
      position: 102
      prefix: --no-use-conda
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
    inputBinding:
      position: 102
      prefix: --subsample_depth
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules
    inputBinding:
      position: 102
      prefix: --use-conda
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybracter:0.12.0--pyhdfd78af_0
