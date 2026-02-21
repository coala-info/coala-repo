cwlVersion: v1.2
class: CommandLineTool
baseCommand: rust-mdbg_to_basespace
label: rust-mdbg_to_basespace
doc: "The provided text does not contain help information for the tool, but appears
  to be a container runtime error log. No arguments could be extracted.\n\nTool homepage:
  https://github.com/ekimb/rust-mdbg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-mdbg:1.0.1--h4ac6f70_3
stdout: rust-mdbg_to_basespace.out
