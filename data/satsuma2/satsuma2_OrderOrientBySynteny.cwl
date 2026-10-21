cwlVersion: v1.2
class: CommandLineTool
baseCommand: [OrderOrientBySynteny]
label: satsuma2_OrderOrientBySynteny
doc: "Orders and orients scaffolds according to a synteny map.\n\nTool homepage: https://github.com/bioinfologics/satsuma2"
inputs:
  - id: input_file
    type: File
    doc: "input file (satsuma summary)"
    inputBinding:
      position: 1
      prefix: -i
  - id: fasta_file
    type: ['null', File]
    doc: "fasta file (def=)"
    inputBinding:
      position: 2
      prefix: -f
  - id: output_fasta
    type: ['null', string]
    doc: "output fasta file (def=superscaffolds.fasta)"
    default: superscaffolds.fasta
    inputBinding:
      position: 3
      prefix: -o
outputs:
  - id: scaffolds
    type: File
    doc: "Output FASTA file"
    outputBinding:
      glob: "$(inputs.output_fasta)"
  - id: log
    type: stdout
    doc: "Standard output of the program"
stdout: orderorientbysynteny.log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/satsuma2:20161123--1
