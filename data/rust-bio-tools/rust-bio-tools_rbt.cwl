cwlVersion: v1.2
class: CommandLineTool
baseCommand: rbt
label: rust-bio-tools_rbt
doc: "A collection of command-line utilities for bioinformatics (Note: The provided
  text contained build logs rather than help documentation, so no arguments could
  be extracted).\n\nTool homepage: https://github.com/rust-bio/rust-bio-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-bio-tools:0.42.2--h5c46d4b_3
stdout: rust-bio-tools_rbt.out
