cwlVersion: v1.2
class: CommandLineTool
baseCommand: lsd
label: lsd
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or a description for the tool 'lsd'.\n\nTool
  homepage: https://github.com/lsd-rs/lsd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lsd:2.2.3--1
stdout: lsd.out
