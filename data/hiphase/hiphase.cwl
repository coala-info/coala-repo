cwlVersion: v1.2
class: CommandLineTool
baseCommand: hiphase
label: hiphase
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation for the hiphase tool. As a result, no
  arguments or tool descriptions could be extracted.\n\nTool homepage: https://github.com/PacificBiosciences/HiPhase"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hiphase:1.6.0--h9ee0642_0
stdout: hiphase.out
