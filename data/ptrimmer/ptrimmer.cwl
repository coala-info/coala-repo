cwlVersion: v1.2
class: CommandLineTool
baseCommand: ptrimmer
label: ptrimmer
doc: "The provided text does not contain help information for ptrimmer; it is an error
  log from a container runtime (Apptainer/Singularity) failing to pull the tool's
  image.\n\nTool homepage: https://github.com/DMU-lilab/pTrimmer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptrimmer:1.4.0--h96c455f_1
stdout: ptrimmer.out
