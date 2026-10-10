cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mrs
  - blast
label: mrs_blast
doc: "Perform BLAST search\n\nTool homepage: https://mrs.cmbi.ru.nl/"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: ^.dtd
        required: true
    doc: 'MRS configuration file. It must be named mrs-config.xml and have its DTD
      mrs-config.dtd beside it; directories in it should be relative paths such as
      mrs.'
    inputBinding:
      position: 101
      prefix: --config
  - id: databanks
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --databank
          separate: true
    doc: Databank(s) to search, given as databank ids from the configuration
      file (built with mrs build); can be specified multiple times
    inputBinding:
      position: 101
  - id: expect
    type:
      - 'null'
      - float
    doc: Expectation value, default is 10.0
    inputBinding:
      position: 101
      prefix: --expect
  - id: gap_extend
    type:
      - 'null'
      - int
    doc: Cost to extend a gap (-1 invokes default)
    inputBinding:
      position: 101
      prefix: --gap-extend
  - id: gap_open
    type:
      - 'null'
      - int
    doc: Cost to open a gap (-1 invokes default)
    inputBinding:
      position: 101
      prefix: --gap-open
  - id: matrix
    type:
      - 'null'
      - string
    doc: Matrix (default is BLOSUM62)
    inputBinding:
      position: 101
      prefix: --matrix
  - id: no_filter
    type:
      - 'null'
      - boolean
    doc: Do not mask low complexity regions in the query sequence
    inputBinding:
      position: 101
      prefix: --no-filter
  - id: program
    type:
      - 'null'
      - string
    doc: Blast program (only supported program is blastp for now...)
    inputBinding:
      position: 101
      prefix: --program
  - id: query_file
    type: File
    doc: File containing query in FastA format
    inputBinding:
      position: 101
      prefix: --query
  - id: report_limit
    type:
      - 'null'
      - int
    doc: Number of results to report
    inputBinding:
      position: 101
      prefix: --report-limit
  - id: threads
    type:
      - 'null'
      - int
    doc: Nr of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: ungapped
    type:
      - 'null'
      - boolean
    doc: Do not search for gapped alignments, only ungapped
    inputBinding:
      position: 101
      prefix: --ungapped
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose
    inputBinding:
      position: 101
      prefix: --verbose
  - id: word_size
    type:
      - 'null'
      - int
    doc: Word size (0 invokes default)
    inputBinding:
      position: 101
      prefix: --word-size
  - id: mrs_dir
    type:
      - 'null'
      - Directory
    doc: Directory with the built databanks (the "mrs" directory named in the
      configuration file)
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Output file, default is stdout
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: BLAST report printed to standard output when no output file is given
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file, default is stdout
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: mrs
        entry: $(inputs.mrs_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
stdout: mrs_blast.out
