cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyani-plus resume
label: pyani-plus_resume
doc: "Resume any (partial) run already logged in the database.\n\nIf the run was already
  complete, this should have no effect.\nAny missing pairwise comparisons will be
  computed, and the the old run will be\nmarked as complete.\nIf the version of the
  underlying tool has changed, this will abort as the\noriginal run cannot be completed.\n\
  \nTool homepage: https://github.com/pyani-plus/pyani-plus"
inputs:
  - id: cache
    type:
      - 'null'
      - Directory
    doc: Cache location if required for a method (must be visible to cluster 
      workers).
    inputBinding:
      position: 101
      prefix: --cache
  - id: database
    type: File
    doc: Path to pyANI-plus SQLite3 database.
    inputBinding:
      position: 101
      prefix: --database
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Show debugging level logging at the terminal (in addition to the log 
      file).
    inputBinding:
      position: 101
      prefix: --debug
  - id: executor
    type:
      - 'null'
      - string
    doc: How should the internal tools be run?
    inputBinding:
      position: 101
      prefix: --executor
  - id: log
    type:
      - 'null'
      - File
    doc: Where to record log(s). Use '-' for no logging. Default is no logging 
      for the local executor, but otherwise "pyani-plus.log".
    inputBinding:
      position: 101
      prefix: --log
  - id: run_id
    type:
      - 'null'
      - int
    doc: Which run from the database (defaults to latest).
    inputBinding:
      position: 101
      prefix: --run-id
  - id: temp
    type:
      - 'null'
      - Directory
    doc: Directory to use for intermediate files, which for debugging purposes 
      will not be deleted. For clusters this must be on a shared drive. Default 
      behaviour is to use a system specified temporary directory (specific to 
      the compute-node when using a cluster) and remove this afterwards.
    inputBinding:
      position: 101
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
      position: 101
      prefix: --wtemp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
stdout: pyani-plus_resume.out
