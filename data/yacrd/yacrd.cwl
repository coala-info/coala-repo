cwlVersion: v1.2
class: CommandLineTool
baseCommand: yacrd
label: yacrd
doc: "The provided text does not contain help information for yacrd; it contains error
  logs from a container runtime (Singularity/Apptainer) failure while attempting to
  fetch the yacrd image.\n\nTool homepage: https://github.com/natir/yacrd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yacrd:1.0.0--h790517f_5
stdout: yacrd.out
