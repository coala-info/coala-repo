cwlVersion: v1.2
class: CommandLineTool
baseCommand: bin2cell
label: bin2cell
doc: "A tool for processing spatial transcriptomics data (Note: The provided help
  text contains only system error logs and no usage information).\n\nTool homepage:
  https://github.com/Teichlab/bin2cell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bin2cell:0.3.4--pyhdfd78af_0
stdout: bin2cell.out
