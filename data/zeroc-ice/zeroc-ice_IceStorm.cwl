cwlVersion: v1.2
class: CommandLineTool
baseCommand: icestorm
label: zeroc-ice_IceStorm
doc: "IceStorm is a publish-subscribe service for Ice applications. (Note: The provided
  help text contains container build errors and does not list command-line arguments.)\n
  \nTool homepage: https://github.com/zeroc-ice"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zeroc-ice:3.7.1--py35hd0a1c67_0
stdout: zeroc-ice_IceStorm.out
