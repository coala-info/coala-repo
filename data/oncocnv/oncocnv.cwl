cwlVersion: v1.2
class: CommandLineTool
baseCommand: oncocnv
label: oncocnv
doc: "OncoCNV is a tool for detecting copy number variations (CNV) from NGS data.
  (Note: The provided text is a system error message and does not contain help documentation
  or argument details).\n\nTool homepage: https://github.com/BoevaLab/ONCOCNV/blob/master/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/oncocnv:v7.0_cv1
stdout: oncocnv.out
