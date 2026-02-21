cwlVersion: v1.2
class: CommandLineTool
baseCommand: biom
label: biom-format_biom
doc: "The BIOM (Biological Observation Matrix) format is designed to be a general-use
  format for representing biological sample by observation contingency tables.\n\n
  Tool homepage: http://www.biom-format.org"
inputs:
  - id: command
    type: string
    doc: The subcommand to execute (add-metadata, convert, export-metadata, from-uc,
      head, normalize-table, show-install-info, subset-table, summarize-table, table-ids,
      or validate-table)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biom-format:2.1.15
stdout: biom-format_biom.out
