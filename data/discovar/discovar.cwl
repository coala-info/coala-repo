cwlVersion: v1.2
class: CommandLineTool
baseCommand: discovar
label: discovar
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Apptainer/Singularity) failing to pull
  the image due to insufficient disk space.\n\nTool homepage: https://github.com/OliTechFR/Discovarr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/discovar:52488--0
stdout: discovar.out
