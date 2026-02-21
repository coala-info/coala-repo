cwlVersion: v1.2
class: CommandLineTool
baseCommand: locidex
label: locidex
doc: "Locidex (Note: The provided text contains container runtime error logs rather
  than help documentation; no arguments could be extracted).\n\nTool homepage: https://pypi.org/project/locidex/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locidex:0.4.0--pyhdfd78af_0
stdout: locidex.out
