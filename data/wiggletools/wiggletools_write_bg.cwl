cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools
label: wiggletools_write_bg
doc: "Write a track into a bedGraph file (the write_bg operator), for example to convert a wiggle or bigWig into bedGraph.\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
arguments:
  - position: 1
    valueFrom: write_bg
  - position: 2
    valueFrom: $(inputs.output_name)
inputs:
  - id: input_file
    type: File
    doc: Input track (wig, bigWig, bedGraph, bed, bigBed, bam, cram, vcf, bcf), recognised by suffix.
    inputBinding:
      position: 3
  - id: output_name
    type: string
    doc: Output file name (bedGraph format).
    default: out.bg
outputs:
  - id: output_file
    type: File
    doc: The bedGraph file written by the 'write_bg' operator.
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
