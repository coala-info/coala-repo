cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pancake
  - addAli
label: pancake_addali
doc: "Add alignments to a pancake project\n\nTool homepage: https://github.com/pancakeswap/pancake-frontend"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pancake:1.1.2--py35_0
stdout: pancake_addali.out
