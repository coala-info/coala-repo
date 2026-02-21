cwlVersion: v1.2
class: CommandLineTool
baseCommand: methbat
label: methbat
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage instructions for the 'methbat' tool.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/PacificBiosciences/MethBat"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methbat:0.17.0--h9ee0642_0
stdout: methbat.out
