cwlVersion: v1.2
class: CommandLineTool
baseCommand: soapdenovo
label: soapdenovo
doc: "The provided text does not contain help information or usage instructions for
  soapdenovo. It appears to be a log of a failed container build process.\n\nTool
  homepage: https://github.com/aquaskyline/SOAPdenovo2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/soapdenovo:v240_cv2
stdout: soapdenovo.out
