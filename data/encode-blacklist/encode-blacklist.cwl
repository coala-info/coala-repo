cwlVersion: v1.2
class: CommandLineTool
baseCommand: encode-blacklist
label: encode-blacklist
doc: "The provided text does not contain help information for the tool. It contains
  system error messages regarding a container runtime (Apptainer/Singularity) failure
  due to insufficient disk space.\n\nTool homepage: https://github.com/Boyle-Lab/Blacklist"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/encode-blacklist:2.0--ha7703dc_3
stdout: encode-blacklist.out
