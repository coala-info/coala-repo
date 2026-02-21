cwlVersion: v1.2
class: CommandLineTool
baseCommand: trand
label: trand
doc: "The provided text does not contain help documentation for the tool 'trand'.
  It is a system error log from a container runtime (Singularity/Apptainer) indicating
  a failure to build or extract the tool's container image due to insufficient disk
  space ('no space left on device').\n\nTool homepage: https://github.com/McIntyre-Lab/TranD"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trand:22.10.13--pyhdfd78af_0
stdout: trand.out
