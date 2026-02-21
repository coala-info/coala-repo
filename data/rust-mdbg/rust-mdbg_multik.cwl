cwlVersion: v1.2
class: CommandLineTool
baseCommand: rust-mdbg_multik
label: rust-mdbg_multik
doc: "The provided text does not contain help information for the tool; it appears
  to be a container runtime error log.\n\nTool homepage: https://github.com/ekimb/rust-mdbg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-mdbg:1.0.1--h4ac6f70_3
stdout: rust-mdbg_multik.out
