cwlVersion: v1.2
class: CommandLineTool
baseCommand: amulety
label: amulety
doc: "Atac-seq MULtiplet Estimation Tool (AMULET). Note: The provided text appears
  to be a container build/fetch error log rather than command-line help text, so no
  arguments could be extracted.\n\nTool homepage: https://github.com/immcantation/amulety"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amulety:2.1.2--pyh6d73907_0
stdout: amulety.out
