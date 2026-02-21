cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet-sampleconfig
  - extracttsv
label: biopet-sampleconfig_extracttsv
doc: "Extracts TSV information from a sample configuration JSON file.\n\nTool homepage:
  https://github.com/biopet/sampleconfig"
inputs:
  - id: input_file
    type:
      type: array
      items: File
    doc: Input sample json, can give multiple file
    inputBinding:
      position: 101
      prefix: --inputFile
  - id: library
    type:
      - 'null'
      - string
    doc: Library Name
    inputBinding:
      position: 101
      prefix: --library
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Level of log information printed. Possible levels: 'debug', 'info', 'warn',
      'error'"
    inputBinding:
      position: 101
      prefix: --log_level
  - id: readgroup
    type:
      - 'null'
      - string
    doc: Readgroup name
    inputBinding:
      position: 101
      prefix: --readgroup
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample name
    inputBinding:
      position: 101
      prefix: --sample
outputs:
  - id: json_output
    type:
      - 'null'
      - File
    doc: json output file
    outputBinding:
      glob: $(inputs.json_output)
  - id: tsv_output
    type:
      - 'null'
      - File
    doc: tsv output file
    outputBinding:
      glob: $(inputs.tsv_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-sampleconfig:0.3--0
