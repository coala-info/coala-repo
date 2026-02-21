cwlVersion: v1.2
class: CommandLineTool
baseCommand: metasnv
label: metasnv
doc: "A tool for calling SNVs in metagenomic data (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: http://
  metasnv.embl.de"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metasnv:2.0.4--py311h13b32c1_9
stdout: metasnv.out
