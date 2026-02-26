cwlVersion: v1.2
class: CommandLineTool
baseCommand: create_metaplots.bash
label: ribotaper_create_metaplots.bash
doc: "Create metagene plots from Ribo-seq BAM files.\n\nTool homepage: https://github.com/boboppie/RiboTaper"
inputs:
  - id: ribo_bam
    type: File
    doc: Input Ribo-seq BAM file
    inputBinding:
      position: 1
  - id: bedfile
    type: File
    doc: BED file with genomic features
    inputBinding:
      position: 2
  - id: name
    type: string
    doc: Name for the output plots
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotaper:1.3.1--0
stdout: ribotaper_create_metaplots.bash.out
