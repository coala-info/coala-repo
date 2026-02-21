cwlVersion: v1.2
class: CommandLineTool
baseCommand: footprint
label: footprint
doc: "The provided text does not contain help information for the tool 'footprint'.
  It contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull the image due to insufficient disk space.\n\nTool homepage: https://ohlerlab.mdc-berlin.de/software/Reproducible_footprinting_139/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/footprint:1.0.1--pl5321r41hdfd78af_0
stdout: footprint.out
