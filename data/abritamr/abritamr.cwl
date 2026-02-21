cwlVersion: v1.2
class: CommandLineTool
baseCommand: abritamr
label: abritamr
doc: "A tool for antimicrobial resistance gene detection (Note: The provided text
  is a container build error log and does not contain the tool's help documentation).\n
  \nTool homepage: https://github.com/MDU-PHL/abritamr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abritamr:1.0.20--pyh5707d69_0
stdout: abritamr.out
