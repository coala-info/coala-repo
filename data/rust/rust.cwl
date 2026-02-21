cwlVersion: v1.2
class: CommandLineTool
baseCommand: rust
label: rust
doc: "The provided text does not contain help information for the 'rust' command;
  it appears to be a log from a container build process (Singularity/Apptainer) that
  encountered a fatal error while fetching an OCI image.\n\nTool homepage: https://github.com/rust-lang/rust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust:1.14.0--0
stdout: rust.out
