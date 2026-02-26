cwlVersion: v1.2
class: CommandLineTool
baseCommand: amptk-drop.py
label: amptk_drop
doc: "Script that drops OTUs and then creates OTU table\n\nTool homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: file
    type:
      - 'null'
      - File
    doc: File containing list of names to remove
    inputBinding:
      position: 101
      prefix: --file
  - id: input
    type: File
    doc: OTUs in FASTA format
    inputBinding:
      position: 101
      prefix: --input
  - id: list
    type:
      - 'null'
      - type: array
        items: string
    doc: Input list of (BC) names to remove
    inputBinding:
      position: 101
      prefix: --list
  - id: reads
    type: File
    doc: Demuxed reads FASTQ format
    inputBinding:
      position: 101
      prefix: --reads
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Base output name
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
