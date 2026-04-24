cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools_entropy
label: wiggletools_entropy
doc: "Calculate the entropy of a wiggle track.\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
inputs:
  - id: input_file
    type: File
    doc: Input wiggle track file
    inputBinding:
      position: 1
  - id: bins
    type:
      - 'null'
      - int
    doc: Number of bins to use for entropy calculation
    inputBinding:
      position: 102
      prefix: --bins
  - id: log_scale
    type:
      - 'null'
      - boolean
    doc: Use log scale for entropy calculation
    inputBinding:
      position: 102
      prefix: --log-scale
  - id: max_value
    type:
      - 'null'
      - float
    doc: Maximum value to consider for entropy calculation
    inputBinding:
      position: 102
      prefix: --max-value
  - id: min_value
    type:
      - 'null'
      - float
    doc: Minimum value to consider for entropy calculation
    inputBinding:
      position: 102
      prefix: --min-value
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for the entropy track
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
