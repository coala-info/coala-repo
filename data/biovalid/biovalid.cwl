cwlVersion: v1.2
class: CommandLineTool
baseCommand: biovalid
label: biovalid
doc: "A tool for validating bioinformatics files.\n\nTool homepage: https://github.com/RIVM-bioinformatics/biovalid"
inputs:
  - id: file_paths
    type:
      type: array
      items: File
    doc: One or more file paths to validate. Can be compressed files. Can also 
      be a directory containing files.
    inputBinding:
      position: 1
  - id: bool_mode
    type:
      - 'null'
      - boolean
    doc: Return True if all files are valid, False if any file is invalid.
    inputBinding:
      position: 102
      prefix: --bool-mode
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Recursively validate all files in a directory.
    inputBinding:
      position: 102
      prefix: --recursive
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: log_file_path
    type: string
    doc: Output or path parameter `log_file_path`
    inputBinding:
      position: 103
      prefix: --log-file
outputs:
  - id: log_file
    type:
      - 'null'
      - File
    doc: Path to a log file.
    outputBinding:
      glob: $(inputs.log_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biovalid:0.4.0--pyhdfd78af_0
