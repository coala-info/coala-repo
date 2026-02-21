cwlVersion: v1.2
class: CommandLineTool
baseCommand: exomiser-rest-prioritiser
label: exomiser-rest-prioritiser
doc: "Exomiser REST prioritiser (Note: The provided help text contains only system
  error logs and no usage information).\n\nTool homepage: https://github.com/exomiser/Exomiser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/exomiser-rest-prioritiser:14.1.0--hdfd78af_0
stdout: exomiser-rest-prioritiser.out
