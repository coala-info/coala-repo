cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pancake
  - addChrom
label: pancake_addchrom
doc: "Add chromosomes to a pancake database\n\nTool homepage: https://github.com/pancakeswap/pancake-frontend"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pancake:1.1.2--py35_0
stdout: pancake_addchrom.out
