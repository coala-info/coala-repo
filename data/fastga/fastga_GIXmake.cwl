cwlVersion: v1.2
class: CommandLineTool
baseCommand: GIXmake
label: fastga_GIXmake
doc: "Builds a genome index (.gix) from a genome database (.1gdb) or a FASTA/1-code file.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
arguments:
  - position: 100
    valueFrom: $(inputs.source.basename)
  - position: 101
    valueFrom: $(inputs.target)
inputs:
  - id: source
    type: File
    doc: 'Genome database (.1gdb, together with gdb_bps) or sequence file (FASTA or 1-code).'
  - id: gdb_bps
    type:
      - 'null'
      - File
    doc: 'Hidden base-pair file (.<name>.bps) of the .1gdb source. Needed when source is a .1gdb.'
  - id: target
    type:
      - 'null'
      - string
    doc: Name of the index to create (the .gix extension is added). Only for sequence file sources.
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Verbose mode, output statistics as proceed.'
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
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use. [default: 8]'
    inputBinding:
      position: 101
      prefix: '-T'
      separate: false
  - id: temp_dir
    type:
      - 'null'
      - string
    doc: 'Directory to use for temporary files. [default: $TMPDIR]'
    inputBinding:
      position: 101
      prefix: '-P'
      separate: false
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'Index k-mer size. [default: 40]'
    inputBinding:
      position: 101
      prefix: '-k'
      separate: false
  - id: seed_cutoff
    type:
      - 'null'
      - int
    doc: 'Adaptive seed count cutoff. [default: 10]'
    inputBinding:
      position: 101
      prefix: '-f'
      separate: false
outputs:
  - id: gix
    type: File
    doc: Genome index.
    outputBinding:
      glob: '*.gix'
  - id: index_files
    type:
      type: array
      items: File
    doc: Hidden k-mer table files of the index.
    outputBinding:
      glob:
        - '.*.ktab.*'
  - id: generated_gdb
    type:
      type: array
      items: File
    doc: Genome database and base-pair file, when built from a sequence file.
    outputBinding:
      glob:
        - '*.1gdb'
        - '.*.bps'
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
      - entry: $(inputs.gdb_bps)
        entryname: $('.' + inputs.source.nameroot + '.bps')
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_GIXmake.out
