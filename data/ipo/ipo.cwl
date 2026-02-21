cwlVersion: v1.2
class: CommandLineTool
baseCommand: ipo
label: ipo
doc: "The provided text does not contain help information for the tool 'ipo'. It appears
  to be an error log from a container runtime (Apptainer/Singularity) indicating a
  failure to pull or build the container image due to insufficient disk space.\n\n
  Tool homepage: https://github.com/coin-or/Ipopt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ipo:v1.7.5_cv0.3
stdout: ipo.out
