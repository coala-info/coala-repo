cwlVersion: v1.2
class: CommandLineTool
baseCommand: phlame_plot
label: phlame_plot
doc: "Generate informative output plots from lineage classification.\n\nTool homepage:
  https://github.com/quevan/phlame"
inputs:
  - id: input_data
    type: File
    doc: Path to input data file (required).
    inputBinding:
      position: 101
      prefix: --d
  - id: input_frequencies
    type: File
    doc: Path to input frequencies file (required).
    inputBinding:
      position: 101
      prefix: --f
  - id: max_pi
    type:
      - 'null'
      - float
    doc: Maximum pi value to count a lineage as present. Should be the same as 
      used in classify step.
    inputBinding:
      position: 101
      prefix: --max_pi
  - id: min_prob
    type:
      - 'null'
      - float
    doc: Minimum probability score to count a lineage as present. Should be the 
      same as used in classify step.
    inputBinding:
      position: 101
      prefix: --min_prob
  - id: output_path
    type: string
    doc: Path to output frequencies file (required).
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output
    type: File
    doc: Path to pdf of informative output plots (required).
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phlame:1.1.0--pyhdfd78af_0
