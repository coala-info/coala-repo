cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtf_to_bed
label: flair_gtf_to_bed
doc: 'Convert a GTF annotation to bed12 (the output file extension decides the format).
  GTF exons need to be grouped by transcript and sorted by coordinate within a transcript.


  Tool homepage: https://github.com/BrooksLabUCSC/flair'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: include_gene
    type:
      - 'null'
      - boolean
    doc: Include the gene name in the isoform name
    inputBinding:
      position: 1
      prefix: --include_gene
  - id: gtf
    type: File
    doc: Annotated GTF
    inputBinding:
      position: 2
  - id: bed
    type: string
    doc: Output bed file name
    inputBinding:
      position: 3
outputs:
  - id: bed_file
    type: File
    doc: Output bed file
    outputBinding:
      glob: $(inputs.bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
