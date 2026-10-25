cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafFrags
label: ucsc-maffrags_mafFrags
doc: "Collect MAFs from regions specified in a 6 column bed file\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: database
    type: string
    doc: Database to query
    inputBinding:
      position: 1
  - id: track
    type: string
    doc: Track to query
    inputBinding:
      position: 2
  - id: in_bed
    type: File
    doc: Input BED file
    inputBinding:
      position: 3
  - id: out_maf
    type: string
    doc: Output MAF file
    inputBinding:
      position: 4
  - id: hg_conf
    type: File
    doc: hg.conf file (mode 600) with the db.host, db.user and db.password of the
      UCSC MySQL server that holds the database and the track table. It is staged
      as .hg.conf in the working directory. Add gbdbLoc1=gbdb/ to it when the
      gbdb input is used.
  - id: gbdb
    type:
      - 'null'
      - Directory
    doc: Local copy of the /gbdb tree (for example gbdb/hg38/hg38.2bit and the MAF
      files of the track). It is staged as gbdb in the working directory, so
      gbdbLoc1=gbdb/ in hg.conf points to it.
  - id: bed12
    type:
      - 'null'
      - boolean
    doc: If set, in.bed is a bed 12 file, including exons
    inputBinding:
      position: 104
      prefix: -bed12
  - id: me_first
    type:
      - 'null'
      - boolean
    doc: Put native sequence first in maf
    inputBinding:
      position: 104
      prefix: -meFirst
  - id: orgs
    type:
      - 'null'
      - File
    doc: File with list of databases/organisms in order
    inputBinding:
      position: 104
      prefix: -orgs=
      separate: false
  - id: ref_coords
    type:
      - 'null'
      - boolean
    doc: output actual reference genome coordinates in MAF.
    inputBinding:
      position: 104
      prefix: -refCoords
  - id: thick_only
    type:
      - 'null'
      - boolean
    doc: Only extract subset between thickStart/thickEnd
    inputBinding:
      position: 104
      prefix: -thickOnly
  - id: tx_starts
    type:
      - 'null'
      - boolean
    doc: Add MAF txstart region definitions ('r' lines) using BED name and 
      output actual reference genome coordinates in MAF.
    inputBinding:
      position: 104
      prefix: -txStarts
outputs:
  - id: out_out_maf
    type: File
    doc: Output MAF file
    outputBinding:
      glob: '$(inputs.out_maf)'
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .hg.conf
        entry: $(inputs.hg_conf)
      - entryname: gbdb
        entry: $(inputs.gbdb)
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maffrags:482--h0b57e2e_0
