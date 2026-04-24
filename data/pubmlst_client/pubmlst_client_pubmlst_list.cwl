cwlVersion: v1.2
class: CommandLineTool
baseCommand: pubmlst_list
label: pubmlst_client_pubmlst_list
doc: "List schemes from the PubMLST database with optional filtering\n\nTool homepage:
  https://github.com/Public-Health-Bioinformatics/pubmlst_client"
inputs:
  - id: base_url
    type:
      - 'null'
      - string
    doc: 'Base URL for the API. Suggested values are: http://rest.pubmlst.org/db (default),
      https://bigsdb.pasteur.fr/api/db'
    inputBinding:
      position: 101
      prefix: --base-url
  - id: exclude_pattern
    type:
      - 'null'
      - string
    doc: regex pattern to filter scheme names
    inputBinding:
      position: 101
      prefix: --exclude_pattern
  - id: names_only
    type:
      - 'null'
      - boolean
    doc: Only show scheme names
    inputBinding:
      position: 101
      prefix: --names_only
  - id: pattern
    type:
      - 'null'
      - string
    doc: regex pattern to filter scheme names
    inputBinding:
      position: 101
      prefix: --pattern
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pubmlst_client:0.2.0--py_0
stdout: pubmlst_client_pubmlst_list.out
