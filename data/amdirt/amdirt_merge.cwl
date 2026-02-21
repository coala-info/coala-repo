cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amdirt
  - merge
label: amdirt_merge
doc: "Merges new dataset with existing table\n\nTool homepage: https://github.com/SPAAM-community/AMDirT"
inputs:
  - id: dataset
    type: File
    doc: path to tsv file of new dataset to merge
    inputBinding:
      position: 1
  - id: markdown
    type:
      - 'null'
      - boolean
    doc: Output is in markdown format
    inputBinding:
      position: 102
      prefix: --markdown
  - id: table_name
    type:
      - 'null'
      - string
    doc: Table name to merge into (ancientmetagenome-environmental, ancientmetagenome-hostassociated,
      ancientsinglegenome-hostassociated, or test)
    default: ancientmetagenome-hostassociated
    inputBinding:
      position: 102
      prefix: --table_name
  - id: table_type
    type:
      - 'null'
      - string
    doc: Table type (samples or libraries)
    default: libraries
    inputBinding:
      position: 102
      prefix: --table_type
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: path to sample output table file
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amdirt:1.7.0--pyhdfd78af_0
