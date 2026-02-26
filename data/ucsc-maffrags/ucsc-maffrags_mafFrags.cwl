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
      prefix: -orgs
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
  - id: out_maf
    type: File
    doc: Output MAF file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maffrags:482--h0b57e2e_0
