cwlVersion: v1.2
class: CommandLineTool
baseCommand: garnett-cli_parse_expr_data.R
label: garnett-cli_parse_expr_data.R
doc: "A tool for parsing expression data, part of the Garnett-cli suite. (Note: The
  provided help text contains only system error logs and no argument definitions.)\n
  \nTool homepage: https://github.com/ebi-gene-expression-group/garnett-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
stdout: garnett-cli_parse_expr_data.R.out
