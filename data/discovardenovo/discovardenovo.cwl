cwlVersion: v1.2
class: CommandLineTool
baseCommand: discovardenovo
label: discovardenovo
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating a failure to build a container image due to lack of disk space.\n
  \nTool homepage: https://github.com/bayolau/discovardenovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/discovardenovo:52488--1
stdout: discovardenovo.out
