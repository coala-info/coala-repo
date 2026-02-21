cwlVersion: v1.2
class: CommandLineTool
baseCommand: garnett_check_markers.R
label: garnett-cli_garnett_check_markers.R
doc: "A tool to check marker files for Garnett cell type classification.\n\nTool homepage:
  https://github.com/ebi-gene-expression-group/garnett-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
stdout: garnett-cli_garnett_check_markers.R.out
