cwlVersion: v1.2
class: CommandLineTool
baseCommand: shannon
label: shannon
doc: "The provided text does not contain help information or a description of the
  tool; it contains system logs and a fatal error message regarding a failed container
  build due to insufficient disk space.\n\nTool homepage: http://sreeramkannan.github.io/Shannon/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shannon:0.0.2--py_0
stdout: shannon.out
