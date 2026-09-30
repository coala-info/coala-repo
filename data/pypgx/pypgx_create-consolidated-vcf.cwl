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
  - id: consolidated_variants
    type: string
    doc: Output archive file with the semantic type VcfFrame[Consolidated].
    inputBinding:
      position: 3
outputs:
  - id: out_consolidated_variants
    type: File
    doc: Output archive file with the semantic type VcfFrame[Consolidated].
    outputBinding:
      glob: '$(inputs.consolidated_variants)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
