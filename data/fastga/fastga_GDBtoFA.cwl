cwlVersion: v1.2
class: CommandLineTool
baseCommand: GDBtoFA
label: fastga_GDBtoFA
doc: "Converts a genome database back to a FASTA file (or 1seq file).\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
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
  - id: target
    type:
      - 'null'
      - string
    doc: 'Output file name with extension .fa, .fna, .fasta (optional .gz) or .1seq. Without it the sequence goes to standard output.'
    inputBinding:
      position: 101
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode.
    inputBinding:
      position: 1
      prefix: '-v'
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
  - id: sequence_file
    type:
      - 'null'
      - File
    doc: Sequence file written to target.
    outputBinding:
      glob: $(inputs.target)
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
stdout: fastga_GDBtoFA.out
