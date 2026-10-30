cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools
label: wiggletools_lt
doc: "Regions where the track is strictly less than a cutoff (unary operator lt).\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
requirements:
  - class: InlineJavascriptRequirement
arguments:
  - position: 1
    valueFrom: "$(inputs.write_bedgraph ? 'write_bg' : 'write')"
  - position: 2
    valueFrom: $(inputs.output_name)
  - position: 3
    valueFrom: lt
inputs:
  - id: cutoff
    type: float
    doc: Cutoff value.
    inputBinding:
      position: 4
  - id: input_file
    type: File
    doc: Input track (wig, bigWig, bedGraph, bed, bigBed, bam, cram, vcf, bcf), recognised by suffix.
    inputBinding:
      position: 5
  - id: output_name
    type: string
    doc: Output file name (the 'write' operator; a wiggle file, or bedGraph with write_bedgraph).
    default: out.wig
  - id: write_bedgraph
    type: ['null', boolean]
    doc: Use the 'write_bg' operator, which writes bedGraph instead of wiggle.
outputs:
  - id: output_file
    type: File
    doc: The track written by the 'write' operator.
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
