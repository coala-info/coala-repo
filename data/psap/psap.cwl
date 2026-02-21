cwlVersion: v1.2
class: CommandLineTool
baseCommand: psap
label: psap
doc: "The provided text does not contain help information for the tool 'psap'. It
  contains error logs related to a container build process.\n\nTool homepage: https://github.com/vanheeringen-lab/psap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psap:1.0.7--pyhdfd78af_0
stdout: psap.out
