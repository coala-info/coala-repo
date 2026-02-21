cwlVersion: v1.2
class: CommandLineTool
baseCommand: SOAPdenovo-64mer
label: soapdenovo_SOAPdenovo-64mer
doc: "SOAPdenovo is a short-read assembly method designed to build de novo draft assemblies
  of large genomes.\n\nTool homepage: https://github.com/aquaskyline/SOAPdenovo2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/soapdenovo:v240_cv2
stdout: soapdenovo_SOAPdenovo-64mer.out
