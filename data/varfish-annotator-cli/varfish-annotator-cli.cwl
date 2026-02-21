cwlVersion: v1.2
class: CommandLineTool
baseCommand: varfish-annotator-cli
label: varfish-annotator-cli
doc: "No description available from the provided text.\n\nTool homepage: https://github.com/bihealth/varfish-annotator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varfish-annotator-cli:0.34--hdfd78af_0
stdout: varfish-annotator-cli.out
