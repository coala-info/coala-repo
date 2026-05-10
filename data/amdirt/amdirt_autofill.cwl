cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amdirt
  - autofill
label: amdirt_autofill
doc: "Autofills library and/or sample table(s) using ENA API and accession numbers\n\
  \ \nTool homepage: https://github.com/SPAAM-community/AMDirT"
inputs:
  - id: accession
    type:
      - 'null'
      - type: array
        items: string
    doc: ENA accession(s). Multiple accessions can be space separated (e.g. 
      PRJNA123 PRJNA456)
    inputBinding:
      position: 1
  - id: table_name
    type:
      - 'null'
      - string
    doc: Table name to autofill 
      [ancientmetagenome-environmental|ancientmetagenome-hostassociated|ancientsinglegenome-hostassociated|test]
    inputBinding:
      position: 102
      prefix: --table_name
  - id: library_output_path
    type:
      - 'null'
      - string
    doc: path to library output table file
    inputBinding:
      position: 103
      prefix: --library_output
  - id: output_ena_table_path
    type:
      - 'null'
      - string
    doc: path to ENA table output file
    inputBinding:
      position: 104
      prefix: --output_ena_table
  - id: sample_output_path
    type:
      - 'null'
      - string
    doc: path to sample output table file
    inputBinding:
      position: 105
      prefix: --sample_output
outputs:
  - id: output_ena_table
    type:
      - 'null'
      - File
    doc: path to ENA table output file
    outputBinding:
      glob: $(inputs.output_ena_table_path)
  - id: library_output
    type:
      - 'null'
      - File
    doc: path to library output table file
    outputBinding:
      glob: $(inputs.library_output_path)
  - id: sample_output
    type:
      - 'null'
      - File
    doc: path to sample output table file
    outputBinding:
      glob: $(inputs.sample_output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amdirt:1.7.0--pyhdfd78af_0
