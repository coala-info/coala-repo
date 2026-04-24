cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pin_hic
  - gets
label: pin_hic_gets
doc: "Extract sequences from a SAT file\n\nTool homepage: https://github.com/dfguan/pin_hic/"
inputs:
  - id: sat_file
    type:
      type: array
      items: File
    doc: SAT file(s)
    inputBinding:
      position: 1
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: fasta file
    inputBinding:
      position: 102
      prefix: -c
  - id: min_scaffold_length
    type:
      - 'null'
      - int
    doc: minimum output scaffolds length
    inputBinding:
      position: 102
      prefix: -l
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pin_hic:3.0.0--h577a1d6_5
