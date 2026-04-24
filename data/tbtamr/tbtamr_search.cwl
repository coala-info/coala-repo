cwlVersion: v1.2
class: CommandLineTool
baseCommand: tbtamr_search
label: tbtamr_search
doc: "Search for variants in a catalog.\n\nTool homepage: https://github.com/MDU-PHL/tbtamr"
inputs:
  - id: catalog
    type:
      - 'null'
      - File
    doc: csv variant catalog
      /usr/local/lib/python3.13/site-packages/tbtamr/db/who_v2_catalog.csv
    inputBinding:
      position: 101
      prefix: --catalog
  - id: catalog_config
    type:
      - 'null'
      - File
    doc: json file indicating the relevant column settings for interpretation of
      the catalog file.
      /usr/local/lib/python3.13/site-packages/tbtamr/configs/db_config.json
    inputBinding:
      position: 101
      prefix: --catalog_config
  - id: query
    type:
      type: array
      items: string
    doc: The variant to search for. Multiple allowed separated by a space.
    inputBinding:
      position: 101
      prefix: --query
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbtamr:1.0.3--pyhdfd78af_0
stdout: tbtamr_search.out
