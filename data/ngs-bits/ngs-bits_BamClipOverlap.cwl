cwlVersion: v1.2
class: CommandLineTool
baseCommand: BamClipOverlap
label: ngs-bits_BamClipOverlap
doc: "The provided text does not contain help information for the tool. It contains
  a fatal error message indicating a failure to build the container image due to lack
  of disk space.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_09--py313h572c47f_0
stdout: ngs-bits_BamClipOverlap.out
