cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-export-segments
label: dsh-bio_export-segments
doc: "Export segments from a GFA file to FASTA format.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: about
    type:
      - 'null'
      - boolean
    doc: display about message
    inputBinding:
      position: 101
      prefix: --about
  - id: input_gfa1_path
    type:
      - 'null'
      - File
    doc: input GFA 1.0 path
    inputBinding:
      position: 101
      prefix: --input-gfa1-path
  - id: line_width
    type:
      - 'null'
      - int
    doc: line width
    inputBinding:
      position: 101
      prefix: --line-width
  - id: output_fasta_file_path
    type: string
    doc: Output or path parameter `output_fasta_file_path`
    inputBinding:
      position: 102
      prefix: --output-fasta-file
outputs:
  - id: output_fasta_file
    type:
      - 'null'
      - File
    doc: output FASTA file
    outputBinding:
      glob: $(inputs.output_fasta_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
