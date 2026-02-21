cwlVersion: v1.2
class: CommandLineTool
baseCommand: hanselx
label: hanselx
doc: "The provided text does not contain help information or usage instructions for
  hanselx; it contains system logs and a fatal error regarding disk space during a
  container build process.\n\nTool homepage: https://github.com/SamStudio8/hansel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hanselx:0.0.92--py_0
stdout: hanselx.out
