cwlVersion: v1.2
class: CommandLineTool
baseCommand: positionalTblCheck
label: ucsc-positionaltblcheck_positionalTblCheck
doc: "check that positional tables are sorted\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: EnvVarRequirement
    envDef:
      - envName: HGDB_CONF
        envValue: $(inputs.hg_conf.path)
inputs:
  - id: hg_conf
    type: File
    doc: "hg.conf file with the MySQL connection (db.host, db.user, db.password); passed through the HGDB_CONF environment variable"
  - id: db
    type: string
    doc: Database name
    inputBinding:
      position: 1
  - id: table
    type: string
    doc: Table name
    inputBinding:
      position: 2
  - id: verbose
    type:
      - 'null'
      - int
    doc: n>=2, print tables as checked
    inputBinding:
      position: 103
      prefix: -verbose=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (the program reports checked tables and problems here)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-positionaltblcheck:482--h0b57e2e_0
stdout: ucsc-positionaltblcheck_positionalTblCheck.out
stderr: ucsc-positionaltblcheck_positionalTblCheck.err
