cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysctransform
label: pysctransform
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system logs and a fatal error message related to fetching
  a container image.\n\nTool homepage: https://github.com/saketkc/pySCTransform"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysctransform:0.1.1--pyhdfd78af_0
stdout: pysctransform.out
