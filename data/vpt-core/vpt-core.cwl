cwlVersion: v1.2
class: CommandLineTool
baseCommand: vpt-core
label: vpt-core
doc: "The provided text does not contain help information or usage instructions for
  vpt-core; it appears to be a container runtime error log.\n\nTool homepage: https://github.com/Vizgen/vpt-core"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpt-core:1.2.0--pyhdfd78af_1
stdout: vpt-core.out
