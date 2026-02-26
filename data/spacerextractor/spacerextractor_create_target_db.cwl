cwlVersion: v1.2
class: CommandLineTool
baseCommand: spacerextractor create_target_db
label: spacerextractor_create_target_db
doc: "create a database of potential targets to map spacers to from a fasta file\n\
  \nTool homepage: https://code.jgi.doe.gov/SRoux/spacerextractor"
inputs:
  - id: bbtools_memory
    type:
      - 'null'
      - string
    doc: memory allocated to bbtools
    default: 20g
    inputBinding:
      position: 101
      prefix: --bbtools_memory
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Run in a more verbose mode for debugging / troubleshooting purposes (warning:
      spacerextractor becomes quite chatty in this mode..)'
    inputBinding:
      position: 101
      prefix: --debug
  - id: force_rerun
    type:
      - 'null'
      - boolean
    doc: If you want to force SpacerExtractor to recompute all the steps
    inputBinding:
      position: 101
      prefix: --force_rerun
  - id: in_file
    type: File
    doc: A fasta file of potential targets to map spacers to.
    inputBinding:
      position: 101
      prefix: --in_file
  - id: n_threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    default: 2
    inputBinding:
      position: 101
      prefix: --n_threads
  - id: new_db_dir
    type: Directory
    doc: Path to the target database folder, will be created or overwritten 
      (with option fr)
    inputBinding:
      position: 101
      prefix: --new_db_dir
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Run in a very quiet mode, will only show error/critical messages
    inputBinding:
      position: 101
      prefix: --quiet
  - id: replace_spaces
    type:
      - 'null'
      - boolean
    doc: To replace all spaces by underscore in sequence names
    default: false
    inputBinding:
      position: 101
      prefix: --replace_spaces
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spacerextractor:0.9.8--pyhdfd78af_0
stdout: spacerextractor_create_target_db.out
