cwlVersion: v1.2
class: CommandLineTool
baseCommand: dligand2
label: dligand2
doc: "A tool for protein-ligand binding site prediction (Note: The provided help text
  contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/sysu-yanglab/DLIGAND2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dligand2:0.1.0--h9948957_5
stdout: dligand2.out
