cwlVersion: v1.2
class: CommandLineTool
baseCommand: FAtoGDB
label: fastga_FAtoGDB
doc: "Converts a FASTA or 1-code sequence file to a genome database (.1gdb plus a hidden .bps file).\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
arguments:
  - position: 100
    valueFrom: $(inputs.source.basename)
  - position: 101
    valueFrom: $(inputs.target)
inputs:
  - id: source
    type: File
    doc: 'Source sequences (FASTA with .fa, .fna or .fasta and optional .gz, or a 1-code sequence file).'
  - id: target
    type:
      - 'null'
      - string
    doc: 'Name of the genome database to create (the .1gdb extension is added). Default: name of the source.'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode.
    inputBinding:
      position: 101
      prefix: '-v'
  - id: log_file
    type:
      - 'null'
      - string
    doc: Output log to specified file.
    inputBinding:
      position: 101
      prefix: '-L:'
      separate: false
  - id: n_run_length
    type:
      - 'null'
      - int
    doc: 'Turn runs of n''s of length < # into a''s.'
    inputBinding:
      position: 101
      prefix: '-n'
      separate: false
outputs:
  - id: gdb
    type: File
    doc: Genome database.
    outputBinding:
      glob: '*.1gdb'
  - id: gdb_bps
    type: File
    doc: Hidden base-pair file of the database.
    outputBinding:
      glob: '.*.bps'
  - id: log
    type:
      - 'null'
      - File
    doc: Log file written when log_file is set.
    outputBinding:
      glob: $(inputs.log_file)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.source)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_FAtoGDB.out
