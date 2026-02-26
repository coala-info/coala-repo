cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - minisplice
  - gentrain
label: minisplice_gentrain
doc: "Generate training data for minisplice\n\nTool homepage: https://github.com/lh3/minisplice"
inputs:
  - id: in_bed
    type: File
    doc: Input BED file
    inputBinding:
      position: 1
  - id: in_fastx
    type: File
    doc: Input FASTX file
    inputBinding:
      position: 2
  - id: flanking_seq_length
    type:
      - 'null'
      - int
    doc: length of flanking sequences
    default: 100
    inputBinding:
      position: 103
      prefix: -l
  - id: positive_sites_fraction
    type:
      - 'null'
      - float
    doc: fraction of positive sites
    default: 0.25
    inputBinding:
      position: 103
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minisplice:0.4--h577a1d6_0
stdout: minisplice_gentrain.out
