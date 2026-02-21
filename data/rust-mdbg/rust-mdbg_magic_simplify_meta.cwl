cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rust-mdbg
  - magic_simplify_meta
label: rust-mdbg_magic_simplify_meta
doc: "The provided text is a container execution/build error log and does not contain
  the help documentation or usage instructions for the tool. As a result, no arguments
  could be extracted.\n\nTool homepage: https://github.com/ekimb/rust-mdbg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-mdbg:1.0.1--h4ac6f70_3
stdout: rust-mdbg_magic_simplify_meta.out
