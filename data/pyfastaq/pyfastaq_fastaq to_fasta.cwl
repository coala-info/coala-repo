cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfastaq_fastaq to_fasta
label: pyfastaq_fastaq to_fasta
doc: "Convert FASTA to FASTA format.\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Output FASTA file (default: stdout)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
