cwlVersion: v1.2
class: CommandLineTool
baseCommand: numkit
label: numkit
doc: "Numerical toolkit (Note: The provided text contains container runtime error
  messages rather than the tool's help documentation).\n\nTool homepage: https://github.com/Becksteinlab/numkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/numkit:1.2.2--pyh5e36f6f_1
stdout: numkit.out
