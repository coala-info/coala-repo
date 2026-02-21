cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrsfast
label: mrsfast
doc: "The provided text does not contain help information for mrsfast; it contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/sfu-compbio/mrsfast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrsfast:3.4.2--h577a1d6_5
stdout: mrsfast.out
