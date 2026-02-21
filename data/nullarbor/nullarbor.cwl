cwlVersion: v1.2
class: CommandLineTool
baseCommand: nullarbor
label: nullarbor
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the nullarbor image due to insufficient disk space.\n\nTool homepage: https://github.com/tseemann/nullarbor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nullarbor:2.0.20191013--0
stdout: nullarbor.out
