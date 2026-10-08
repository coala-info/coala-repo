cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_reverse_complement
label: fastx_toolkit_fastx_reverse_complement
doc: "Produce the reverse-complement of each sequence in a FASTA/Q file.\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
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
