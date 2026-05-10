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
    inputBinding:
      position: 101
      prefix: --cpu-core
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: List of chromosomes to exclude. - chrY - chrM
    inputBinding:
      position: 101
      prefix: --exclude
  - id: log_file
    type:
      - 'null'
      - string
    doc: Logging file name.
    inputBinding:
      position: 101
      prefix: --logFile
  - id: remove_cache
    type:
      - 'null'
      - boolean
    doc: Remove cache data before exiting.
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
    inputBinding:
      position: 101
      prefix: --weight-col
  - id: di_output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `di_output_path`
    inputBinding:
      position: 102
      prefix: --di-output
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_path)
  - id: di_output
    type:
      - 'null'
      - File
    doc: DI output file
    outputBinding:
      glob: $(inputs.di_output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadlib:0.4.5.post1--pyhdfd78af_1
