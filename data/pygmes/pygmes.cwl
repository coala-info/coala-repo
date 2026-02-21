cwlVersion: v1.2
class: CommandLineTool
baseCommand: pygmes
label: pygmes
doc: "The provided text does not contain help information or a description of the
  tool; it appears to be a log of a failed container build/fetch process.\n\nTool
  homepage: https://github.com/openpaul/pygmes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygmes:0.1.7--py_0
stdout: pygmes.out
