cwlVersion: v1.2
class: CommandLineTool
baseCommand: cojac
label: cojac
doc: "The provided text does not contain help documentation for the tool 'cojac'.
  It contains system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull a Docker image due to insufficient disk space.\n\nTool homepage:
  https://github.com/cbg-ethz/cojac"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cojac:0.9.3--pyh7e72e81_0
stdout: cojac.out
