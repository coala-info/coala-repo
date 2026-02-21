cwlVersion: v1.2
class: CommandLineTool
baseCommand: locityper
label: locityper
doc: "A tool for genotyping complex loci (Note: The provided help text contains only
  system error messages and does not list usage or arguments).\n\nTool homepage: https://github.com/tprodanov/locityper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locityper:1.3.4--ha6fb395_0
stdout: locityper.out
