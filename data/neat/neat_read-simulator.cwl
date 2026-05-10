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
    inputBinding:
      position: 101
      prefix: --prefix
  - id: log_file_path
    type: string
    doc: Output or path parameter `log_file_path`
    inputBinding:
      position: 102
      prefix: --log-file
outputs:
  - id: log_file
    type:
      - 'null'
      - File
    doc: Path to the log file. If not specified, a log file will be created in 
      the current directory.
    outputBinding:
      glob: $(inputs.log_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neat:4.3.5--pyhdfd78af_0
