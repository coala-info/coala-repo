cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgLoadOut
label: ucsc-hgloadout_hgLoadOut
doc: "Load RepeatMasker .out files into a database. For multiple files chrN.out this creates the single table rmsk in the database; use -split to obtain separate chrN_rmsk tables. The input .out file can also be a compressed .out.gz file. The program reads the MySQL server login from ~/.hg.conf (give it as hg_conf); with -tabFile no database is needed and the table data is written to the tab file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .hg.conf
        entry: $(inputs.hg_conf)
inputs:
  - id: hg_conf
    type: ['null', File]
    doc: "hg.conf file with db.host, db.user and db.password of a writable UCSC MySQL server (staged as ~/.hg.conf); not needed with -tabFile"
  - id: tab_file
    type: ['null', string]
    doc: Do not load the database, just create this tab file
    inputBinding:
      prefix: -tabFile=
      separate: false
      position: 1
  - id: split
    type: ['null', boolean]
    doc: Load chrN_rmsk separate tables even if a single file is given
    inputBinding:
      prefix: -split
      position: 2
  - id: table
    type: ['null', string]
    doc: Use a different suffix other than the default (rmsk)
    inputBinding:
      prefix: -table=
      separate: false
      position: 3
  - id: database
    type: string
    doc: Database to load into
    inputBinding:
      position: 10
  - id: files
    type: File[]
    doc: RepeatMasker .out file(s), plain or gzip compressed
    inputBinding:
      position: 11
outputs:
  - id: tab_out
    type: ['null', File]
    doc: Tab file written with -tabFile
    outputBinding:
      glob: $(inputs.tab_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgloadout:482--h0b57e2e_0
stdout: ucsc-hgloadout_hgLoadOut.out
