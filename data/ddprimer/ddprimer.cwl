cwlVersion: v1.2
class: CommandLineTool
baseCommand: ddprimer
label: ddprimer
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the tool 'ddprimer'.\n
  \nTool homepage: https://github.com/globuzzz2000/ddPrimer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ddprimer:0.1.1--pyhdfd78af_0
stdout: ddprimer.out
