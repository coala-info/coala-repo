cwlVersion: v1.2
class: CommandLineTool
baseCommand: mgkit
label: mgkit
doc: "Metagenomics Framework for Python (Note: The provided text contains system error
  logs regarding a container runtime failure and does not include tool-specific help
  text or arguments).\n\nTool homepage: https://github.com/frubino/mgkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
stdout: mgkit.out
