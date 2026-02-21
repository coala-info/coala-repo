cwlVersion: v1.2
class: CommandLineTool
baseCommand: cell-types-analysis_get_tool_pvals.R
label: cell-types-analysis_get_tool_pvals.R
doc: "Note: The provided text is a system error log indicating a container build failure
  ('no space left on device') and does not contain the help text or usage information
  for the tool. Consequently, no arguments could be extracted.\n\nTool homepage: https://github.com/ebi-gene-expression-group/cell-types-analysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cell-types-analysis:0.1.11--hdfd78af_1
stdout: cell-types-analysis_get_tool_pvals.R.out
