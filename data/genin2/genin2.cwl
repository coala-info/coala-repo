cwlVersion: v1.2
class: CommandLineTool
baseCommand: genin2
label: genin2
doc: "Genin2: A tool for gene identification and annotation\n\nTool homepage: https://github.com/izsvenezie-virology/genin2"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file
    inputBinding:
      position: 1
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Verbosity of the logging messages
    inputBinding:
      position: 102
      prefix: --loglevel
  - id: min_seq_cov
    type:
      - 'null'
      - float
    doc: The minimum accepted sequence coverage for each gene segment
    inputBinding:
      position: 102
      prefix: --min-seq-cov
  - id: model_info
    type:
      - 'null'
      - boolean
    doc: Show information about models and exit
    inputBinding:
      position: 102
      prefix: --model-info
  - id: output_file_path
    type: string
    doc: Output TSV
    inputBinding:
      position: 103
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output TSV
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genin2:2.1.5--pyhdfd78af_0
