cwlVersion: v1.2
class: CommandLineTool
baseCommand: makeTableList
label: ucsc-maketablelist_makeTableList
doc: "create/recreate tableList tables (cache of SHOW TABLES and DESCRIBE)\n\nTool
  homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: assemblies
    type:
      - 'null'
      - type: array
        items: string
    doc: Assemblies for which to create/recreate tableList tables
    inputBinding:
      position: 1
  - id: all
    type:
      - 'null'
      - boolean
    doc: recreate tableList for all active assemblies in hg.conf's hgcentral
    inputBinding:
      position: 102
      prefix: -all
  - id: big_files
    type:
      - 'null'
      - boolean
    doc: create table with tuples (track, name of bigfile)
    inputBinding:
      position: 102
      prefix: -bigFiles
  - id: hgcentral
    type:
      - 'null'
      - string
    doc: specify an alternative hgcentral db name when using -all
    inputBinding:
      position: 102
      prefix: -hgcentral
  - id: host
    type:
      - 'null'
      - string
    doc: 'show tables: mysql host'
    inputBinding:
      position: 102
      prefix: -host
  - id: password
    type:
      - 'null'
      - string
    doc: 'show tables: mysql password'
    inputBinding:
      position: 102
      prefix: -password
  - id: to_host
    type:
      - 'null'
      - string
    doc: 'alternative to toProf: mysql target host'
    inputBinding:
      position: 102
      prefix: -toHost
  - id: to_password
    type:
      - 'null'
      - string
    doc: 'alternative to toProf: mysql target pwd'
    inputBinding:
      position: 102
      prefix: -toPassword
  - id: to_prof
    type:
      - 'null'
      - string
    doc: 'optional: mysql profile to write table list to (target server)'
    inputBinding:
      position: 102
      prefix: -toProf
  - id: to_user
    type:
      - 'null'
      - string
    doc: 'alternative to toProf: mysql target user'
    inputBinding:
      position: 102
      prefix: -toUser
  - id: user
    type:
      - 'null'
      - string
    doc: 'show tables: mysql user'
    inputBinding:
      position: 102
      prefix: -user
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maketablelist:482--h0b57e2e_0
stdout: ucsc-maketablelist_makeTableList.out
