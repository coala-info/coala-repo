cwlVersion: v1.2
class: CommandLineTool
baseCommand: metamlst_metamlst-index.py
label: metamlst_metamlst-index.py
doc: "Builds and manages the MetaMLST SQLite Databases\n\nTool homepage: https://github.com/SegataLab/metamlst"
inputs:
  - id: bowtie2_build
    type:
      - 'null'
      - string
    doc: Full path to the bowtie2-build command to use, deafult assumes that 
      'bowtie2-build is present in the system path
    default: bowtie2-build
    inputBinding:
      position: 101
      prefix: --bowtie2_build
  - id: bowtie2_threads
    type:
      - 'null'
      - int
    doc: Number of Threads to use with bowtie2-build
    default: 4
    inputBinding:
      position: 101
      prefix: --bowtie2_threads
  - id: buildblast
    type:
      - 'null'
      - Directory
    doc: Build a BLAST Index from the DB
    inputBinding:
      position: 101
      prefix: --buildblast
  - id: buildindex
    type:
      - 'null'
      - Directory
    doc: Build a Bowtie2 Index from the DB
    inputBinding:
      position: 101
      prefix: --buildindex
  - id: database
    type:
      - 'null'
      - File
    doc: MetaMLST Database File (if unset, use the default database. If a file 
      name is given, MetaMLST will create a new DB or update an existing one)
    inputBinding:
      position: 101
      prefix: --database
  - id: dump_db
    type:
      - 'null'
      - File
    doc: Dump the entire database to file in fasta format)
    inputBinding:
      position: 101
      prefix: --dump_db
  - id: filter
    type:
      - 'null'
      - string
    doc: filters the db for a specific bacterium
    inputBinding:
      position: 101
      prefix: --filter
  - id: list
    type:
      - 'null'
      - boolean
    doc: Lists all the MLST keys present in the database and exit
    inputBinding:
      position: 101
      prefix: --list
  - id: sequences
    type:
      - 'null'
      - type: array
        items: File
    doc: Sequences in FASTA format (comma separated list of files)
    inputBinding:
      position: 101
      prefix: --sequences
  - id: typings
    type:
      - 'null'
      - File
    doc: Typings in TAB separated file (Build New Database)
    inputBinding:
      position: 101
      prefix: --typings
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamlst:1.2.3--hdfd78af_0
stdout: metamlst_metamlst-index.py.out
