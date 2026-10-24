cwlVersion: v1.2
class: CommandLineTool
baseCommand: estOrient
label: ucsc-estorient_estOrient
doc: "Convert ESTs so that orientation matches directory of transcription. Read ESTs
  from a database and determine orientation based on estOrientInfo table or direction
  in gbCdnaInfo table. Update PSLs so that the strand reflects the direction of transcription.
  By default, PSLs where the direction can't be determined are dropped.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: db
    type: string
    doc: Database to read ESTs from, or `no' when -fileInput and -estOrientInfo are
      used.
    inputBinding:
      position: 10
  - id: est_table
    type:
      - string
      - File
    doc: EST table to read ESTs from, or a PSL file when -fileInput is given.
    inputBinding:
      position: 11
  - id: out_psl
    type: string
    doc: Output PSL file name.
    inputBinding:
      position: 12
  - id: chrom
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -chrom=
          separate: false
    doc: Process this chromosome, maybe repeated.
    inputBinding:
      position: 1
  - id: keep_disoriented
    type:
      - 'null'
      - boolean
    doc: Don't drop ESTs where orientation can't be determined.
    inputBinding:
      position: 2
      prefix: -keepDisoriented
  - id: disoriented
    type:
      - 'null'
      - string
    doc: Output ESTs that where orientation can't be determined to this file.
    inputBinding:
      position: 3
      prefix: -disoriented=
      separate: false
  - id: incl_ver
    type:
      - 'null'
      - boolean
    doc: Add NCBI version number to accession if not already present.
    inputBinding:
      position: 4
      prefix: -inclVer
  - id: file_input
    type:
      - 'null'
      - boolean
    doc: estTable is a psl file.
    inputBinding:
      position: 5
      prefix: -fileInput
  - id: est_orient_info
    type:
      - 'null'
      - File
    doc: Instead of getting the orientation information from the estOrientInfo table,
      load it from this file. This data is the output of polyInfo command. If this
      option is specified, the direction will not be looked up in the gbCdnaInfo
      table and db can be `no'.
    inputBinding:
      position: 6
      prefix: -estOrientInfo=
      separate: false
  - id: info
    type:
      - 'null'
      - string
    doc: 'Write information about each EST to this tab separated file: qName tName
      tStart tEnd origStrand newStrand orient.'
    inputBinding:
      position: 7
      prefix: -info=
      separate: false
outputs:
  - id: out_psl_file
    type: File
    doc: Output PSL file with strand set to the direction of transcription.
    outputBinding:
      glob: $(inputs.out_psl)
  - id: disoriented_file
    type:
      - 'null'
      - File
    doc: PSL of ESTs where the orientation could not be determined.
    outputBinding:
      glob: $(inputs.disoriented)
  - id: info_file
    type:
      - 'null'
      - File
    doc: Tab-separated information about each EST.
    outputBinding:
      glob: $(inputs.info)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-estorient:482--h0b57e2e_0
