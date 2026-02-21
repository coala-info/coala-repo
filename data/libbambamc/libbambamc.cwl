cwlVersion: v1.2
class: CommandLineTool
baseCommand: libbambamc
label: libbambamc
doc: The provided text does not contain help information for the tool. It contains
  a system error message indicating a failure to build or run the container image
  due to insufficient disk space ('no space left on device').
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libbambamc:0.0.50--h577a1d6_6
stdout: libbambamc.out
