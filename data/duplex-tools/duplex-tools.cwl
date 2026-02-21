cwlVersion: v1.2
class: CommandLineTool
baseCommand: duplex-tools
label: duplex-tools
doc: "The provided text does not contain help information for duplex-tools; it contains
  error logs related to a container runtime (Apptainer/Singularity) failing to pull
  the image due to insufficient disk space.\n\nTool homepage: https://github.com/nanoporetech/duplex_tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/duplex-tools:0.3.3--pyhdfd78af_0
stdout: duplex-tools.out
