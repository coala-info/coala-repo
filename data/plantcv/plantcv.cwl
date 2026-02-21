cwlVersion: v1.2
class: CommandLineTool
baseCommand: plantcv
label: plantcv
doc: "The provided text does not contain help information or documentation for the
  plantcv tool. It consists of system logs and a fatal error message regarding a failed
  container build (no space left on device).\n\nTool homepage: https://plantcv.danforthcenter.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plantcv:3.8.0--py_0
stdout: plantcv.out
