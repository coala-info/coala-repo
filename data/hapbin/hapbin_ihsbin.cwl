cwlVersion: v1.2
class: CommandLineTool
baseCommand: ihsbin
label: hapbin_ihsbin
doc: "A tool for calculating iHS (integrated Haplotype Score) statistics.\n\nTool
  homepage: https://github.com/evotools/hapbin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapbin:1.3.0--h503566f_6
stdout: hapbin_ihsbin.out
