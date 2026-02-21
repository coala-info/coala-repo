cwlVersion: v1.2
class: CommandLineTool
baseCommand: segzoo
label: segzoo
doc: "The provided text is a container build error log and does not contain help or
  usage information for the 'segzoo' tool.\n\nTool homepage: https://github.com/hoffmangroup/segzoo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segzoo:1.0.13--pyhdfd78af_0
stdout: segzoo.out
