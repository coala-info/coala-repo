cwlVersion: v1.2
class: CommandLineTool
baseCommand: rust-overlaps
label: rust-overlaps_rust_overlaps
doc: "The provided text does not contain help information for the tool, but appears
  to be a container runtime error log.\n\nTool homepage: https://github.com/jbaaijens/rust-overlaps"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-overlaps:0.1.1--h577a1d6_10
stdout: rust-overlaps_rust_overlaps.out
