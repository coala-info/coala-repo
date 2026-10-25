cwlVersion: v1.2
class: CommandLineTool
label: ucsc-netclass
doc: "Add classification info to net\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
arguments:
  - position: -1
    shellQuote: false
    valueFrom: chmod 600 .hg.conf && netClass
requirements:
  - class: ShellCommandRequirement
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .hg.conf
        entry: |
          db.host=genome-mysql.soe.ucsc.edu
          db.user=genome
          db.password=
          db.port=3306
inputs:
  - id: in_net
    type: File
    doc: Input net file
    inputBinding:
      position: 1
  - id: target_db
    type: string
    doc: Database to fetch target repeat masker table information
    inputBinding:
      position: 2
  - id: query_db
    type: string
    doc: Database to fetch query repeat masker table information
    inputBinding:
      position: 3
  - id: out_net
    type: string
    doc: Output net file
    inputBinding:
      position: 4
  - id: t_new_r
    type:
      - 'null'
      - Directory
    doc: Dir of chrN.out.spec files, with RepeatMasker .out format lines 
      describing lineage specific repeats in target
    inputBinding:
      position: 0
      prefix: -tNewR=
      separate: false
  - id: q_new_r
    type:
      - 'null'
      - Directory
    doc: Dir of chrN.out.spec files for query
    inputBinding:
      position: 0
      prefix: -qNewR=
      separate: false
  - id: no_ar
    type:
      - 'null'
      - boolean
    doc: Don't look for ancient repeats
    inputBinding:
      position: 0
      prefix: -noAr
  - id: q_repeats
    type:
      - 'null'
      - string
    doc: table name for query repeats in place of rmsk
    inputBinding:
      position: 0
      prefix: -qRepeats=
      separate: false
  - id: t_repeats
    type:
      - 'null'
      - string
    doc: table name for target repeats in place of rmsk (for example 
      windowmaskerSdust)
    inputBinding:
      position: 0
      prefix: -tRepeats=
      separate: false
  - id: lift_q
    type:
      - 'null'
      - File
    doc: Lift in.net's query coords to chrom-level using file.lft (for 
      accessing chrom-level coords in qDb)
    inputBinding:
      position: 0
      prefix: -liftQ=
      separate: false
  - id: lift_t
    type:
      - 'null'
      - File
    doc: Lift in.net's target coords to chrom-level using file.lft (for 
      accessing chrom-level coords in tDb)
    inputBinding:
      position: 0
      prefix: -liftT=
      separate: false
  - id: q_sizes
    type:
      - 'null'
      - File
    doc: file with query chrom.sizes instead of reading the chromInfo table from
      the database
    inputBinding:
      position: 0
      prefix: -qSizes=
      separate: false
outputs:
  - id: out_class
    type: File
    doc: Output classified net file
    outputBinding:
      glob: $(inputs.out_net)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-netclass:482--h0b57e2e_0
