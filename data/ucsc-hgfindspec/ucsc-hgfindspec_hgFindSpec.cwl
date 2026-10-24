cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgFindSpec
label: ucsc-hgfindspec_hgFindSpec
doc: "Create an hgFindSpec table from trackDb.ra files. The ra files are read from hgRoot, hgRoot/org and hgRoot/org/database. The program reads the MySQL server login from ~/.hg.conf (give it as hg_conf).\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .hg.conf
        entry: $(inputs.hg_conf)
inputs:
  - id: hg_conf
    type: File
    doc: "hg.conf file with db.host, db.user and db.password of a writable UCSC MySQL server (staged as ~/.hg.conf)"
  - id: strict
    type: ['null', boolean]
    doc: Add spec to hgFindSpec only if its table(s) exist
    inputBinding:
      prefix: -strict
      position: 1
  - id: ra_name
    type: ['null', string]
    doc: Specify a file name to use other than trackDb.ra for the ra files
    inputBinding:
      prefix: -raName=
      separate: false
      position: 2
  - id: release
    type: ['null', string]
    doc: Include trackDb entries with this release tag only (alpha, beta or public)
    inputBinding:
      prefix: -release=
      separate: false
      position: 3
  - id: org
    type: string
    doc: Organism directory name below hgRoot (for example human)
    inputBinding:
      position: 10
  - id: database
    type: string
    doc: Database name
    inputBinding:
      position: 11
  - id: hg_find_spec_table
    type: string
    doc: Name of the hgFindSpec table to create
    inputBinding:
      position: 12
  - id: hg_find_spec_sql
    type: File
    doc: hgFindSpec.sql table definition file
    inputBinding:
      position: 13
  - id: hg_root
    type: Directory
    doc: Root directory of the trackDb tree (contains org/database/trackDb.ra)
    inputBinding:
      position: 14
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgfindspec:482--h0b57e2e_0
stdout: ucsc-hgfindspec_hgFindSpec.out
