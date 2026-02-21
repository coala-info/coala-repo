cwlVersion: v1.2
class: CommandLineTool
baseCommand: minialign
label: minialign
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to pull or build the Apptainer/Singularity container image
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/ocxtal/minialign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minialign:0.6.0--h577a1d6_0
stdout: minialign.out
