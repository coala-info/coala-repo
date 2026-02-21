cwlVersion: v1.2
class: CommandLineTool
baseCommand: proseg
label: rust-proseg
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build/execution attempt.\n\n
  Tool homepage: https://github.com/dcjones/proseg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-proseg:2.0.6--h4349ce8_0
stdout: rust-proseg.out
