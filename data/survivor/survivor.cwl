cwlVersion: v1.2
class: CommandLineTool
baseCommand: survivor
label: survivor
doc: "The provided text does not contain help information or usage instructions for
  the tool 'survivor'. It appears to be a log of a failed container build process.\n
  \nTool homepage: https://github.com/fritzsedlazeck/SURVIVOR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
stdout: survivor.out
