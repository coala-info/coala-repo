cwlVersion: v1.2
class: CommandLineTool
baseCommand: exomiser-cli
label: exomiser-rest-prioritiser_exomiser-cli.jar
doc: "Exomiser is a tool for functional annotation and prioritisation of exome variants.
  (Note: The provided text contains only system error logs and no usage information;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/exomiser/Exomiser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/exomiser-rest-prioritiser:14.1.0--hdfd78af_0
stdout: exomiser-rest-prioritiser_exomiser-cli.jar.out
