cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - refgenieserver
  - refgenie
label: refgenieserver_refgenie
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://refgenie.databio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refgenieserver:0.7.0--pyhdfd78af_0
stdout: refgenieserver_refgenie.out
