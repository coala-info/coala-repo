cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdbdump
label: cdbtools_cdbdump
doc: "The provided text does not contain help information for the tool. It is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  or extract the container image due to insufficient disk space ('no space left on
  device').\n\nTool homepage: https://github.com/philpennock/cdbtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdbtools:0.99--h077b44d_12
stdout: cdbtools_cdbdump.out
