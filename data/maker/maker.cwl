cwlVersion: v1.2
class: CommandLineTool
baseCommand: maker
label: maker
doc: "MAKER is a genome annotation pipeline. (Note: The provided text contains container
  runtime error logs rather than help text, so no arguments could be extracted.)\n
  \nTool homepage: http://www.yandell-lab.org/software/maker.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maker:3.01.04--pl5321h7b50bb2_0
stdout: maker.out
