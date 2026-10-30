cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools
label: wiggletools_mwrite
doc: "Write several tracks side by side into one multidimensional wiggle file (the mwrite operator).\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
arguments:
  - position: 1
    valueFrom: mwrite
  - position: 2
    valueFrom: $(inputs.output_name)
inputs:
  - id: input_files
    type: File[]
    doc: Input tracks (wig, bigWig, bedGraph, bed, bigBed, bam, cram, vcf, bcf), recognised by suffix.
    inputBinding:
      position: 4
  - id: strict
    type: ['null', boolean]
    doc: Use the 'strict' keyword, so regions covered by only some of the tracks are skipped instead of filled with default values.
    inputBinding:
      position: 4
      prefix: strict
  - id: output_name
    type: string
    doc: Output file name (one value column per input track; use '-' for standard output).
    default: out.wig
outputs:
  - id: output_file
    type: File
    doc: The multidimensional wiggle file written by mwrite.
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
