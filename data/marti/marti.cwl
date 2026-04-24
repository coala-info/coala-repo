cwlVersion: v1.2
class: CommandLineTool
baseCommand: marti
label: marti
doc: "Metagenomic Analysis in Real TIme (MARTi) Engine\n\nTool homepage: https://github.com/richardmleggett/MARTi"
inputs:
  - id: config_file
    type: File
    doc: Configuration file for MARTi analysis
    inputBinding:
      position: 101
      prefix: -config
  - id: fix_random_seed
    type:
      - 'null'
      - long
    doc: Fix the random number seed used for debugging
    inputBinding:
      position: 101
      prefix: -fixrandom
  - id: init_mode
    type:
      - 'null'
      - boolean
    doc: Enter initialisation mode and output version information.
    inputBinding:
      position: 101
      prefix: -init
  - id: log_level
    type:
      - 'null'
      - int
    doc: Set the level of logging to logs/engine.txt from 0 (none) to 5 
      (maximum)
    inputBinding:
      position: 101
      prefix: -loglevel
  - id: options_file
    type:
      - 'null'
      - File
    doc: Specify the location of a marti_engine_options.txt file to use.
    inputBinding:
      position: 101
      prefix: -options
  - id: slurm_partition
    type:
      - 'null'
      - string
    doc: Set default SLURM partition
    inputBinding:
      position: 101
      prefix: -queue
  - id: write_config_file
    type:
      - 'null'
      - File
    doc: Generate a new config file
    inputBinding:
      position: 101
      prefix: -writeconfig
  - id: write_options_file
    type:
      - 'null'
      - File
    doc: Generate a new options file
    inputBinding:
      position: 101
      prefix: -writeoptions
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/marti:0.9.29--hdfd78af_0
stdout: marti.out
