cwlVersion: v1.2
class: CommandLineTool
baseCommand: egap
label: egap
doc: "The provided text does not contain help information for the tool 'egap'. It
  contains container runtime (Apptainer/Singularity) log messages and a fatal error
  regarding disk space during image conversion.\n\nTool homepage: https://github.com/iPsychonaut/EGAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/egap:3.3.7--pyhdfd78af_0
stdout: egap.out
