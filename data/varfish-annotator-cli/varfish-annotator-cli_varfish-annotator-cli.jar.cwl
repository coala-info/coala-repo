cwlVersion: v1.2
class: CommandLineTool
baseCommand: varfish-annotator-cli
label: varfish-annotator-cli_varfish-annotator-cli.jar
doc: "VarFish Annotator CLI (Note: The provided text is a container build log and
  does not contain help information or argument definitions).\n\nTool homepage: https://github.com/bihealth/varfish-annotator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varfish-annotator-cli:0.34--hdfd78af_0
stdout: varfish-annotator-cli_varfish-annotator-cli.jar.out
