cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgLoadBed
label: ucsc-hgloadbed
doc: "Load a generic bed file into a database. The program reads the MySQL server login from ~/.hg.conf (give it as hg_conf); with -noLoad no database is needed and the table data is left in bed.tab.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
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
    doc: "hg.conf file with db.host, db.user and db.password of a writable UCSC MySQL server (staged as ~/.hg.conf); not needed with -noLoad"
  - id: no_sort
    type: ['null', boolean]
    doc: "Do not sort (the input must already be sorted)"
    inputBinding:
      prefix: -noSort
      position: 1
  - id: no_bin
    type: ['null', boolean]
    doc: "Suppress the bin field"
    inputBinding:
      prefix: -noBin
      position: 2
  - id: old_table
    type: ['null', boolean]
    doc: "Add to an existing table"
    inputBinding:
      prefix: -oldTable
      position: 3
  - id: on_server
    type: ['null', boolean]
    doc: "Speed things up when running in a directory that the mysql server can access"
    inputBinding:
      prefix: -onServer
      position: 4
  - id: sql_table
    type: ['null', File]
    doc: "Create the table from this .sql file"
    inputBinding:
      prefix: -sqlTable=
      separate: false
      position: 5
  - id: rename_sql_table
    type: ['null', boolean]
    doc: "Rename the table created with -sqlTable to match the track"
    inputBinding:
      prefix: -renameSqlTable
      position: 6
  - id: trim_sql_table
    type: ['null', boolean]
    doc: "If sqlTable has n fields and the input has m fields, only load m fields (the last n-m fields in sqlTable are optional)"
    inputBinding:
      prefix: -trimSqlTable
      position: 7
  - id: type
    type: ['null', string]
    doc: "Bed type: bedN[+[P]], N between 3 and 15, optional + for bedPlus fields, optional P for the number of extra fields (for example bed6+3)"
    inputBinding:
      prefix: -type=
      separate: false
      position: 8
  - id: as
    type: ['null', File]
    doc: "AutoSql definition of the extra bedPlus fields"
    inputBinding:
      prefix: -as=
      separate: false
      position: 9
  - id: chrom_info
    type: ['null', File]
    doc: "chromInfo file used to validate chromosome names and sizes"
    inputBinding:
      prefix: -chromInfo=
      separate: false
      position: 10
  - id: tab
    type: ['null', boolean]
    doc: "Separate by tabs rather than space"
    inputBinding:
      prefix: -tab
      position: 11
  - id: has_bin
    type: ['null', boolean]
    doc: "Input bed file starts with a bin field"
    inputBinding:
      prefix: -hasBin
      position: 12
  - id: no_load
    type: ['null', boolean]
    doc: "Do not load the database and do not clean up the tab files"
    inputBinding:
      prefix: -noLoad
      position: 13
  - id: no_history
    type: ['null', boolean]
    doc: "Do not add history table comments (for custom tracks)"
    inputBinding:
      prefix: -noHistory
      position: 14
  - id: not_item_rgb
    type: ['null', boolean]
    doc: "Do not parse column nine as r,g,b when commas are seen (bacEnds)"
    inputBinding:
      prefix: -notItemRgb
      position: 15
  - id: bed_graph
    type: ['null', int]
    doc: "Wiggle graph column N of the input file as float dataValue (typically 4)"
    inputBinding:
      prefix: -bedGraph=
      separate: false
      position: 16
  - id: bed_detail
    type: ['null', boolean]
    doc: "bedDetail format with id and text for hgc clicks (requires -tab and -sqlTable)"
    inputBinding:
      prefix: -bedDetail
      position: 17
  - id: max_chrom_name_length
    type: ['null', int]
    doc: "Maximum chromName length, avoids the reference to the chromInfo table"
    inputBinding:
      prefix: -maxChromNameLength=
      separate: false
      position: 18
  - id: tmp_dir
    type: ['null', string]
    doc: "Path to the directory for creation of the temporary .tab file"
    inputBinding:
      prefix: -tmpDir=
      separate: false
      position: 19
  - id: no_name_ix
    type: ['null', boolean]
    doc: "No index for the name column (default creates an index)"
    inputBinding:
      prefix: -noNameIx
      position: 20
  - id: ignore_empty
    type: ['null', boolean]
    doc: "No error on an empty input file"
    inputBinding:
      prefix: -ignoreEmpty
      position: 21
  - id: no_strict
    type: ['null', boolean]
    doc: "Do not perform coordinate sanity checks (by default it aborts when chromStart >= chromEnd)"
    inputBinding:
      prefix: -noStrict
      position: 22
  - id: allow_start_equal_end
    type: ['null', boolean]
    doc: "Even when doing strict checks, allow chromStart==chromEnd (zero-length, for example insertions)"
    inputBinding:
      prefix: -allowStartEqualEnd
      position: 23
  - id: allow_negative_scores
    type: ['null', boolean]
    doc: "The sql definition of the score column is int, not unsigned"
    inputBinding:
      prefix: -allowNegativeScores
      position: 24
  - id: custom_track_loader
    type: ['null', boolean]
    doc: "Turns on -noNameIx, -noHistory, -ignoreEmpty, -allowStartEqualEnd, -allowNegativeScores, -verbose=0 and a 20 minute time-out exit"
    inputBinding:
      prefix: -customTrackLoader
      position: 25
  - id: fill_in_score
    type: ['null', string]
    doc: "If every score value is zero, use this column to fill in the score column (from minScore-1000)"
    inputBinding:
      prefix: -fillInScore=
      separate: false
      position: 26
  - id: min_score
    type: ['null', int]
    doc: "Minimum score for the -fillInScore option (default 100)"
    inputBinding:
      prefix: -minScore=
      separate: false
      position: 27
  - id: verbose
    type: ['null', int]
    doc: "Verbose level for extra information to stderr"
    inputBinding:
      prefix: -verbose=
      separate: false
      position: 28
  - id: dot_is_null
    type: ['null', int]
    doc: "If the specified field is a '.', replace it with -1"
    inputBinding:
      prefix: -dotIsNull=
      separate: false
      position: 29
  - id: line_limit
    type: ['null', int]
    doc: "Limit the input file to this number of lines"
    inputBinding:
      prefix: -lineLimit=
      separate: false
      position: 30
  - id: database
    type: string
    doc: Database name
    inputBinding:
      position: 50
  - id: track
    type: string
    doc: Track (table) name
    inputBinding:
      position: 51
  - id: bed_files
    type: File[]
    doc: Input bed file(s)
    inputBinding:
      position: 52
outputs:
  - id: bed_tab
    type: ['null', File]
    doc: Tab file left by -noLoad
    outputBinding:
      glob: bed.tab
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgloadbed:482--h0b57e2e_1
stdout: ucsc-hgloadbed.out
