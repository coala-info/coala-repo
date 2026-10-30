cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools
label: wiggletools_write
doc: "Write a track into a wiggle file (the write operator), for example to convert a bigWig or bedGraph into wiggle format.\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
arguments:
  - position: 1
    valueFrom: write
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
    doc: Output file name (wiggle format; use '-' to write to standard output).
    default: out.wig
outputs:
  - id: output_file
    type: File
    doc: The wiggle file written by the 'write' operator.
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
