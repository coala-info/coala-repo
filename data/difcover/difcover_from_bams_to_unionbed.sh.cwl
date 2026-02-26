cwlVersion: v1.2
class: CommandLineTool
baseCommand: from_bams_to_unionbed.sh
label: difcover_from_bams_to_unionbed.sh
doc: "Calculates coverage for BAM files using BEDTOOLS and SAMTOOLS. The main output
  reports coverage for input samples in corresponding columns for each bed interval.
  Additional files report coverage for each sample separately.\n\nTool homepage: https://github.com/timnat/DifCover"
inputs:
  - id: sample1_bam
    type: File
    doc: First input coordinate-sorted BAM file.
    inputBinding:
      position: 1
  - id: sample2_bam
    type: File
    doc: Second input coordinate-sorted BAM file.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/difcover:3.0.1--h9948957_2
stdout: difcover_from_bams_to_unionbed.sh.out
