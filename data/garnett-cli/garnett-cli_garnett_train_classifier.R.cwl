cwlVersion: v1.2
class: CommandLineTool
baseCommand: garnett-cli_garnett_train_classifier.R
label: garnett-cli_garnett_train_classifier.R
doc: "Train a Garnett classifier\n\nTool homepage: https://github.com/ebi-gene-expression-group/garnett-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
stdout: garnett-cli_garnett_train_classifier.R.out
