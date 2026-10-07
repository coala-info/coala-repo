cwlVersion: v1.2
class: CommandLineTool
baseCommand: TANmask
label: damasker_TANmask
doc: "Build a tandem repeat mask track from the datander self alignments
  (TAN.<db>.las). The track files .<db>.<track>.anno and .<db>.<track>.data are
  written beside the database, which is staged in the working directory.\n\nTool
  homepage: https://github.com/thegenemyers/DAMASKER"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.source_db)
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, output statistics as proceed.
    inputBinding:
      position: 1
      prefix: -v
  - id: shortest_tandem_interval
    type:
      - 'null'
      - int
    doc: Shortest tandem interval to report. Default 500.
    inputBinding:
      position: 1
      prefix: -l
      separate: false
  - id: tandem_mask_track_name
    type:
      - 'null'
      - string
    doc: Use this name as for the tandem mask track. Default tan.
    inputBinding:
      position: 1
      prefix: -n
      separate: false
  - id: source_db
    type: File
    doc: Source database (.db)
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
    secondaryFiles:
      - pattern: '${ return "." + self.nameroot + ".idx"; }'
      - pattern: '${ return "." + self.nameroot + ".bps"; }'
      - pattern: '${ return "." + self.nameroot + ".hdr"; }'
        required: false
  - id: overlaps_las
    type:
      type: array
      items: File
    doc: Tandem self-alignment files from datander (TAN.<db>.las)
    inputBinding:
      position: 3
outputs:
  - id: mask_track
    type:
      type: array
      items: File
    doc: Tandem mask track files (.<db>.<track>.anno and .data)
    outputBinding:
      glob: '${ var t = inputs.tandem_mask_track_name || "tan"; var r = "." + inputs.source_db.nameroot + "." + t; return [r + ".anno", r + ".data"]; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/damasker:1.0p1--h7b50bb2_8
