cwlVersion: v1.2
class: CommandLineTool
baseCommand: anvio
label: anvio
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build or extract a container image
  due to insufficient disk space.\n\nTool homepage: http://merenlab.org/software/anvio/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anvio:7--hdfd78af_1
stdout: anvio.out
