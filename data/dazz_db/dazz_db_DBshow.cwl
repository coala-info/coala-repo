cwlVersion: v1.2
class: CommandLineTool
baseCommand: DBshow
label: dazz_db_DBshow
doc: "Show the reads of a Dazzler database (.db) or DAM (.dam) as FASTA, optionally
  restricted to read ranges and with track masks.\n\nTool homepage: https://github.com/thegenemyers/DAZZ_DB"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: db_or_dam_path
    type: File
    doc: The Dazzler database (.db) or DAM (.dam) file; its hidden .<name>.idx 
      and .<name>.bps files must sit beside it
    secondaryFiles:
      - pattern: "${ return '.' + self.nameroot + '.idx'; }"
        required: true
      - pattern: "${ return '.' + self.nameroot + '.bps'; }"
        required: true
      - pattern: "${ return '.' + self.nameroot + '.hdr'; }"
        required: false
      - pattern: "${ return '.' + self.nameroot + '.qvs'; }"
        required: false
    inputBinding:
      position: 1
  - id: reads
    type:
      - 'null'
      - type: array
        items: string
    doc: Read ranges to show (e.g. 1-10 or 5), or the name of a file of ranges
    inputBinding:
      position: 2
  - id: untrimmed
    type:
      - 'null'
      - boolean
    doc: Show the untrimmed database
    inputBinding:
      position: 103
      prefix: -u
  - id: no_sequence
    type:
      - 'null'
      - boolean
    doc: Do not show the sequence, only the header lines
    inputBinding:
      position: 103
      prefix: -n
  - id: quality_streams
    type:
      - 'null'
      - boolean
    doc: Also show the QV streams (.db with quiva data only)
    inputBinding:
      position: 103
      prefix: -q
  - id: upper_case
    type:
      - 'null'
      - boolean
    doc: Show the sequence in upper case
    inputBinding:
      position: 103
      prefix: -U
  - id: quiva_format
    type:
      - 'null'
      - boolean
    doc: Produce a .quiva file instead of FASTA
    inputBinding:
      position: 103
      prefix: -Q
  - id: tracks
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -m
          separate: false
    doc: Show the intervals of these mask tracks in the header lines
    inputBinding:
      position: 103
  - id: width
    type:
      - 'null'
      - int
    doc: Line width of the sequence output (default 80)
    inputBinding:
      position: 103
      prefix: -w
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Reads in FASTA (or quiva) format
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dazz_db:1.0--0
stdout: dazz_db_DBshow.out
