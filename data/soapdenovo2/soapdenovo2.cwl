cwlVersion: v1.2
class: CommandLineTool
baseCommand: soapdenovo2
label: soapdenovo2
doc: "The provided text does not contain help information or usage instructions for
  soapdenovo2. It appears to be a series of log messages from a container runtime
  (Apptainer/Singularity) indicating a failure to fetch or build the tool's image.\n
  \nTool homepage: https://github.com/aquaskyline/SOAPdenovo2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soapdenovo2:2.40--1
stdout: soapdenovo2.out
