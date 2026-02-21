cwlVersion: v1.2
class: CommandLineTool
baseCommand: rabies
label: rabies
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build/fetch process for the 'rabies' tool.\n
  \nTool homepage: https://github.com/CoBrALab/RABIES"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rabies:0.5.5--pyhdfd78af_0
stdout: rabies.out
