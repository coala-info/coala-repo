cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools
label: wiggletools_varI
doc: "Variance of a track across all its points (statistic varI).\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
arguments:
  - position: 1
    valueFrom: varI
inputs:
  - id: input_file
    type: File
    doc: Input track (wig, bigWig, bedGraph, bed, bigBed, bam, cram, vcf, bcf), recognised by suffix.
    inputBinding:
      position: 2
stdout: varI.txt
outputs:
  - id: result
    type: stdout
    doc: The statistic, printed as a single number.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
