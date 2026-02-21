cwlVersion: v1.2
class: CommandLineTool
baseCommand: MappingQC
label: ngs-bits_MappingQC
doc: "Calculates QC metrics for a BAM/CRAM file. (Note: The provided help text contained
  only system error messages regarding container execution and did not list specific
  arguments.)\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_09--py313h572c47f_0
stdout: ngs-bits_MappingQC.out
