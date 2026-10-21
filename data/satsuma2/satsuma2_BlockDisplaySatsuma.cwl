cwlVersion: v1.2
class: CommandLineTool
baseCommand: [BlockDisplaySatsuma]
label: satsuma2_BlockDisplaySatsuma
doc: "Takes a satsuma summary file and writes displayable blocks.\n\nTool homepage: https://github.com/bioinfologics/satsuma2"
inputs:
  - id: summary_file
    type: File
    doc: "satsuma summary file"
    inputBinding:
      position: 1
      prefix: -i
  - id: target_fasta
    type: File
    doc: "target fasta file"
    inputBinding:
      position: 2
      prefix: -t
  - id: query_fasta
    type: File
    doc: "query fasta file"
    inputBinding:
      position: 3
      prefix: -q
  - id: min_block_size
    type: ['null', int]
    doc: "minimum block size (def=3)"
    inputBinding:
      position: 4
      prefix: -min
  - id: min_scaffold_size
    type: ['null', int]
    doc: "minimum scaffold size (def=100000)"
    inputBinding:
      position: 5
      prefix: -s
  - id: transpose
    type: ['null', boolean]
    doc: "switch query and target (def=0)"
    inputBinding:
      position: 6
      prefix: -transpose
outputs:
  - id: blocks
    type: stdout
    doc: "Displayable blocks (MizBee format), written to standard output"
stdout: $(inputs.summary_file.nameroot).blocks.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/satsuma2:20161123--1
