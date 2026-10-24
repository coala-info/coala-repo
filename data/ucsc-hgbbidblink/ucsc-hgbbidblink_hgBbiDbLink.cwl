cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgBbiDbLink
label: ucsc-hgbbidblink_hgBbiDbLink
doc: "Add a table that just contains a pointer to a bbiFile to a database. This program is used to add bigWigs and bigBeds. The program reads the MySQL server login from ~/.hg.conf (give it as hg_conf).\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
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
  - id: database
    type: string
    doc: Database name
    inputBinding:
      position: 1
  - id: track_name
    type: string
    doc: Track (table) name to create
    inputBinding:
      position: 2
  - id: file_name
    type: string
    doc: Path of the bbiFile (bigWig or bigBed) stored in the table; it is only recorded, not read
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgbbidblink:482--h0b57e2e_0
stdout: ucsc-hgbbidblink_hgBbiDbLink.out
