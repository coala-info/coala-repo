cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - askocli
  - integrate
label: askocli_integrate
doc: "Integrate data to a distant AskOmics. Uploads a CSV/TSV, GFF, BED or TTL file to an AskOmics server and integrates it; needs the server URL and an API key.\n\nTool homepage: https://github.com/askomics/askocli"
inputs:
  - id: apikey
    type: string
    doc: An API key associate with your account
    inputBinding:
      position: 1
      prefix: --apikey
  - id: askomics
    type: string
    doc: AskOmics URL
    inputBinding:
      position: 1
      prefix: --askomics
  - id: file_type
    type:
      - 'null'
      - string
    doc: The file type
    inputBinding:
      position: 1
      prefix: --file-type
  - id: public
    type:
      - 'null'
      - boolean
    doc: Make the integrated data public
    inputBinding:
      position: 1
      prefix: --public
  - id: uri
    type:
      - 'null'
      - string
    doc: Custom URI
    inputBinding:
      position: 1
      prefix: --uri
  - id: headers
    type:
      - 'null'
      - type: array
        items: string
    doc: List of custom headers (csv)
    inputBinding:
      position: 1
      prefix: --headers
  - id: key_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: List of the key columns index (csv)
    inputBinding:
      position: 1
      prefix: --key-columns
  - id: disabled_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: List of columns index to disable (csv)
    inputBinding:
      position: 1
      prefix: --disabled-columns
  - id: columns
    type:
      - 'null'
      - type: array
        items: string
    doc: List of forced columns types (csv)
    inputBinding:
      position: 1
      prefix: --columns
  - id: entities
    type:
      - 'null'
      - type: array
        items: string
    doc: List of entities to integrate (gff)
    inputBinding:
      position: 1
      prefix: --entities
  - id: taxon
    type:
      - 'null'
      - string
    doc: Taxon (gff and bed)
    inputBinding:
      position: 1
      prefix: --taxon
  - id: entity_name
    type:
      - 'null'
      - string
    doc: Entity name (bed)
    inputBinding:
      position: 1
      prefix: --entity-name
  - id: file
    type: File
    doc: File to integrate (CSV/TSV, GFF, BED or TTL); the tool fails without it
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/askocli:0.5--py_0
stdout: askocli_integrate.out
