cwlVersion: v1.2
class: CommandLineTool
baseCommand: rust_x.ps1
label: rust_x.ps1
doc: "A script or tool involved in building or fetching OCI images (specifically Rust)
  and converting them to SIF format using Apptainer/Singularity.\n\nTool homepage:
  https://github.com/rust-lang/rust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust:1.14.0--0
stdout: rust_x.ps1.out
