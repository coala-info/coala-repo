cwlVersion: v1.2
class: CommandLineTool
baseCommand: riboseq-rust
label: riboseq-rust
doc: "The provided text does not contain help information for riboseq-rust; it is
  a container runtime error log.\n\nTool homepage: https://lapti.ucc.ie/rust/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboseq-rust:1.2--py27_0
stdout: riboseq-rust.out
