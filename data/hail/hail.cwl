cwlVersion: v1.2
class: CommandLineTool
baseCommand: hail
label: hail
doc: "The provided text does not contain help information for the tool 'hail'. It
  contains system logs and a fatal error message regarding a container execution failure
  (no space left on device).\n\nTool homepage: https://hail.is"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hail:0.2.61--py311h9948957_3
stdout: hail.out
