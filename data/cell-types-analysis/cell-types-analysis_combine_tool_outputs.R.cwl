cwlVersion: v1.2
class: CommandLineTool
baseCommand: cell-types-analysis_combine_tool_outputs.R
label: cell-types-analysis_combine_tool_outputs.R
doc: "A tool to combine outputs from cell types analysis. Note: The provided help
  text contains only system error logs regarding a container build failure ('no space
  left on device') and does not list specific arguments.\n\nTool homepage: https://github.com/ebi-gene-expression-group/cell-types-analysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cell-types-analysis:0.1.11--hdfd78af_1
stdout: cell-types-analysis_combine_tool_outputs.R.out
