cwlVersion: v1.2
class: CommandLineTool
baseCommand: pvga
label: pvga
doc: "Pangenome Variation Graph Analyzer (Note: The provided text is a container build
  error log and does not contain help information or argument definitions).\n\nTool
  homepage: https://github.com/SoSongzhi/PVGA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pvga:0.1.2--pyh7e72e81_0
stdout: pvga.out
