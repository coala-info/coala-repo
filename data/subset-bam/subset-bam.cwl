cwlVersion: v1.2
class: CommandLineTool
baseCommand: subset-bam
label: subset-bam
doc: "Subsetting 10x Genomics BAM files\n\nTool homepage: https://github.com/10XGenomics/subset-bam"
inputs:
  - id: bam_file
    type: File
    doc: Cellranger BAM file.
    inputBinding:
      position: 101
      prefix: --bam
  - id: bam_tag
    type:
      - 'null'
      - string
    doc: Change from default value (CB) to subset alignments based on 
      alternative tags.
    inputBinding:
      position: 101
      prefix: --bam-tag
  - id: cell_barcodes
    type: File
    doc: File with cell barcodes to be extracted.
    inputBinding:
      position: 101
      prefix: --cell-barcodes
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to use. If larger than 1, will write BAM subsets to 
      temporary files before merging.
    inputBinding:
      position: 101
      prefix: --cores
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Logging level. [possible values: info, debug, error]'
    inputBinding:
      position: 101
      prefix: --log-level
outputs:
  - id: out_bam
    type: File
    doc: Output BAM.
    outputBinding:
      glob: $(inputs.out_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/subset-bam:1.1.0--h4349ce8_0
