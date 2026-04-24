cwlVersion: v1.2
class: CommandLineTool
baseCommand: amptk-remove_samples.py
label: amptk_remove
doc: "Script parses AMPtk de-multiplexed FASTQ file and keeps those sequences with
  barcode names in list\n\nTool homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: file
    type:
      - 'null'
      - File
    doc: File containing list of names to remove
    inputBinding:
      position: 101
      prefix: --file
  - id: format
    type:
      - 'null'
      - string
    doc: format of output file
    inputBinding:
      position: 101
      prefix: --format
  - id: input
    type: File
    doc: Input AMPtk demux FASTQ
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
  - id: out
    type: string
    doc: Output name
    inputBinding:
      position: 101
      prefix: --out
  - id: threshold
    type:
      - 'null'
      - string
    doc: Keep samples with more reads than threshold
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
stdout: amptk_remove.out
