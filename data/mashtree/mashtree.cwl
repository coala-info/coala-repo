cwlVersion: v1.2
class: CommandLineTool
baseCommand: mashtree
label: mashtree
doc: "The provided text does not contain help information for mashtree, but rather
  an error message regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/lskatz/mashtree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mashtree:1.4.6--pl5321h7b50bb2_3
stdout: mashtree.out
