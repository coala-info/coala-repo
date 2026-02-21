cwlVersion: v1.2
class: CommandLineTool
baseCommand: delve
label: delve-bio
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the delve-bio image due to insufficient disk space.\n\nTool homepage: https://github.com/berndbohmeier/delve"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/delve-bio:0.2.0--h4349ce8_0
stdout: delve-bio.out
