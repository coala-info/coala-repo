cwlVersion: v1.2
class: CommandLineTool
baseCommand: superdsm
label: superdsm
doc: "The provided text does not contain help information or usage instructions for
  the tool; it appears to be a container runtime error log.\n\nTool homepage: https://github.com/BMCV/SuperDSM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/superdsm:0.4.0--pyhdfd78af_0
stdout: superdsm.out
