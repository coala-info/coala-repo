cwlVersion: v1.2
class: CommandLineTool
baseCommand: lamps
label: lamps
doc: "The provided text is an error message regarding a container build failure and
  does not contain help documentation or usage instructions for the 'lamps' tool.
  As a result, no arguments could be extracted.\n\nTool homepage: https://pypi.org/project/lamps/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lamps:1.0.4--pyhdfd78af_0
stdout: lamps.out
