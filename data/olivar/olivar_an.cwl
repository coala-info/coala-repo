cwlVersion: v1.2
class: CommandLineTool
baseCommand: olivar
label: olivar_an
doc: "olivar: error: argument subparser_name: invalid choice: 'an' (choose from build,
  tiling, save, specificity, sensitivity)\n\nTool homepage: https://gitlab.com/treangenlab/olivar"
inputs:
  - id: subparser_name
    type: string
    doc: Subcommand for olivar (build, tiling, save, specificity, sensitivity)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/olivar:1.3.3--pyhdfd78af_0
stdout: olivar_an.out
