cwlVersion: v1.2
class: CommandLineTool
baseCommand: mykatlas
label: mykatlas
doc: "The provided text is a system error log regarding a container build failure
  and does not contain CLI help information or argument definitions.\n\nTool homepage:
  http://github.com/phelimb/atlas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mykatlas:0.6.1--py39hdff8610_8
stdout: mykatlas.out
