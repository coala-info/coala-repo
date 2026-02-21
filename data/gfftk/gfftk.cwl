cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfftk
label: gfftk
doc: "The provided text does not contain help information for gfftk. It contains system
  error messages related to a container runtime (Apptainer/Singularity) failing to
  pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/nextgenusfs/gfftk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfftk:25.6.10--pyhdfd78af_0
stdout: gfftk.out
