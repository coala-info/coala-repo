cwlVersion: v1.2
class: CommandLineTool
baseCommand: BamFilter
label: ngs-bits_BamFilter
doc: "Note: The provided help text contains a fatal error (no space left on device)
  and does not list the tool's usage or arguments.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_09--py313h572c47f_0
stdout: ngs-bits_BamFilter.out
