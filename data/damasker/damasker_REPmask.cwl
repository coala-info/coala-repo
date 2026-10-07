cwlVersion: v1.2
class: CommandLineTool
baseCommand: REPmask
label: damasker_REPmask
doc: "Build a repeat mask track from read overlaps: intervals covered by more
  than -c alignments are declared repetitive. The track files
  .<db>.<track>.anno and .<db>.<track>.data are written beside the database,
  which is staged in the working directory.\n\nTool homepage:
  https://github.com/thegenemyers/DAMASKER"
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
  - id: cutoff_depth
    type: int
    doc: Cutoff depth for declaring an interval repetitive.
    inputBinding:
      position: 1
      prefix: -c
      separate: false
  - id: repeat_track_name
    type:
      - 'null'
      - string
    doc: Use this name as for the repeat mask track. Default rep.
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
    doc: Overlap .las files of the reads (from daligner)
    inputBinding:
      position: 3
outputs:
  - id: mask_track
    type:
      type: array
      items: File
    doc: Repeat mask track files (.<db>.<track>.anno and .data)
    outputBinding:
      glob: '${ var t = inputs.repeat_track_name || "rep"; var r = "." + inputs.source_db.nameroot + "." + t; return [r + ".anno", r + ".data"]; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/damasker:1.0p1--h7b50bb2_8
