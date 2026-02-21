cwlVersion: v1.2
class: CommandLineTool
baseCommand: garnett_get_std_output.R
label: garnett-cli_garnett_get_std_output.R
doc: "A tool from the garnett-cli package. (Note: The provided help text was an error
  log and did not contain usage information or argument definitions.)\n\nTool homepage:
  https://github.com/ebi-gene-expression-group/garnett-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
stdout: garnett-cli_garnett_get_std_output.R.out
