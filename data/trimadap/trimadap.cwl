cwlVersion: v1.2
class: CommandLineTool
baseCommand: trimadap
label: trimadap
doc: "A tool for trimming adapter sequences from NGS reads (Note: The provided help
  text contains only system error messages indicating the executable was not found).\n
  \nTool homepage: https://github.com/lh3/trimadap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trimadap:r9--0
stdout: trimadap.out
