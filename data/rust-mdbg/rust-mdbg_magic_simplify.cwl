cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rust-mdbg
  - magic_simplify
label: rust-mdbg_magic_simplify
doc: "The provided text does not contain help information for the tool. It appears
  to be a system log showing a failure to pull a container image.\n\nTool homepage:
  https://github.com/ekimb/rust-mdbg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-mdbg:1.0.1--h4ac6f70_3
stdout: rust-mdbg_magic_simplify.out
