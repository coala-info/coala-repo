cwlVersion: v1.2
class: CommandLineTool
baseCommand: merquryfk_CNplot
label: merquryfk_CNplot
doc: "A tool from the MerquryFK suite, likely used for generating copy number (CN)
  plots. Note: The provided help text contains only system error messages and no usage
  information.\n\nTool homepage: https://github.com/thegenemyers/MERQURY.FK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
stdout: merquryfk_CNplot.out
