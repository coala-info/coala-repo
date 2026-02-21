cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfSort
label: ngs-bits_VcfSort
doc: "Sorts a VCF file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_09--py313h572c47f_0
stdout: ngs-bits_VcfSort.out
