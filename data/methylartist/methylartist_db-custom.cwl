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
    doc: chromosome column number
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
    default: 0.8
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
    doc: column number for probability of modified base
    inputBinding:
      position: 101
      prefix: --modprob
  - id: motifsize
    type:
      - 'null'
      - int
    doc: mod motif size (default is 2 as "CG" is most common use case, e.g. set 
      to 1 for 6mA)
    default: 2
    inputBinding:
      position: 101
      prefix: --motifsize
  - id: pos
    type: int
    doc: genomic (i.e. on chromosome/contig) position column number, 0-based
    inputBinding:
      position: 101
      prefix: --pos
  - id: readname
    type: int
    doc: readname column number
    inputBinding:
      position: 101
      prefix: --readname
  - id: strand
    type: int
    doc: strand column number
    inputBinding:
      position: 101
      prefix: --strand
outputs:
  - id: db
    type:
      - 'null'
      - File
    doc: 'database name (default: auto-infer)'
    outputBinding:
      glob: $(inputs.db)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
