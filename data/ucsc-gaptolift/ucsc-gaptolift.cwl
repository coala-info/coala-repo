cwlVersion: v1.2
class: CommandLineTool
label: ucsc-gaptolift
doc: "Create lift file from gap table(s) of a UCSC database. Generates lift file segments separated by non-bridged gaps.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: database
    type: string
    doc: Name of the UCSC database whose gap table(s) are used (e.g. hg19)
    inputBinding:
      position: 1
  - id: lift_name
    type: string
    doc: Name of the output lift file
    inputBinding:
      position: 2
  - id: chr
    type:
      - 'null'
      - string
    doc: Work only on given chrom
    inputBinding:
      position: 101
      prefix: -chr=
      separate: false
  - id: min_gap
    type:
      - 'null'
      - int
    doc: Examine gaps only >= than M
    inputBinding:
      position: 101
      prefix: -minGap=
      separate: false
  - id: insane
    type:
      - 'null'
      - boolean
    doc: Do not perform coordinate sanity checks on gaps
    inputBinding:
      position: 101
      prefix: -insane
  - id: bed_file
    type:
      - 'null'
      - string
    doc: Output segments to this bed file
    inputBinding:
      position: 101
      prefix: -bedFile=
      separate: false
  - id: allow_bridged
    type:
      - 'null'
      - boolean
    doc: Consider any type of gap not just the non-bridged gaps
    inputBinding:
      position: 101
      prefix: -allowBridged
  - id: verbose
    type:
      - 'null'
      - int
    doc: N > 1 see more information about procedure
    inputBinding:
      position: 101
      prefix: -verbose=
      separate: false
arguments:
  - position: -1
    shellQuote: false
    valueFrom: chmod 600 .hg.conf && gapToLift
outputs:
  - id: lift_file
    type: File
    doc: The output lift file
    outputBinding:
      glob: $(inputs.lift_name)
  - id: segments_bed
    type:
      - 'null'
      - File
    doc: Segments in bed format
    outputBinding:
      glob: $(inputs.bed_file)
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .hg.conf
        entry: |
          db.host=genome-mysql.soe.ucsc.edu
          db.user=genome
          db.password=
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-gaptolift:482--h0b57e2e_0
