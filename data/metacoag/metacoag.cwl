cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacoag
label: metacoag
doc: "Metagenomic binning tool (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/metagentools/MetaCoAG"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacoag:1.2.2--py312h9ee0642_0
stdout: metacoag.out
