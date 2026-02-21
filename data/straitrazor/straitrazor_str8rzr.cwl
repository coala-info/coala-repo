cwlVersion: v1.2
class: CommandLineTool
baseCommand: str8rzr
label: straitrazor_str8rzr
doc: "StraitRazor is a tool for the analysis of Short Tandem Repeats (STRs) from sequencing
  data. (Note: The provided help text contains only system error logs and does not
  list specific arguments or usage instructions).\n\nTool homepage: https://github.com/Ahhgust/STRaitRazor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/straitrazor:3.0.1--h9948957_7
stdout: straitrazor_str8rzr.out
