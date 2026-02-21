cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysais
label: pysais
doc: "A Python implementation of the SA-IS (Suffix Array Induced Sorting) algorithm.\n
  \nTool homepage: https://bitbucket.org/alex-warwickvesztrocy/pysais"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysais:1.1.0--py312hc9302aa_2
stdout: pysais.out
