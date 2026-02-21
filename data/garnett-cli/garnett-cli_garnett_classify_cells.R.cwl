cwlVersion: v1.2
class: CommandLineTool
baseCommand: garnett_classify_cells.R
label: garnett-cli_garnett_classify_cells.R
doc: "A tool for classifying cells using Garnett. Note: The provided help text contained
  only system error messages regarding container execution and did not list specific
  command-line arguments.\n\nTool homepage: https://github.com/ebi-gene-expression-group/garnett-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
stdout: garnett-cli_garnett_classify_cells.R.out
