cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools
label: wiggletools_AUC
doc: "Area under the curve of a track, the sum of value times length (statistic AUC).\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
arguments:
  - position: 1
    valueFrom: AUC
inputs:
  - id: input_file
    type: File
    doc: Input track (wig, bigWig, bedGraph, bed, bigBed, bam, cram, vcf, bcf), recognised by suffix.
    inputBinding:
      position: 2
stdout: AUC.txt
outputs:
  - id: result
    type: stdout
    doc: The statistic, printed as a single number.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
