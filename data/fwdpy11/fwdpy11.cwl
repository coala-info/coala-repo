cwlVersion: v1.2
class: CommandLineTool
baseCommand: fwdpy11
label: fwdpy11
doc: "The provided text does not contain help information for fwdpy11; it contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull a Docker image due to insufficient disk space.\n\nTool homepage: https://github.com/molpopgen/fwdpy11"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fwdpy11:0.24.5--py311h0f4446f_0
stdout: fwdpy11.out
