cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypgx predict-alleles
label: pypgx_predict-alleles
doc: "Predict candidate star alleles based on observed variants.\n\nTool homepage:
  https://github.com/sbslee/pypgx"
inputs:
  - id: consolidated_variants
    type: File
    doc: Input archive file with the semantic type VcfFrame[Consolidated].
    inputBinding:
      position: 1
outputs:
  - id: alleles
    type: File
    doc: Output archive file with the semantic type SampleTable[Alleles].
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
