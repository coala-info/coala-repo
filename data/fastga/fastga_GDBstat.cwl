cwlVersion: v1.2
class: CommandLineTool
baseCommand: GDBstat
label: fastga_GDBstat
doc: "Shows statistics (scaffold, contig and gap counts and lengths) of a genome database.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
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
  - id: histogram
    type:
      - 'null'
      - boolean
    doc: Display histograms of scaffold and contig lengths.
    inputBinding:
      position: 101
      prefix: '-h'
  - id: histogram_buckets
    type:
      - 'null'
      - string
    doc: 'Bucket sizes for the scaffold and contig histograms, as <int>,<int>.'
    inputBinding:
      position: 101
      prefix: '-h'
      separate: false
  - id: histogram_log
    type:
      - 'null'
      - boolean
    doc: Display logarithmic histograms.
    inputBinding:
      position: 101
      prefix: '-hlog'
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
stdout: fastga_GDBstat.out
