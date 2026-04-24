cwlVersion: v1.2
class: CommandLineTool
baseCommand: isatab2json.py
label: isatab2json
doc: "Converts ISA-Tab files to JSON format.\n\nTool homepage: https://github.com/bio-agents/isatab2json_docker"
inputs:
  - id: isatab_dir
    type: Directory
    doc: Directory containing ISA-Tab files
    inputBinding:
      position: 1
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the logging level (e.g., DEBUG, INFO, WARNING, ERROR).
    inputBinding:
      position: 102
      prefix: --log-level
  - id: use_new_parser
    type:
      - 'null'
      - boolean
    doc: Use the new parser for ISA-Tab files.
    inputBinding:
      position: 102
      prefix: --new-parser
  - id: validate_first
    type:
      - 'null'
      - boolean
    doc: Validate ISA-Tab files before conversion.
    inputBinding:
      position: 102
      prefix: --validate
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to the output JSON file. If not specified, output will be printed 
      to stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/isatab2json:phenomenal-v0.10.0_cv0.6.1.69
