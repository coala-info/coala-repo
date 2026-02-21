cwlVersion: v1.2
class: CommandLineTool
baseCommand: rustup
label: rust_rustup
doc: "The provided text does not contain help information or usage instructions; it
  appears to be an error log from a container build process (Singularity/Apptainer).
  No arguments or tool descriptions could be extracted from the input.\n\nTool homepage:
  https://github.com/rust-lang/rust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust:1.14.0--0
stdout: rust_rustup.out
