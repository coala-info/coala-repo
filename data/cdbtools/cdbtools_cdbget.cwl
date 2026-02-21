cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdbget
label: cdbtools_cdbget
doc: "The provided text does not contain help information for the tool. It is an error
  log from a container runtime (Apptainer/Singularity) indicating a 'no space left
  on device' failure during image extraction.\n\nTool homepage: https://github.com/philpennock/cdbtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdbtools:0.99--h077b44d_12
stdout: cdbtools_cdbget.out
