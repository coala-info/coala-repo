cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyani-plus
  - anib
label: pyani-plus_anib
doc: "Execute ANIb calculations, logged to a pyANI-plus SQLite3 database.\n\nTool homepage: https://github.com/pyani-plus/pyani-plus"
inputs:
  - id: fasta
    type: Directory
    doc: "Directory of FASTA files (extensions .fa, .fas, .fasta, .fna)."
    inputBinding:
      position: 1
  - id: database
    type: string
    doc: "Path to pyANI-plus SQLite3 database (created when create_db is set, otherwise an existing copy is given in database_in)."
    inputBinding:
      position: 2
      prefix: --database
  - id: database_in
    type:
      - 'null'
      - File
    doc: Existing pyANI-plus database to extend (staged as a writable copy under the name given by database).
  - id: name
    type:
      - 'null'
      - string
    doc: "Run name. Default is 'N genomes using METHOD'."
    inputBinding:
      position: 10
      prefix: --name
  - id: create_db
    type:
      - 'null'
      - boolean
    doc: "Create database if does not exist."
    inputBinding:
      position: 10
      prefix: --create-db
  - id: executor
    type:
      - 'null'
      - type: enum
        symbols: [local, slurm]
    doc: "How should the internal tools be run?"
    inputBinding:
      position: 10
      prefix: --executor
  - id: fragsize
    type:
      - 'null'
      - int
    doc: "Comparison method fragment size. (default: 1020)"
    inputBinding:
      position: 10
      prefix: --fragsize
  - id: temp
    type:
      - 'null'
      - string
    doc: "Directory to use for intermediate files, which for debugging purposes will not be deleted. For clusters this must be on a shared drive. Default behaviour is to use a system specified temporary directory (specific to the compute-node when using a cluster) and remove this afterwards."
    inputBinding:
      position: 10
      prefix: --temp
  - id: wtemp
    type:
      - 'null'
      - string
    doc: "Directory to use for temporary workflow coordination files, which for debugging purposes will not be deleted. For clusters this must be on a shared drive. Default behaviour is to use a system specified temporary directory (for the local executor) or a temporary directory under the present direct (for clusters), and remove this afterwards."
    inputBinding:
      position: 10
      prefix: --wtemp
  - id: log
    type:
      - 'null'
      - string
    doc: "Where to record log(s). Use '-' for no logging."
    inputBinding:
      position: 10
      prefix: --log
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Show debugging level logging at the terminal (in addition to the log file)."
    inputBinding:
      position: 10
      prefix: --debug
outputs:
  - id: database_out
    type: File
    doc: pyANI-plus database with the new run
    outputBinding:
      glob: $(inputs.database)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file (written when log is set)
    outputBinding:
      glob: $(inputs.log)
  - id: stdout_text
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.database)
        entry: $(inputs.database_in)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
stdout: pyani-plus_anib.out
