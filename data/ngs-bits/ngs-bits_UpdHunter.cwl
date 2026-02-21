cwlVersion: v1.2
class: CommandLineTool
baseCommand: UpdHunter
label: ngs-bits_UpdHunter
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a system error log regarding container image conversion and
  disk space issues.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_09--py313h572c47f_0
stdout: ngs-bits_UpdHunter.out
