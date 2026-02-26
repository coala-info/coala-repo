cwlVersion: v1.2
class: CommandLineTool
baseCommand: smoove
label: smoove_hipstr
doc: "Call STRs in BAM files\n\nTool homepage: https://github.com/brentp/smoove"
inputs:
  - id: bams
    type:
      type: array
      items: File
    doc: bams in which to call STRs
    inputBinding:
      position: 1
  - id: fasta
    type: File
    doc: path to reference fasta file
    inputBinding:
      position: 102
      prefix: --fasta
  - id: regions
    type: File
    doc: BED file of regions containing STRs
    inputBinding:
      position: 102
      prefix: --regions
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smoove:0.2.8--h9ee0642_1
stdout: smoove_hipstr.out
