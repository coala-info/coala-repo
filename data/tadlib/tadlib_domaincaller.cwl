cwlVersion: v1.2
class: CommandLineTool
baseCommand: domaincaller
label: tadlib_domaincaller
doc: "Detect minimum domains using adaptive DI\n\nTool homepage: https://github.com/XiaoTaoWang/TADLib/"
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
      - string
    doc: Logging file name.
    default: domaincaller.log
    inputBinding:
      position: 101
      prefix: --logFile
  - id: remove_cache
    type:
      - 'null'
      - boolean
    doc: Remove cache data before exiting.
    default: false
    inputBinding:
      position: 101
      prefix: --removeCache
  - id: uri
    type: string
    doc: Cool URI.
    inputBinding:
      position: 101
      prefix: --uri
  - id: weight_col
    type:
      - 'null'
      - string
    doc: "Name of the column in .cool to be used to construct\nthe normalized matrix.
      Specify \"-W RAW\" if you want to\nrun with the raw matrix."
    default: weight
    inputBinding:
      position: 101
      prefix: --weight-col
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: $(inputs.output)
  - id: di_output
    type:
      - 'null'
      - File
    doc: DI output file
    outputBinding:
      glob: $(inputs.di_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadlib:0.4.5.post1--pyhdfd78af_1
