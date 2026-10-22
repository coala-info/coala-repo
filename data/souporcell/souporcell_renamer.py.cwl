cwlVersion: v1.2
class: CommandLineTool
baseCommand: renamer.py
label: souporcell_renamer.py
doc: "make fastq from possorted_genome_bam.bam from cellranger\n\nTool homepage: https://github.com/wheaton5/souporcell"
inputs:
  - id: bam
    type: File
    doc: "cellranger bam"
    secondaryFiles:
      - pattern: '.bai'
        required: false
      - pattern: '^.bai'
        required: false
    inputBinding:
      position: 11
      prefix: --bam
  - id: barcodes
    type: File
    doc: "cellranger barcodes.tsv"
    inputBinding:
      position: 11
      prefix: --barcodes
  - id: out
    type: string
    doc: "output fastq name"
    inputBinding:
      position: 11
      prefix: --out
  - id: chrom
    type:
      - 'null'
      - string
    doc: "chrom"
    inputBinding:
      position: 11
      prefix: --chrom
  - id: start
    type:
      - 'null'
      - int
    doc: "start"
    inputBinding:
      position: 11
      prefix: --start
  - id: end
    type:
      - 'null'
      - int
    doc: "end"
    inputBinding:
      position: 11
      prefix: --end
  - id: no_umi
    type:
      - 'null'
      - string
    doc: "set to True if your bam has no umi tag"
    inputBinding:
      position: 11
      prefix: --no_umi
  - id: umi_tag
    type:
      - 'null'
      - string
    doc: "set if umi tag is not UB"
    inputBinding:
      position: 11
      prefix: --umi_tag
  - id: cell_tag
    type:
      - 'null'
      - string
    doc: "set if cell barcode tag is not CB"
    inputBinding:
      position: 11
      prefix: --cell_tag
outputs:
  - id: fastq
    type: File
    doc: Fastq with cell barcodes and UMIs in the read names
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/souporcell:2.5--hc1c3326_0
