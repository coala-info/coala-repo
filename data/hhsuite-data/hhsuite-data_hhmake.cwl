cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhmake
label: hhsuite-data_hhmake
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failure
  due to insufficient disk space.\n\nTool homepage: https://github.com/soedinglab/hh-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hhsuite-data:v3.0beta2dfsg-3-deb_cv1
stdout: hhsuite-data_hhmake.out
