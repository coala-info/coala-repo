cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgx
  - call-phenotypes
label: pypgx_call-phenotypes
doc: "Call phenotypes for target gene.\n\nTool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: genotypes
    type: File
    doc: Input archive file with the semantic type SampleTable[Genotypes].
    inputBinding:
      position: 1
  - id: phenotypes
    type: string
    doc: Output archive file with the semantic type SampleTable[Phenotypes].
    inputBinding:
      position: 2
outputs:
  - id: out_phenotypes
    type: File
    doc: Output archive file with the semantic type SampleTable[Phenotypes].
    outputBinding:
      glob: '$(inputs.phenotypes)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
