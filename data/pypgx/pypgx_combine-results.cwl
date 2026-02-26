cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypgx_combine-results
label: pypgx_combine-results
doc: "Combine various results for target gene.\n\nTool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: results
    type: File
    doc: Output archive file with the semantic type SampleTable[Results].
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
  - id: genotypes
    type:
      - 'null'
      - File
    doc: Input archive file with the semantic type SampleTable[Genotypes].
    inputBinding:
      position: 102
      prefix: --genotypes
  - id: phenotypes
    type:
      - 'null'
      - File
    doc: Input archive file with the semantic type SampleTable[Phenotypes].
    inputBinding:
      position: 102
      prefix: --phenotypes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
stdout: pypgx_combine-results.out
