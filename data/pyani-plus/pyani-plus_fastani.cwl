cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyani-plus
  - fastani
label: pyani-plus_fastani
doc: "Execute fastANI calculations, logged to a pyANI-plus SQLite3 database.\n\nTool
  homepage: https://github.com/pyani-plus/pyani-plus"
inputs:
  - id: fasta
    type: Directory
    doc: Directory of FASTA files (extensions .fa, .fas, .fasta, .fna).
    inputBinding:
      position: 1
  - id: create_db
    type:
      - 'null'
      - boolean
    doc: Create database if does not exist.
    inputBinding:
      position: 102
      prefix: --create-db
  - id: database
    type: File
    doc: Path to pyANI-plus SQLite3 database.
    inputBinding:
      position: 102
      prefix: --database
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Show debugging level logging at the terminal (in addition to the log 
      file).
    inputBinding:
      position: 102
      prefix: --debug
  - id: executor
    type:
      - 'null'
      - string
    doc: 'How should the internal tools be run? [default: local]'
    inputBinding:
      position: 102
      prefix: --executor
  - id: fragsize
    type:
      - 'null'
      - int
    doc: Comparison method fragment size.
    inputBinding:
      position: 102
      prefix: --fragsize
  - id: kmersize
    type:
      - 'null'
      - int
    doc: Comparison method k-mer size
    inputBinding:
      position: 102
      prefix: --kmersize
  - id: log
    type:
      - 'null'
      - File
    doc: Where to record log(s). Use '-' for no logging. Default is no logging 
      for the local executor, but otherwise "pyani-plus.log".
    inputBinding:
      position: 102
      prefix: --log
  - id: minmatch
    type:
      - 'null'
      - float
    doc: Comparison method min-match.
    inputBinding:
      position: 102
      prefix: --minmatch
  - id: name
    type:
      - 'null'
      - string
    doc: Run name. Default is 'N genomes using METHOD'.
    inputBinding:
      position: 102
      prefix: --name
  - id: temp
    type:
      - 'null'
      - Directory
    doc: Directory to use for intermediate files, which for debugging purposes 
      will not be deleted. For clusters this must be on a shared drive. Default 
      behaviour is to use a system specified temporary directory (specific to 
      the compute-node when using a cluster) and remove this afterwards.
    inputBinding:
      position: 102
      prefix: --temp
  - id: wtemp
    type:
      - 'null'
      - Directory
    doc: Directory to use for temporary workflow coordination files, which for 
      debugging purposes will not be deleted. For clusters this must be on a 
      shared drive. Default behaviour is to use a system specified temporary 
      directory (for the local executor) or a temporary directory under the 
      present direct (for clusters), and remove this afterwards.
    inputBinding:
      position: 102
      prefix: --wtemp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
stdout: pyani-plus_fastani.out
