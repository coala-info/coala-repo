cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tigmint-filter-paf
label: tigmint_tigmint-filter-paf
doc: "Given a PAF-formatted mapping file, output molecule extents BED\n\nTool homepage: https://github.com/bcgsc/tigmint"
inputs:
  - id: paf
    type: File
    doc: "Input PAF file"
    inputBinding:
      position: 2
  - id: m
    type:
      - 'null'
      - int
    doc: "Minimum size of output extents (bp)"
    inputBinding:
      position: 1
      prefix: -m
outputs:
  - id: stdout
    type: stdout
    doc: Molecule extents BED written to standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tigmint:1.2.10--py39h475c85d_4
stdout: tigmint_filter_paf.bed
