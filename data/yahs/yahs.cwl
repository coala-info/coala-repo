cwlVersion: v1.2
class: CommandLineTool
baseCommand: yahs
label: yahs
doc: "Yet Another Hi-C Scaffolder (Note: The provided text is a container build error
  log and does not contain the tool's help documentation or argument definitions.)\n
  \nTool homepage: https://github.com/c-zhou/yahs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yahs:1.2.2--h577a1d6_1
stdout: yahs.out
