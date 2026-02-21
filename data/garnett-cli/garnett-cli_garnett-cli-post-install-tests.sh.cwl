cwlVersion: v1.2
class: CommandLineTool
baseCommand: garnett-cli_garnett-cli-post-install-tests.sh
label: garnett-cli_garnett-cli-post-install-tests.sh
doc: "Post-installation tests for garnett-cli. Note: The provided text contains execution
  logs/errors rather than help documentation, so no arguments could be extracted.\n
  \nTool homepage: https://github.com/ebi-gene-expression-group/garnett-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
stdout: garnett-cli_garnett-cli-post-install-tests.sh.out
