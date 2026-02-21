cwlVersion: v1.2
class: CommandLineTool
baseCommand: psosp
label: psosp
doc: "The provided text does not contain help information for the tool 'psosp'. It
  appears to be a log of a failed container build attempt using Apptainer/Singularity.\n
  \nTool homepage: https://github.com/mujiezhang/PSOSP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psosp:1.1.2--pyhdfd78af_2
stdout: psosp.out
