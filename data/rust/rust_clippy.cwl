cwlVersion: v1.2
class: CommandLineTool
baseCommand: rust-clippy
label: rust_clippy
doc: "A collection of lints to catch common mistakes and improve your Rust code. Note:
  The provided text appears to be a container engine error log rather than CLI help
  text, so no arguments could be extracted.\n\nTool homepage: https://github.com/rust-lang/rust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust:1.14.0--0
stdout: rust_clippy.out
