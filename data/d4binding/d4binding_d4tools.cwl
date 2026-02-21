cwlVersion: v1.2
class: CommandLineTool
baseCommand: d4tools
label: d4binding_d4tools
doc: "A tool for handling D4 files (Note: The provided text is a container build error
  log and does not contain CLI help information or argument definitions).\n\nTool
  homepage: https://github.com/38/d4-format"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/d4binding:0.3.11--ha986137_4
stdout: d4binding_d4tools.out
