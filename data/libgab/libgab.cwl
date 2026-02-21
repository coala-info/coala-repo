cwlVersion: v1.2
class: CommandLineTool
baseCommand: libgab
label: libgab
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/grenaud/libgab"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libgab:1.0.5--hdc46a4b_13
stdout: libgab.out
