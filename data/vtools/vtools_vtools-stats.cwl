cwlVersion: v1.2
class: CommandLineTool
baseCommand: vtools-stats
label: vtools_vtools-stats
doc: "Calculate statistics for VCF files.\n\nTool homepage: https://github.com/LUMC/vtools"
inputs:
  - id: input_file
    type: File
    doc: Input VCF file
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vtools:1.1.0--py311h93dcfea_7
stdout: vtools_vtools-stats.out
