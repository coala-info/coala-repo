cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgFindSpec
label: ucsc-hgfindspec_hgFindSpec
doc: "Create hgFindSpec table from trackDb.ra files.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: orgDir
    type: Directory
    doc: Organization directory
    inputBinding:
      position: 1
  - id: database
    type: string
    doc: Database name
    inputBinding:
      position: 2
  - id: hgFindSpec_table
    type: string
    doc: hgFindSpec table name
    inputBinding:
      position: 3
  - id: hgFindSpec_sql
    type: File
    doc: hgFindSpec SQL file
    inputBinding:
      position: 4
  - id: hgRoot
    type: string
    doc: hgRoot directory
    inputBinding:
      position: 5
  - id: ra_name
    type:
      - 'null'
      - string
    doc: Specify a file name to use other than trackDb.ra for the ra files.
    inputBinding:
      position: 106
      prefix: -raName
  - id: release
    type:
      - 'null'
      - string
    doc: Include trackDb entries with this release tag only.
    inputBinding:
      position: 106
      prefix: -release
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Add spec to hgFindSpec only if its table(s) exist.
    inputBinding:
      position: 106
      prefix: -strict
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgfindspec:482--h0b57e2e_0
stdout: ucsc-hgfindspec_hgFindSpec.out
