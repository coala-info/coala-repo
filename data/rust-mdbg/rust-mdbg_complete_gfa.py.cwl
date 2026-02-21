cwlVersion: v1.2
class: CommandLineTool
baseCommand: rust-mdbg_complete_gfa.py
label: rust-mdbg_complete_gfa.py
doc: "The provided text does not contain help information or a description of the
  tool; it appears to be a log of a failed container build or execution process.\n
  \nTool homepage: https://github.com/ekimb/rust-mdbg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-mdbg:1.0.1--h4ac6f70_3
stdout: rust-mdbg_complete_gfa.py.out
