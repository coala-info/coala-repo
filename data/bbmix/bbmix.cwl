cwlVersion: v1.2
class: CommandLineTool
baseCommand: bbmix
label: bbmix
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or extract the container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/statbiomed/betabinmix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bbmix:0.2.2--pyhdfd78af_0
stdout: bbmix.out
