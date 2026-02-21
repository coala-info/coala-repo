cwlVersion: v1.2
class: CommandLineTool
baseCommand: jronn
label: jronn
doc: "The provided text does not contain help information or usage instructions for
  the tool 'jronn'. It contains system error messages related to a container runtime
  (Apptainer/Singularity) failing to build a SIF image due to insufficient disk space.\n
  \nTool homepage: https://biojava.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jronn:7.1.0--hdfd78af_1
stdout: jronn.out
