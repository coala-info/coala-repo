cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasta_formatter
label: fastx_toolkit_fasta_formatter
doc: "Change the width of sequence lines in a FASTA file, or convert it to a tabular format.\n\nTool homepage: https://github.com/agordon/fastx_toolkit"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: "FASTA/Q input file. Default is STDIN."
    inputBinding:
      position: 101
      prefix: -i
  - id: line_width
    type:
      - 'null'
      - int
    doc: "Maximum sequence line width for the output FASTA file. When ZERO (the default), sequence lines will not be wrapped - all nucleotides of each sequence will appear on a single line."
    inputBinding:
      position: 101
      prefix: -w
  - id: output_empty
    type:
      - 'null'
      - boolean
    doc: "Output empty sequences (default is to discard them). Empty sequences are ones that have only a sequence identifier, but no actual nucleotides."
    inputBinding:
      position: 101
      prefix: -e
  - id: output_file_path
    type: string
    doc: "Output or path parameter `output_file_path`"
    inputBinding:
      position: 102
      prefix: -o
  - id: tabular_output
    type:
      - 'null'
      - boolean
    doc: "Output tabulated format (instead of FASTA format). Sequence identifiers will be on the first column, nucleotides on the second column (as a single line)."
    inputBinding:
      position: 101
      prefix: -t
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
