cwlVersion: v1.2
class: CommandLineTool
baseCommand: rust-bio-tools
label: rust-bio-tools
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build/fetch process.\n\nTool
  homepage: https://github.com/rust-bio/rust-bio-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-bio-tools:0.42.2--h5c46d4b_3
stdout: rust-bio-tools.out
