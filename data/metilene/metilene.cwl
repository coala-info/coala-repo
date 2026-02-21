cwlVersion: v1.2
class: CommandLineTool
baseCommand: metilene
label: metilene
doc: "A tool for fast and sensitive detection of differential DNA methylation (Note:
  The provided help text contains only system error messages and no usage information).\n
  \nTool homepage: http://www.bioinf.uni-leipzig.de/Software/metilene"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metilene:0.2.9--h7b50bb2_0
stdout: metilene.out
