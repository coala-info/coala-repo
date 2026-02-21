cwlVersion: v1.2
class: CommandLineTool
baseCommand: modeltest-ng
label: modeltest-ng
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages related to a container runtime failure (no
  space left on device).\n\nTool homepage: https://github.com/ddarriba/modeltest"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/modeltest-ng:0.1.7--hf316886_3
stdout: modeltest-ng.out
