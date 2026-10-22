cwlVersion: v1.2
class: CommandLineTool
baseCommand: retag.py
label: souporcell_retag.py
doc: "Retag reads with their cell barcodes and UMIs\n\nTool homepage: https://github.com/wheaton5/souporcell"
inputs:
  - id: sam
    type: File
    doc: "sam file"
    inputBinding:
      position: 11
      prefix: --sam
  - id: out
    type: string
    doc: "output (will be a bam)"
    inputBinding:
      position: 11
      prefix: --out
  - id: no_umi
    type:
      - 'null'
      - string
    doc: "set True if your bam has no umi tag"
    inputBinding:
      position: 11
      prefix: --no_umi
  - id: umi_tag
    type:
      - 'null'
      - string
    doc: "set if umi tag in output bam should not be UB"
    inputBinding:
      position: 11
      prefix: --umi_tag
  - id: cell_tag
    type:
      - 'null'
      - string
    doc: "set if cell barcode tag should not be CB"
    inputBinding:
      position: 11
      prefix: --cell_tag
outputs:
  - id: bam
    type: File
    doc: BAM with cell barcode and UMI tags restored
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/souporcell:2.5--hc1c3326_0
