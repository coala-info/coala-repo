cwlVersion: v1.2
class: CommandLineTool
baseCommand: recycler
label: recycler
doc: "The provided text does not contain help information or usage instructions for
  the tool 'recycler'. It consists of system logs and a fatal error message related
  to building a container image.\n\nTool homepage: https://github.com/Shamir-Lab/Recycler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recycler:0.7--py27h24bf2e0_2
stdout: recycler.out
