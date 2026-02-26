cwlVersion: v1.2
class: CommandLineTool
baseCommand: dig2
label: dig2
doc: "in silico digestion\n\nTool homepage: http://www.ms-utils.org/dig2/dig2.html"
inputs:
  - id: fasta_sequence_database
    type: File
    doc: FASTA sequence database
    inputBinding:
      position: 1
  - id: settings
    type: File
    doc: Settings file containing parameters for digestion/fragmentation
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dig2:1.0--h7b50bb2_7
stdout: dig2.out
