cwlVersion: v1.2
class: CommandLineTool
baseCommand: rustfmt
label: rust_rustfmt
doc: "The provided text does not contain help information for rustfmt; it is an error
  log from a container runtime (Apptainer/Singularity) failing to fetch or build the
  container image.\n\nTool homepage: https://github.com/rust-lang/rust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust:1.14.0--0
stdout: rust_rustfmt.out
