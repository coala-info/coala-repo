cwlVersion: v1.2
class: CommandLineTool
baseCommand: clairvoyante_CreateTensor.py
label: clairvoyante_CreateTensor.py
doc: "The provided text does not contain help information or usage instructions for
  clairvoyante_CreateTensor.py. It appears to be a system error log from a Singularity/Apptainer
  build process that failed due to insufficient disk space ('no space left on device').\n
  \nTool homepage: https://github.com/aquaskyline/Clairvoyante"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clairvoyante:1.02--0
stdout: clairvoyante_CreateTensor.py.out
