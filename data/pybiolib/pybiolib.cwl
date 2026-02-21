cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybiolib
label: pybiolib
doc: "The provided text does not contain help information or a description of the
  tool; it contains system logs and a fatal error message regarding a container build
  process.\n\nTool homepage: https://github.com/biolib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybiolib:1.2.1882--pyhdfd78af_0
stdout: pybiolib.out
