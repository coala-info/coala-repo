cwlVersion: v1.2
class: CommandLineTool
baseCommand: garnett-cli_update_marker_file.R
label: garnett-cli_update_marker_file.R
doc: "Update marker file for Garnett. (Note: The provided text contains system error
  messages regarding container execution and does not include usage instructions or
  argument definitions.)\n\nTool homepage: https://github.com/ebi-gene-expression-group/garnett-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
stdout: garnett-cli_update_marker_file.R.out
