cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylartist
  - db-custom
label: methylartist_db-custom
doc: "Create or update a methylartist database from a custom per-read methylation
  output table.\n\nTool homepage: https://github.com/adamewing/methylartist"
inputs:
  - id: append
    type:
      - 'null'
      - boolean
    doc: append to database
    inputBinding:
      position: 101
      prefix: --append
  - id: canprob
    type:
      - 'null'
      - int
    doc: column number for probability of canonical base (if not given, assume 
      p=1-modprob)
    inputBinding:
      position: 101
      prefix: --canprob
  - id: chrom
    type: int
    doc: chromosome column number (counted from 0)
    inputBinding:
      position: 101
      prefix: --chrom
  - id: delimiter
    type:
      - 'null'
      - string
    doc: column delimimter char (default = whitespace (i.e. tab or space)
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: header
    type:
      - 'null'
      - boolean
    doc: input table has header
    inputBinding:
      position: 101
      prefix: --header
  - id: methdata
    type: File
    doc: per-read methylation output table
    inputBinding:
      position: 101
      prefix: --methdata
  - id: mincanprob
    type:
      - 'null'
      - float
    doc: probability threshold for calling canonical base (default = minmodprob)
    inputBinding:
      position: 101
      prefix: --mincanprob
  - id: minmodprob
    type:
      - 'null'
      - float
    doc: probability threshold for calling modified base
    inputBinding:
      position: 101
      prefix: --minmodprob
  - id: modbase
    type:
      - 'null'
      - string
    doc: specify modified base/motif name (overrides --modbasecol)
    inputBinding:
      position: 101
      prefix: --modbase
  - id: modbasecol
    type:
      - 'null'
      - int
    doc: column number for modified base/motif name (optional, can use --modbase
      instead)
    inputBinding:
      position: 101
      prefix: --modbasecol
  - id: modprob
    type: int
    doc: column number for probability of modified base (counted from 0)
    inputBinding:
      position: 101
      prefix: --modprob
  - id: motifsize
    type:
      - 'null'
      - int
    doc: mod motif size (default is 2 as "CG" is most common use case, e.g. set 
      to 1 for 6mA)
    inputBinding:
      position: 101
      prefix: --motifsize
  - id: pos
    type: int
    doc: genomic (i.e. on chromosome/contig) position column number (counted from 0), positions are 0-based
    inputBinding:
      position: 101
      prefix: --pos
  - id: readname
    type: int
    doc: readname column number (counted from 0)
    inputBinding:
      position: 101
      prefix: --readname
  - id: strand
    type: int
    doc: strand column number (counted from 0)
    inputBinding:
      position: 101
      prefix: --strand
  - id: db_path
    type: string
    doc: 'database name (.db is appended when missing)'
    inputBinding:
      position: 102
      prefix: --db
  - id: existing_db
    type:
      - 'null'
      - File
    doc: Existing database to extend when append is set; db_path must be its file name. Staged in the working directory.
outputs:
  - id: db
    type:
      - 'null'
      - File
    doc: 'database name (.db is appended when missing)'
    outputBinding:
      glob: "$(inputs.db_path.endsWith('.db') ? inputs.db_path : inputs.db_path + '.db')"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${ return inputs.existing_db ? [{"entry": inputs.existing_db, "writable": true}] : []; }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
