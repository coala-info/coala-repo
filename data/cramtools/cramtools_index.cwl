cwlVersion: v1.2
class: CommandLineTool
baseCommand: cramtools index
label: cramtools_index
doc: "Index a BAM or CRAM file using cramtools.\n\nTool homepage: https://github.com/enasequence/cramtools"
inputs:
  - id: index_format
    type:
      - 'null'
      - string
    doc: Choose between BAM index (bai) and CRAM index (crai).
    default: CRAI
    inputBinding:
      position: 101
      prefix: --index-format
  - id: input_file
    type:
      - 'null'
      - File
    doc: Path to a BAM or CRAM file to be indexed. Omit if standard input (pipe).
    inputBinding:
      position: 101
      prefix: --input-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Change log level: DEBUG, INFO, WARNING, ERROR.'
    default: ERROR
    inputBinding:
      position: 101
      prefix: --log-level
outputs:
  - id: index_file
    type:
      - 'null'
      - File
    doc: Write index to this file.
    outputBinding:
      glob: $(inputs.index_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cramtools:3.0.b127--0
