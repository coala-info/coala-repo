cwlVersion: v1.2
class: CommandLineTool
baseCommand: metamlst-index.py
label: metamlst_metamlst-index.py
doc: "Builds and manages the MetaMLST SQLite Databases\n\nTool homepage: https://github.com/SegataLab/metamlst"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database)
        writable: true
inputs:
  - id: bowtie2_build
    type:
      - 'null'
      - string
    doc: Full path to the bowtie2-build command to use, deafult assumes that 
      'bowtie2-build is present in the system path
    inputBinding:
      position: 101
      prefix: --bowtie2_build
  - id: bowtie2_threads
    type:
      - 'null'
      - int
    doc: Number of Threads to use with bowtie2-build
    inputBinding:
      position: 101
      prefix: --bowtie2_threads
  - id: buildblast
    type:
      - 'null'
      - string
    doc: Build a BLAST Index from the DB (name prefix of the index files)
    inputBinding:
      position: 101
      prefix: --buildblast
  - id: buildindex
    type:
      - 'null'
      - string
    doc: Build a Bowtie2 Index from the DB (name prefix of the index files)
    inputBinding:
      position: 101
      prefix: --buildindex
  - id: database
    type:
      - 'null'
      - File
    doc: MetaMLST Database File. It is updated in place, so it is staged as a 
      writable copy. To create a new database, pass an empty file.
    inputBinding:
      position: 101
      prefix: --database
      valueFrom: $(self.basename)
  - id: dump_db
    type:
      - 'null'
      - string
    doc: Dump the entire database to file in fasta format (output file name)
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
      itemSeparator: ','
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
  - id: database_out
    type:
      - 'null'
      - File
    doc: The created or updated database
    outputBinding:
      glob: '$(inputs.database ? inputs.database.basename : [])'
  - id: bowtie2_index
    type:
      - 'null'
      - type: array
        items: File
    doc: Bowtie2 index files
    outputBinding:
      glob: "$(inputs.buildindex ? inputs.buildindex + '*.bt2' : [])"
  - id: blast_index
    type:
      - 'null'
      - type: array
        items: File
    doc: BLAST index files
    outputBinding:
      glob: "$(inputs.buildblast ? inputs.buildblast + '*' : [])"
  - id: dumped_fasta
    type:
      - 'null'
      - File
    doc: FASTA dump of the database
    outputBinding:
      glob: '$(inputs.dump_db ? inputs.dump_db : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamlst:1.2.3--hdfd78af_0
stdout: metamlst_metamlst-index.py.out
