cwlVersion: v1.2
class: CommandLineTool
baseCommand: variantbreak
label: variantbreak
doc: "A tool for detecting structural variants from long-read sequencing data.\n\n
  Tool homepage: https://github.com/cytham/variantbreak"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/variantbreak:1.0.4--py_0
stdout: variantbreak.out
