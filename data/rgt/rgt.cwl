cwlVersion: v1.2
class: CommandLineTool
baseCommand: rgt
label: rgt
doc: "Regulatory Genomics Toolbox (Note: The provided text is a container build error
  log and does not contain help documentation or argument definitions.)\n\nTool homepage:
  http://www.regulatory-genomics.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgt:1.0.2--py37he4a0461_0
stdout: rgt.out
