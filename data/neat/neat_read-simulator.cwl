cwlVersion: v1.2
class: CommandLineTool
baseCommand: neat_read-simulator
label: neat_read-simulator
doc: "NEAT read simulator\n\nTool homepage: https://github.com/ncsa/NEAT/"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Configuration file for the read simulator. If not provided, NEAT will 
      use default settings.
    inputBinding:
      position: 101
      prefix: --config
  - id: output_dir
    type: Directory
    doc: Directory where the simulated reads will be saved.
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for the output read files.
    default: simulated_reads
    inputBinding:
      position: 101
      prefix: --prefix
outputs:
  - id: log_file
    type:
      - 'null'
      - File
    doc: Path to the log file. If not specified, a log file will be created in 
      the current directory.
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neat:4.3.5--pyhdfd78af_0
