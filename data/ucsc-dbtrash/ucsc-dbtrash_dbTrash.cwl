cwlVersion: v1.2
class: CommandLineTool
baseCommand: dbTrash
label: ucsc-dbtrash_dbTrash
doc: "drop tables from a database older than specified N hours\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: age
    type: float
    doc: number of hours old to qualify for drop. N can be a float.
    inputBinding:
      position: 101
      prefix: -age
  - id: db
    type:
      - 'null'
      - string
    doc: Specify a database to work with, default is customTrash.
    default: customTrash
    inputBinding:
      position: 101
      prefix: -db
  - id: del_lost_table
    type:
      - 'null'
      - boolean
    doc: delete tables that exist but are missing from metaInfo - this operation
      can be even slower than -tableStatus - if there are many tables to check.
    inputBinding:
      position: 101
      prefix: -delLostTable
  - id: drop
    type:
      - 'null'
      - boolean
    doc: actually drop the tables, default is merely to display tables.
    inputBinding:
      position: 101
      prefix: -drop
  - id: drop_limit
    type:
      - 'null'
      - int
    doc: ERROR out if number of tables to drop is greater than limit, - default 
      is to drop all expired tables
    inputBinding:
      position: 101
      prefix: -dropLimit
  - id: ext_del
    type:
      - 'null'
      - boolean
    doc: delete lines in extFile that fail file check - otherwise just 
      verbose(2) lines that would be deleted
    inputBinding:
      position: 101
      prefix: -extDel
  - id: ext_file
    type:
      - 'null'
      - boolean
    doc: check extFile for lines that reference files - no longer in trash
    inputBinding:
      position: 101
      prefix: -extFile
  - id: history_too
    type:
      - 'null'
      - boolean
    doc: also consider the table called 'history' for deletion. - default is to 
      leave 'history' alone no matter how old. - this applies to the table 
      'metaInfo' also.
    inputBinding:
      position: 101
      prefix: -historyToo
  - id: table_status
    type:
      - 'null'
      - boolean
    doc: use 'show table status' to get size data, very inefficient
    inputBinding:
      position: 101
      prefix: -tableStatus
  - id: top_dir
    type:
      - 'null'
      - Directory
    doc: 'directory name to prepend to file names in extFile - default is /usr/local/apache/trash
      - file names in extFile are typically: "../trash/ct/..."'
    default: /usr/local/apache/trash
    inputBinding:
      position: 101
      prefix: -topDir
  - id: verbose
    type:
      - 'null'
      - int
    doc: 2 == show arguments, dates, and dropped tables, - 3 == show date 
      information for all tables.
    inputBinding:
      position: 101
      prefix: -verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-dbtrash:482--h0b57e2e_0
stdout: ucsc-dbtrash_dbTrash.out
