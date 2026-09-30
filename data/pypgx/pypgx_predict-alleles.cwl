cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgx
  - predict-alleles
label: pypgx_predict-alleles
doc: "Predict candidate star alleles based on observed variants.\n\nTool homepage:
  https://github.com/sbslee/pypgx"
inputs:
  - id: consolidated_variants
    type: File
    doc: Input archive file with the semantic type VcfFrame[Consolidated].
    inputBinding:
      position: 1
  - id: alleles
    type: string
    doc: Output archive file with the semantic type SampleTable[Alleles].
    inputBinding:
      position: 2
outputs:
  - id: out_alleles
    type: File
    doc: Output archive file with the semantic type SampleTable[Alleles].
    outputBinding:
      glob: '$(inputs.alleles)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
