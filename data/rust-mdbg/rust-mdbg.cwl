cwlVersion: v1.2
class: CommandLineTool
baseCommand: rust-mdbg
label: rust-mdbg
doc: "A tool for multi-k-mer de Bruijn graph construction. (Note: The provided text
  contains container runtime error logs rather than the tool's help documentation.)\n
  \nTool homepage: https://github.com/ekimb/rust-mdbg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-mdbg:1.0.1--h4ac6f70_3
stdout: rust-mdbg.out
