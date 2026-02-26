cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jass
  - list-phenotypes
label: jass_list-phenotypes
doc: "List available phenotypes\n\nTool homepage: http://statistical-genetics.pages.pasteur.fr/jass/"
inputs:
  - id: init_table_path
    type:
      - 'null'
      - string
    doc: Path to the initialization table
    inputBinding:
      position: 101
      prefix: --init-table-path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
stdout: jass_list-phenotypes.out
