cwlVersion: v1.2
class: CommandLineTool
baseCommand: olivar
label: olivar_Olivar
doc: "olivar: error: argument subparser_name: invalid choice: 'Olivar' (choose from
  build, tiling, save, specificity, sensitivity)\n\nTool homepage: https://gitlab.com/treangenlab/olivar"
inputs:
  - id: subparser_name
    type: string
    doc: Subcommand to run (choose from build, tiling, save, specificity, 
      sensitivity)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/olivar:1.3.3--pyhdfd78af_0
stdout: olivar_Olivar.out
