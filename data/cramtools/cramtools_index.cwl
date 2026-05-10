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
    inputBinding:
      position: 101
      prefix: --index-format
  - id: input_file
    type:
      - 'null'
      - File
    doc: Path to a BAM or CRAM file to be indexed. Omit if standard input 
      (pipe).
    inputBinding:
      position: 101
      prefix: --input-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Change log level: DEBUG, INFO, WARNING, ERROR.'
    inputBinding:
      position: 101
      prefix: --log-level
  - id: index_file_path
    type: string
    doc: Output or path parameter `index_file_path`
    inputBinding:
      position: 102
      prefix: --index-file
outputs:
  - id: index_file
    type:
      - 'null'
      - File
    doc: Write index to this file.
    outputBinding:
      glob: $(inputs.index_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cramtools:3.0.b127--0
