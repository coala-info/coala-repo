cwlVersion: v1.2
class: CommandLineTool
baseCommand: callingcardstools
label: callingcardstools
doc: "The provided text does not contain help information. It is an error log from
  a container runtime (Apptainer/Singularity) indicating a failure to build or extract
  the container image due to insufficient disk space ('no space left on device').\n
  \nTool homepage: https://github.com/cmatKhan/callingCardsTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
stdout: callingcardstools.out
