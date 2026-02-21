cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhsuite-data
label: hhsuite-data
doc: "The provided text does not contain help information or usage instructions. It
  consists of system log messages and a fatal error indicating a failure to build
  the container image due to insufficient disk space.\n\nTool homepage: https://github.com/soedinglab/hh-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hhsuite-data:v3.0beta2dfsg-3-deb_cv1
stdout: hhsuite-data.out
