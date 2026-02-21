cwlVersion: v1.2
class: CommandLineTool
baseCommand: cytocad
label: cytocad
doc: "The provided text does not contain help information for the tool; it contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/cytham/cytocad"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cytocad:1.0.3--py310h4b81fae_2
stdout: cytocad.out
