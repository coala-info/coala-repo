cwlVersion: v1.2
class: CommandLineTool
baseCommand: ReadQC
label: ngs-bits_ReadQC
doc: "Quality control tool for NGS data (Note: The provided help text contains only
  container runtime error messages and no usage information).\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_09--py313h572c47f_0
stdout: ngs-bits_ReadQC.out
