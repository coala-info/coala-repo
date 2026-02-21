cwlVersion: v1.2
class: CommandLineTool
baseCommand: iso2flux
label: iso2flux
doc: "The provided text does not contain help information or usage instructions for
  iso2flux. It contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull a Docker image due to insufficient disk space.\n\nTool homepage:
  https://github.com/cfoguet/iso2flux"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/iso2flux:phenomenal-v0.7.1_cv2.1.60
stdout: iso2flux.out
