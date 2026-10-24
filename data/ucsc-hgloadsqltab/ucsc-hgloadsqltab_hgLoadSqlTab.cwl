cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgLoadSqlTab
label: ucsc-hgloadsqltab_hgLoadSqlTab
doc: "Load a table into a database from a SQL create statement file and tab-separated text files. The actual table name comes from the command line, not from the sql file. The program reads the MySQL server login from ~/.hg.conf (give it as hg_conf).\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
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
  - id: warn
    type: ['null', boolean]
    doc: Warn instead of abort on mysql errors or warnings
    inputBinding:
      prefix: -warn
      position: 1
  - id: not_on_server
    type: ['null', boolean]
    doc: The file is not in a directory that the mysql server can see
    inputBinding:
      prefix: -notOnServer
      position: 2
  - id: old_table
    type: ['null', boolean]
    doc: Add to an existing table
    inputBinding:
      prefix: -oldTable
      position: 3
  - id: append
    type: ['null', boolean]
    doc: Add to an existing table (same as -oldTable)
    inputBinding:
      prefix: -append
      position: 4
  - id: database
    type: string
    doc: Database name
    inputBinding:
      position: 10
  - id: table
    type: string
    doc: Table name
    inputBinding:
      position: 11
  - id: sql_file
    type: File
    doc: File with the SQL create statement for the table
    inputBinding:
      position: 12
  - id: tab_files
    type: File[]
    doc: Tab-separated text file(s) with the rows of the table
    inputBinding:
      position: 13
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgloadsqltab:482--h0b57e2e_0
stdout: ucsc-hgloadsqltab_hgLoadSqlTab.out
