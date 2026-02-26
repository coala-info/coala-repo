cwlVersion: v1.2
class: CommandLineTool
baseCommand: LRez
label: leviathan_LRez
doc: "LRez allows to work with barcoded Linked-Reads, and offers various barcode management
  functionalities.\n\nTool homepage: https://github.com/morispi/LEVIATHAN"
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
    dockerPull: quay.io/biocontainers/leviathan:1.0.2--h9948957_4
stdout: leviathan_LRez.out
