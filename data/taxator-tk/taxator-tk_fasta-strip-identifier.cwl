cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasta-strip-identifier
label: taxator-tk_fasta-strip-identifier
doc: "Strips the identifier from FASTA sequences.\n\nTool homepage: https://github.com/fungs/taxator-tk"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file.
    inputBinding:
      position: 1
outputs:
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: Output FASTA file. If not specified, output will be written to stdout.
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxator-tk:1.3.3e--0
