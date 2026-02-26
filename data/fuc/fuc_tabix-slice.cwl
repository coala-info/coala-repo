cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - tabix-slice
label: fuc_tabix-slice
doc: "Slice a GFF/BED/SAM/VCF file with Tabix.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: file
    type: File
    doc: File to be sliced.
    inputBinding:
      position: 1
  - id: regions
    type:
      type: array
      items: string
    doc: One or more regions.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_tabix-slice.out
