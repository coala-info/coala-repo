cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypgx call-genotypes
label: pypgx_call-genotypes
doc: "Call genotypes for target gene.\n\nTool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: genotypes
    type: File
    doc: Output archive file with the semantic type SampleTable[Genotypes].
    inputBinding:
      position: 1
  - id: alleles
    type:
      - 'null'
      - File
    doc: Input archive file with the semantic type SampleTable[Alleles].
    inputBinding:
      position: 102
      prefix: --alleles
  - id: cnv_calls
    type:
      - 'null'
      - File
    doc: Input archive file with the semantic type SampleTable[CNVCalls].
    inputBinding:
      position: 102
      prefix: --cnv-calls
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
stdout: pypgx_call-genotypes.out
