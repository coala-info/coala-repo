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
    default: stdin
    inputBinding:
      position: 101
      prefix: --input-gfa1-path
  - id: line_width
    type:
      - 'null'
      - int
    doc: line width
    default: 70
    inputBinding:
      position: 101
      prefix: --line-width
outputs:
  - id: output_fasta_file
    type:
      - 'null'
      - File
    doc: output FASTA file
    outputBinding:
      glob: $(inputs.output_fasta_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
