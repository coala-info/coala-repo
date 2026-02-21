cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyplink
label: pyplink
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build or fetch process.\n\nTool homepage: https://github.com/lemieuxl/pyplink"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyplink:1.3.7--pyh7e72e81_0
stdout: pyplink.out
