cwlVersion: v1.2
class: CommandLineTool
baseCommand: meningotype
label: meningotype
doc: "The provided text is a container runtime error log and does not contain the
  help documentation for meningotype. As a result, no arguments could be extracted.\n
  \nTool homepage: https://github.com/MDU-PHL/meningotype"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meningotype:0.8.5--pyhdfd78af_1
stdout: meningotype.out
