cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamkit_sectosupp
label: bamkit_sectosupp
doc: "A tool from the bamkit suite. (Note: The provided help text contains system
  error logs regarding a container build failure and does not list usage instructions
  or arguments.)\n\nTool homepage: https://github.com/hall-lab/bamkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamkit:16.07.26--py_0
stdout: bamkit_sectosupp.out
