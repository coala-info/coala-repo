cwlVersion: v1.2
class: CommandLineTool
baseCommand: bel-resources
label: bel-resources
doc: "The provided text is a system error log regarding a failed container build (no
  space left on device) and does not contain CLI help information or usage instructions.\n
  \nTool homepage: https://github.com/pybel/bel-resources"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bel-resources:0.0.3--py_0
stdout: bel-resources.out
