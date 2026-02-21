cwlVersion: v1.2
class: CommandLineTool
baseCommand: mars
label: mars
doc: "The provided text contains error logs from a container runtime environment and
  does not include the help documentation or usage instructions for the 'mars' tool.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/maiziex/MARS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mars:1.2.4--pyhdfd78af_0
stdout: mars.out
