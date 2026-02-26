cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgx
  - create-consolidated-vcf
label: pypgx_create-consolidated-vcf
doc: "Create a consolidated VCF file.\n\nTool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: imported_variants
    type: File
    doc: Input archive file with the semantic type VcfFrame[Imported].
    inputBinding:
      position: 1
  - id: phased_variants
    type: File
    doc: Input archive file with the semantic type VcfFrame[Phased].
    inputBinding:
      position: 2
outputs:
  - id: consolidated_variants
    type: File
    doc: Output archive file with the semantic type VcfFrame[Consolidated].
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
