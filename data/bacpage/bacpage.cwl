cwlVersion: v1.2
class: CommandLineTool
baseCommand: bacpage
label: bacpage
doc: "Bacterial Pangenome Analysis tool (Note: The provided text contains system error
  messages regarding disk space and container image retrieval rather than the tool's
  help documentation).\n\nTool homepage: https://github.com/CholGen/bacpage"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bacpage:2025.08.21--pyhdfd78af_0
stdout: bacpage.out
