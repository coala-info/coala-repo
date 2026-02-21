cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnavirhost
label: rnavirhost
doc: "RNA-VirHost (Note: The provided text contains container build logs and error
  messages rather than the tool's help documentation. No arguments could be extracted.)\n
  \nTool homepage: https://github.com/GreyGuoweiChen/VirHost.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnavirhost:1.0.5--pyh7cba7a3_0
stdout: rnavirhost.out
