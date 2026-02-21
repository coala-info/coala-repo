cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainflye
label: strainflye
doc: "The provided text does not contain help information or a description for the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/fedarko/strainFlye"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainflye:0.2.0--pyhca03a8a_0
stdout: strainflye.out
