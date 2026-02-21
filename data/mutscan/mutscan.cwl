cwlVersion: v1.2
class: CommandLineTool
baseCommand: mutscan
label: mutscan
doc: "The provided text does not contain help information or a description of the
  tool; it is an error message regarding a container build failure due to insufficient
  disk space.\n\nTool homepage: https://github.com/OpenGene/genefuse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mutscan:1.14.1--h5ca1c30_0
stdout: mutscan.out
