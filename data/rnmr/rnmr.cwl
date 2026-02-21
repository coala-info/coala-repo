cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnmr
label: rnmr
doc: "The provided text is a container build log and does not contain help information
  or usage instructions for the 'rnmr' tool. As a result, no arguments could be extracted.\n
  \nTool homepage: https://github.com/INRA/Rnmr1D"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rnmr:phenomenal-v1.1.9_cv0.2.1024
stdout: rnmr.out
