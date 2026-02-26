cwlVersion: v1.2
class: CommandLineTool
baseCommand: estOrient
label: ucsc-estorient_estOrient
doc: "convert ESTs so that orientation matches directory of transcription\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: db
    type: string
    doc: Database to read ESTs from
    inputBinding:
      position: 1
  - id: est_table
    type: string
    doc: EST table to read ESTs from
    inputBinding:
      position: 2
  - id: out_psl
    type: File
    doc: Output PSL file
    inputBinding:
      position: 3
  - id: chrom
    type:
      - 'null'
      - type: array
        items: string
    doc: Process this chromosome, maybe repeated
    inputBinding:
      position: 104
      prefix: -chrom
  - id: disoriented_psl
    type:
      - 'null'
      - File
    doc: Output ESTs that where orientation can't be determined to this file.
    inputBinding:
      position: 104
      prefix: -disoriented
  - id: est_orient_info_file
    type:
      - 'null'
      - File
    doc: Instead of getting the orientation information from the estOrientInfo 
      table, load it from this file. This data is the output of polyInfo 
      command. If this option is specified, the direction will not be looked up 
      in the gbCdnaInfo table and db can be `no'.
    inputBinding:
      position: 104
      prefix: -estOrientInfo
  - id: file_input
    type:
      - 'null'
      - boolean
    doc: estTable is a psl file
    inputBinding:
      position: 104
      prefix: -fileInput
  - id: incl_ver
    type:
      - 'null'
      - boolean
    doc: Add NCBI version number to accession if not already present.
    inputBinding:
      position: 104
      prefix: -inclVer
  - id: keep_disoriented
    type:
      - 'null'
      - boolean
    doc: Don't drop ESTs where orientation can't be determined.
    inputBinding:
      position: 104
      prefix: -keepDisoriented
outputs:
  - id: info_file
    type:
      - 'null'
      - File
    doc: Write information about each EST to this tab separated file
    outputBinding:
      glob: $(inputs.info_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-estorient:482--h0b57e2e_0
