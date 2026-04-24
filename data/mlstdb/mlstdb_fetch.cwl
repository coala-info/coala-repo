cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlstdb_fetch
label: mlstdb_fetch
doc: "This tool downloads MLST scheme information from BIGSdb databases. It will automatically
  handle authentication and save the results.\n\nTool homepage: https://github.com/himal2007/mlstdb"
inputs:
  - id: database
    type:
      - 'null'
      - string
    doc: Database to use (pubmlst or pasteur)
    inputBinding:
      position: 101
      prefix: --db
  - id: exclude
    type:
      - 'null'
      - string
    doc: Scheme name must not include provided term
    inputBinding:
      position: 101
      prefix: --exclude
  - id: filter
    type:
      - 'null'
      - string
    doc: Filter species or schemes using a wildcard pattern
    inputBinding:
      position: 101
      prefix: --filter
  - id: match
    type:
      - 'null'
      - string
    doc: Scheme name must include provided term
    inputBinding:
      position: 101
      prefix: --match
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Resume processing from where it stopped
    inputBinding:
      position: 101
      prefix: --resume
  - id: scheme_uris
    type:
      - 'null'
      - string
    doc: 'Optional: Path to custom scheme_uris.tab file'
    inputBinding:
      position: 101
      prefix: --scheme-uris
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose logging for debugging
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mlstdb:0.2.0--pyh7e72e81_0
stdout: mlstdb_fetch.out
