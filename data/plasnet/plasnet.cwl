cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasnet
label: plasnet
doc: "Plasmid network analysis tool (Note: The provided text is a container build
  error log and does not contain usage information or argument definitions).\n\nTool
  homepage: https://github.com/leoisl/plasnet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasnet:0.6.0--py312hdfd78af_0
stdout: plasnet.out
