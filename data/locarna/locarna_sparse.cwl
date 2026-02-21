cwlVersion: v1.2
class: CommandLineTool
baseCommand: locarna_sparse
label: locarna_sparse
doc: "The provided text is an error log from a container runtime and does not contain
  help information or argument definitions for the tool locarna_sparse.\n\nTool homepage:
  https://s-will.github.io/LocARNA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locarna:2.0.1--pl5321h9948957_2
stdout: locarna_sparse.out
