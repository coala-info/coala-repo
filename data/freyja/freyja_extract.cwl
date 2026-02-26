cwlVersion: v1.2
class: CommandLineTool
baseCommand: freyja_extract
label: freyja_extract
doc: "Extracts reads from INPUT_BAM containing one or more QUERY_MUTATIONS\n\nTool
  homepage: https://github.com/andersen-lab/Freyja"
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
  - id: same_read
    type:
      - 'null'
      - boolean
    doc: include to specify that query reads must all occur on the same read
    inputBinding:
      position: 103
      prefix: --same_read
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: path to save extracted reads
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
