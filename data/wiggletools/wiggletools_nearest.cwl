cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools_nearest
label: wiggletools_nearest
doc: "Find the nearest feature in a wiggle file.\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
inputs:
  - id: input_wiggle
    type: File
    doc: Input wiggle file
    inputBinding:
      position: 1
  - id: input_features
    type: File
    doc: Input features file (e.g., BED, GFF)
    inputBinding:
      position: 2
  - id: distance
    type:
      - 'null'
      - boolean
    doc: Output the distance to the nearest feature
    inputBinding:
      position: 103
      prefix: --distance
  - id: downstream
    type:
      - 'null'
      - boolean
    doc: Only consider downstream features
    inputBinding:
      position: 103
      prefix: --downstream
  - id: max_distance
    type:
      - 'null'
      - int
    doc: Maximum distance to consider
    inputBinding:
      position: 103
      prefix: --max-distance
  - id: upstream
    type:
      - 'null'
      - boolean
    doc: Only consider upstream features
    inputBinding:
      position: 103
      prefix: --upstream
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
