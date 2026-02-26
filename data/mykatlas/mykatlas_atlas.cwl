cwlVersion: v1.2
class: CommandLineTool
baseCommand: atlas
label: mykatlas_atlas
doc: "myKATLAS atlas tool\n\nTool homepage: http://github.com/phelimb/atlas"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to run (genotype, walk, place, diff)
    inputBinding:
      position: 1
  - id: subcommand_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the chosen subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mykatlas:0.6.1--py39h6a678da_6
stdout: mykatlas_atlas.out
