cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-data
label: galaxy-data
doc: "Galaxy data management tool (Note: The provided text contains error logs rather
  than help documentation, so no arguments could be extracted).\n\nTool homepage:
  https://galaxyproject.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-data:25.0.4--pyhdfd78af_0
stdout: galaxy-data.out
