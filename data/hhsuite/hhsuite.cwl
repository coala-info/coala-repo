cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhsuite
label: hhsuite
doc: "The provided text does not contain help information or usage instructions for
  hhsuite. It appears to be an error log from a container runtime (Singularity/Apptainer)
  indicating a failure to build or pull the container image due to insufficient disk
  space.\n\nTool homepage: https://github.com/soedinglab/hh-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
stdout: hhsuite.out
