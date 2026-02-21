cwlVersion: v1.2
class: CommandLineTool
baseCommand: refgenieserver
label: refgenieserver
doc: "A server for refgenie assets. (Note: The provided text contains error logs rather
  than help documentation; no arguments could be extracted from the input.)\n\nTool
  homepage: https://refgenie.databio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refgenieserver:0.7.0--pyhdfd78af_0
stdout: refgenieserver.out
