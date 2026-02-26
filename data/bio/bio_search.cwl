cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio
label: bio_search
doc: "Search biological databases\n\nTool homepage: https://github.com/ialbert/bio"
inputs:
  - id: words
    type:
      type: array
      items: string
    doc: Words to search for
    inputBinding:
      position: 1
  - id: all_fields
    type:
      - 'null'
      - boolean
    doc: get all possible fields
    inputBinding:
      position: 102
      prefix: --all
  - id: csv_output
    type:
      - 'null'
      - boolean
    doc: produce comma separated output
    inputBinding:
      position: 102
      prefix: --csv
  - id: download_limit
    type:
      - 'null'
      - int
    doc: download limit
    default: 5
    inputBinding:
      position: 102
      prefix: --limit
  - id: fields
    type:
      - 'null'
      - string
    doc: fields
    inputBinding:
      position: 102
      prefix: --fields
  - id: scopes
    type:
      - 'null'
      - string
    doc: scopes
    inputBinding:
      position: 102
      prefix: --scopes
  - id: show_headers
    type:
      - 'null'
      - boolean
    doc: show headers
    inputBinding:
      position: 102
      prefix: --header
  - id: species
    type:
      - 'null'
      - string
    doc: species
    default: ''
    inputBinding:
      position: 102
      prefix: --species
  - id: tab_output
    type:
      - 'null'
      - boolean
    doc: produce tab separated output
    inputBinding:
      position: 102
      prefix: --tab
  - id: update
    type:
      - 'null'
      - boolean
    doc: download the latest assebmly summary
    inputBinding:
      position: 102
      prefix: --update
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
stdout: bio_search.out
