cwlVersion: v1.2
class: CommandLineTool
baseCommand: mgs-canopy
label: mgs-canopy
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/fplazaonate/mgs-canopy-algorithm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgs-canopy:1.0--h9948957_9
stdout: mgs-canopy.out
