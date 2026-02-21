cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biscuit
  - rectangle
label: biscuit_rectangle
doc: "Process epiread files against a reference genome to generate a rectangle format
  output.\n\nTool homepage: https://github.com/huishenlab/biscuit"
inputs:
  - id: reference_fasta
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 1
  - id: input_epiread
    type: File
    doc: Input epiread file
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biscuit:1.7.1.20250908--hc4b60c0_0
