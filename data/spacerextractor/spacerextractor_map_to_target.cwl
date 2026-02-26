cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spacerextractor
  - map_to_target
label: spacerextractor_map_to_target
doc: "map spacers to a database of potential targets\n\nTool homepage: https://code.jgi.doe.gov/SRoux/spacerextractor"
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
  - id: db_dir
    type: Directory
    doc: Path to the target database folder that was generated with 
      create_target_db
    inputBinding:
      position: 101
      prefix: --db_dir
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
    doc: A fasta file of spacers
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
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Run in a very quiet mode, will only show error/critical messages
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: out_dir
    type: Directory
    doc: Path to the output folder where temp files and result file will be 
      written
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spacerextractor:0.9.8--pyhdfd78af_0
