cwlVersion: v1.2
class: CommandLineTool
baseCommand: GDBshow
label: fastga_GDBshow
doc: "Shows the scaffolds and contigs of a genome database, or the sequence of a selection.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
arguments:
  - position: 100
    valueFrom: $(inputs.gdb.basename)
inputs:
  - id: gdb
    type: File
    doc: Genome database (.1gdb) made by FAtoGDB.
  - id: gdb_bps
    type: File
    doc: 'Hidden base-pair file of the database (.<name>.bps) made by FAtoGDB; it is staged next to the .1gdb.'
  - id: selection
    type:
      - 'null'
      - string
    doc: 'Selection of scaffolds, contigs or positions, for example @1 or @1:100-200 (see the tool help for the grammar).'
    inputBinding:
      position: 101
  - id: header_only
    type:
      - 'null'
      - boolean
    doc: Show only the header lines.
    inputBinding:
      position: 1
      prefix: '-h'
  - id: width
    type:
      - 'null'
      - int
    doc: 'Print -w bp per line. [default: 80]'
    inputBinding:
      position: 1
      prefix: '-w'
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.gdb)
      - entry: $(inputs.gdb_bps)
        entryname: $('.' + inputs.gdb.nameroot + '.bps')
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_GDBshow.out
