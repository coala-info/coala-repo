cwlVersion: v1.2
class: CommandLineTool
baseCommand: freyja_filter
label: freyja_filter
doc: "Excludes reads from INPUT_BAM containing one or more QUERY_MUTATIONS between
  MIN_SITE and MAX_SITE (genomic coordinates)\n\nTool homepage: https://github.com/andersen-lab/Freyja"
inputs:
  - id: query_mutations
    type: string
    doc: Query mutations
    inputBinding:
      position: 1
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 2
  - id: min_site
    type:
      - 'null'
      - string
    doc: Minimum genomic coordinate
    inputBinding:
      position: 3
  - id: max_site
    type:
      - 'null'
      - string
    doc: Maximum genomic coordinate
    inputBinding:
      position: 4
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: path to save filtered reads
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
