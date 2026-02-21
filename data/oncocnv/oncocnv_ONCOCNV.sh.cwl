cwlVersion: v1.2
class: CommandLineTool
baseCommand: oncocnv_ONCOCNV.sh
label: oncocnv_ONCOCNV.sh
doc: "ONCOCNV is a tool for detecting copy number variations. (Note: The provided
  text contains container runtime error logs rather than the tool's help documentation,
  so no arguments could be extracted.)\n\nTool homepage: https://github.com/BoevaLab/ONCOCNV/blob/master/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/oncocnv:v7.0_cv1
stdout: oncocnv_ONCOCNV.sh.out
