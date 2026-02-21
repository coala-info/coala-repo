cwlVersion: v1.2
class: CommandLineTool
baseCommand: htsbox
label: htsbox
doc: "A tool for processing high-throughput sequencing data. (Note: The provided text
  contains system error messages regarding container image creation and does not include
  the actual help documentation or command-line arguments for the tool.)\n\nTool homepage:
  https://github.com/lh3/bcf2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htsbox:r312--0
stdout: htsbox.out
