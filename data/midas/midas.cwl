cwlVersion: v1.2
class: CommandLineTool
baseCommand: midas
label: midas
doc: "Metagenomic Intra-Species Diversity Analysis System (Note: The provided help
  text contains only system error messages regarding container execution and does
  not list specific tool arguments).\n\nTool homepage: https://github.com/snayfach/MIDAS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/midas:1.3.2--py35_0
stdout: midas.out
