cwlVersion: v1.2
class: CommandLineTool
baseCommand: chunked-scatter
label: chunked-scatter
doc: "The provided text does not contain help information or a description of the
  tool; it contains system logs and a fatal error regarding a container build failure
  (no space left on device).\n\nTool homepage: https://github.com/biowdl/chunked-scatter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chunked-scatter:1.0.0--py_0
stdout: chunked-scatter.out
