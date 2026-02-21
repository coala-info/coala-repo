cwlVersion: v1.2
class: CommandLineTool
baseCommand: wgsim
label: wgsim
doc: "The provided text does not contain help or usage information for the tool; it
  contains Apptainer/Singularity container build logs and a fatal error message.\n
  \nTool homepage: https://github.com/lh3/wgsim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgsim:1.0--h577a1d6_10
stdout: wgsim.out
