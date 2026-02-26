cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrifuge-RemoveN.pl
label: centrifuge-core_centrifuge-RemoveN.pl
doc: "Removes Ns from sequences in a FASTA file.\n\nTool homepage: https://github.com/infphilo/centrifuge"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
outputs:
  - id: output_fasta
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centrifuge-core:1.0.4.2--h5ca1c30_2
