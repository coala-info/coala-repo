cwlVersion: v1.2
class: CommandLineTool
baseCommand: SampleAncestry
label: ngs-bits_SampleAncestry
doc: "Estimates the ancestry of a sample based on NGS data.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_09--py313h572c47f_0
stdout: ngs-bits_SampleAncestry.out
