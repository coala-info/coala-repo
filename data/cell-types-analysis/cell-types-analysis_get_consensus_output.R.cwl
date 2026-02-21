cwlVersion: v1.2
class: CommandLineTool
baseCommand: cell-types-analysis_get_consensus_output.R
label: cell-types-analysis_get_consensus_output.R
doc: "A tool to get consensus output for cell types analysis. (Note: The provided
  help text contains system error messages regarding container image extraction and
  does not list specific command-line arguments.)\n\nTool homepage: https://github.com/ebi-gene-expression-group/cell-types-analysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cell-types-analysis:0.1.11--hdfd78af_1
stdout: cell-types-analysis_get_consensus_output.R.out
