cwlVersion: v1.2
class: CommandLineTool
baseCommand: UniProtMapper
label: uniprot-id-mapper_protmap
doc: "Retrieve data from UniProt using UniProt's RESTful API. For a list of all\n\
  available fields, see: https://www.uniprot.org/help/return_fields.\nAlternatively,
  use the --print-fields argument to print the available fields\nand exit the program.\n\
  \nTool homepage: https://github.com/David-Araripe/UniProtMapper"
inputs:
  - id: default_fields
    type:
      - 'null'
      - boolean
    doc: "This option will override the --return-fields option.\n                \
      \        Returns only the default fields stored in:\n                      \
      \  /usr/local/lib/python3.13/site-\n                        packages/UniProtMapper/resources/cli_return_fields.txt"
    inputBinding:
      position: 101
      prefix: --default-fields
  - id: from_db
    type:
      - 'null'
      - string
    doc: "The database from which the IDs are. For the available\n               \
      \         cross references, see: /usr/local/lib/python3.13/site-\n         \
      \               packages/UniProtMapper/resources/uniprot_mapping_dbs.j\n   \
      \                     son"
    inputBinding:
      position: 101
      prefix: --from-db
  - id: ids
    type:
      type: array
      items: string
    doc: "List of UniProt IDs to retrieve information from.\n                    \
      \    Values must be separated by spaces."
    inputBinding:
      position: 101
      prefix: --ids
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "If desired to overwrite an existing file when using\n                  \
      \      -o/--output"
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: print_fields
    type:
      - 'null'
      - boolean
    doc: "Prints the available return fields and exits the\n                     \
      \   program."
    inputBinding:
      position: 101
      prefix: --print-fields
  - id: return_fields
    type:
      - 'null'
      - type: array
        items: string
    doc: "If not defined, will pass `None`, returning all\n                      \
      \  available fields. Else, values should be fields to be\n                 \
      \       returned separated by spaces. See --print-fields for\n             \
      \           available options."
    default: None
    inputBinding:
      position: 101
      prefix: --return-fields
  - id: to_db
    type:
      - 'null'
      - string
    doc: "The database to which the IDs will be mapped. For the\n                \
      \        available cross references, see:\n                        /usr/local/lib/python3.13/site-packages/UniProtMapper/\n\
      \                        resources/uniprot_mapping_dbs.json"
    inputBinding:
      position: 101
      prefix: --to-db
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: "Path to the output file to write the returned fields.\n                \
      \        If not provided, will write to stdout."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uniprot-id-mapper:1.1.4--pyh7e72e81_0
