cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedLowCoverage
label: ngs-bits_BedLowCoverage
doc: "The provided text does not contain help information for the tool. It contains
  a system error message regarding container execution (no space left on device).\n
  \nTool homepage: https://github.com/imgag/ngs-bits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_09--py313h572c47f_0
stdout: ngs-bits_BedLowCoverage.out
