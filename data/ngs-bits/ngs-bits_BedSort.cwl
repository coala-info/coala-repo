cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedSort
label: ngs-bits_BedSort
doc: "The provided text is an error log indicating a failure to pull or build the
  container image (no space left on device) and does not contain the tool's help documentation
  or argument definitions.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_09--py313h572c47f_0
stdout: ngs-bits_BedSort.out
