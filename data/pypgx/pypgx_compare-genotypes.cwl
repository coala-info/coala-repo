cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypgx compare-genotypes
label: pypgx_compare-genotypes
doc: "Calculate concordance between two genotype results.\n\nTool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: first
    type: File
    doc: First archive file with the semantic type SampleTable[Results].
    inputBinding:
      position: 1
  - id: second
    type: File
    doc: Second archive file with the semantic type SampleTable[Results].
    inputBinding:
      position: 2
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Whether to print the verbose version of output, including discordant 
      calls.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
stdout: pypgx_compare-genotypes.out
