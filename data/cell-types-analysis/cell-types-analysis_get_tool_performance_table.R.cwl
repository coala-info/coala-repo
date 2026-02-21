cwlVersion: v1.2
class: CommandLineTool
baseCommand: cell-types-analysis_get_tool_performance_table.R
label: cell-types-analysis_get_tool_performance_table.R
doc: "The provided text does not contain help information for the tool, as it consists
  of system error messages regarding a failed container build (no space left on device).\n
  \nTool homepage: https://github.com/ebi-gene-expression-group/cell-types-analysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cell-types-analysis:0.1.11--hdfd78af_1
stdout: cell-types-analysis_get_tool_performance_table.R.out
