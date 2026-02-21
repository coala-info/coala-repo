cwlVersion: v1.2
class: CommandLineTool
baseCommand: rust_x.py
label: rust_x.py
doc: "The provided text does not contain help information or a description of the
  tool; it appears to be an error log from a container build process (Apptainer/Singularity).\n
  \nTool homepage: https://github.com/rust-lang/rust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust:1.14.0--0
stdout: rust_x.py.out
