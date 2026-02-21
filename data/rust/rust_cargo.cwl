cwlVersion: v1.2
class: CommandLineTool
baseCommand: cargo
label: rust_cargo
doc: "The Rust package manager and build tool (Note: The provided text appears to
  be an execution log or error message rather than help text, so no arguments could
  be extracted).\n\nTool homepage: https://github.com/rust-lang/rust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust:1.14.0--0
stdout: rust_cargo.out
