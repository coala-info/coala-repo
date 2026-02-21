cwlVersion: v1.2
class: CommandLineTool
baseCommand: lyner
label: lyner
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs from a container runtime environment.\n\nTool homepage:
  https://github.com/tedil/lyner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner.out
