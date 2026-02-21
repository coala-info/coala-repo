cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybascule
label: pybascule
doc: "The provided text does not contain help information or usage instructions for
  pybascule; it is an error log from a container build process.\n\nTool homepage:
  https://github.com/caravagnalab/pybascule"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybascule:1.0.1--pyhdfd78af_0
stdout: pybascule.out
