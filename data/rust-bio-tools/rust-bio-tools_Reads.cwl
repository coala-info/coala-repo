cwlVersion: v1.2
class: CommandLineTool
baseCommand: rbt
label: rust-bio-tools_Reads
doc: "A set of command-line utilities for bioinformatics, written in Rust.\n\nTool
  homepage: https://github.com/rust-bio/rust-bio-tools"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to execute
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
stdout: rust-bio-tools_Reads.out
