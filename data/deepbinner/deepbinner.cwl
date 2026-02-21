cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepbinner
label: deepbinner
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log reporting a failure to build a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/rrwick/Deepbinner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepbinner:0.2.0--py36hc873e9d_0
stdout: deepbinner.out
