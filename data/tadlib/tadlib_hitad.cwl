cwlVersion: v1.2
class: CommandLineTool
baseCommand: hitad
label: tadlib_hitad
doc: "A highly sensitive and reproducible hierarchical domain caller.\n\nTool homepage:
  https://github.com/XiaoTaoWang/TADLib/"
inputs:
  - id: cpu_core
    type:
      - 'null'
      - int
    doc: Number of processes to launch.
    default: 1
    inputBinding:
      position: 101
      prefix: --cpu-core
  - id: datasets
    type: File
    doc: "Metadata file describing Hi-C datasets. Refer to our\n                 \
      \       online documentation for more details."
    inputBinding:
      position: 101
      prefix: --datasets
  - id: di_col
    type:
      - 'null'
      - string
    doc: Name of the column in .cool to output the DI track
    default: DIs
    inputBinding:
      position: 101
      prefix: --DI-col
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: List of chromosomes to exclude.
    default:
      - chrY
      - chrM
    inputBinding:
      position: 101
      prefix: --exclude
  - id: log_file
    type:
      - 'null'
      - File
    doc: Logging file name.
    default: hitad.log
    inputBinding:
      position: 101
      prefix: --logFile
  - id: maxsize
    type:
      - 'null'
      - int
    doc: Maximum domain size in base-pair unit.
    default: 4000000
    inputBinding:
      position: 101
      prefix: --maxsize
  - id: minimum_chrom_size
    type:
      - 'null'
      - int
    doc: "Minimum chromosome size. Only chromosomes with a size\n                \
      \        greater than this value will be considered."
    default: 1000000
    inputBinding:
      position: 101
      prefix: --minimum-chrom-size
  - id: remove_cache
    type:
      - 'null'
      - boolean
    doc: Remove cache data before exiting.
    default: false
    inputBinding:
      position: 101
      prefix: --removeCache
  - id: weight_col
    type:
      - 'null'
      - string
    doc: "Name of the column in .cool to be used to construct\n                  \
      \      the normalized matrix. Specify \"-W RAW\" if you want to\n          \
      \              run with the raw matrix."
    default: weight
    inputBinding:
      position: 101
      prefix: --weight-col
outputs:
  - id: output
    type: File
    doc: Output file name.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadlib:0.4.5.post1--pyhdfd78af_1
