cwlVersion: v1.2
class: CommandLineTool
baseCommand: SOAPdenovo-fusion
label: soapdenovo2_SOAPdenovo-fusion
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch the image.\n\nTool homepage: https://github.com/aquaskyline/SOAPdenovo2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soapdenovo2:2.40--1
stdout: soapdenovo2_SOAPdenovo-fusion.out
