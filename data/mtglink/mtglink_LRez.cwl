cwlVersion: v1.2
class: CommandLineTool
baseCommand: LRez
label: mtglink_LRez
doc: "LRez allows to work with barcoded Linked-Reads, and offers various barcode management
  functionalities.\n\nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to run. Available subcommands: compare, extract, stats, index
      bam, query bam, index fastq, query fastq'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
stdout: mtglink_LRez.out
