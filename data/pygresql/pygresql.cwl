cwlVersion: v1.2
class: CommandLineTool
baseCommand: pygresql
label: pygresql
doc: "Python interface for PostgreSQL (Note: The provided text appears to be a container
  build log rather than CLI help text, so no arguments could be extracted).\n\nTool
  homepage: https://github.com/PyGreSQL/PyGreSQL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygresql:5.0.1--py27_0
stdout: pygresql.out
