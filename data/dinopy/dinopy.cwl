cwlVersion: v1.2
class: CommandLineTool
baseCommand: dinopy
label: dinopy
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  pull the image due to insufficient disk space.\n\nTool homepage: https://bitbucket.org/HenningTimm/dinopy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dinopy:3.0.0--py310h184ae93_2
stdout: dinopy.out
