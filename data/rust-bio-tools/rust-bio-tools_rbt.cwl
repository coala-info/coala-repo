cwlVersion: v1.2
class: CommandLineTool
baseCommand: rbt
label: rust-bio-tools_rbt
doc: "A set of ultra-fast command line utilities for bioinformatics tasks based on
  Rust-Bio.\n\nTool homepage: https://github.com/rust-bio/rust-bio-tools"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-bio-tools:0.42.2--h5c46d4b_3
stdout: rust-bio-tools_rbt.out
