cwlVersion: v1.2
class: CommandLineTool
baseCommand: PloidyPlot
label: merquryfk_PloidyPlot
doc: "A tool for generating ploidy plots. (Note: The provided text contains only system
  error messages regarding container execution and does not include usage instructions
  or argument definitions.)\n\nTool homepage: https://github.com/thegenemyers/MERQURY.FK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
stdout: merquryfk_PloidyPlot.out
