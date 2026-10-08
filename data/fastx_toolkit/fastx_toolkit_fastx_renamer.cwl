cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_renamer
label: fastx_toolkit_fastx_renamer
doc: "Rename the sequence identifiers of a FASTA/Q file, using either the nucleotide sequence or a counter.\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs:
  - id: compress_output
    type:
      - 'null'
      - boolean
    doc: "Compress output with GZIP."
    inputBinding:
      position: 101
      prefix: -z
  - id: input_file
    type:
      - 'null'
      - File
    doc: "FASTA/Q input file. Default is STDIN."
    inputBinding:
      position: 101
      prefix: -i
  - id: output_file_path
    type: string
    doc: "Output or path parameter `output_file_path`"
    inputBinding:
      position: 102
      prefix: -o
  - id: rename_type
    type:
      - 'null'
      - string
    doc: "Rename type: SEQ - use the nucleotide sequence as the name. COUNT - use a simple counter as the name."
    inputBinding:
      position: 101
      prefix: -n
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "FASTA/Q output file. Default is STDOUT."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastx-toolkit:v0.0.14-6-deb_cv1
