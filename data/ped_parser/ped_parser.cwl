cwlVersion: v1.2
class: CommandLineTool
baseCommand: ped_parser
label: ped_parser
doc: "Tool for parsing ped files. Default is to prints the family file to in ped format
  to output.\n\nTool homepage: https://github.com/moonso/ped_parser"
inputs:
  - id: family_file
    type: File
    doc: The family file to be parsed (use '-' for stdin)
    inputBinding:
      position: 1
  - id: cmms_check
    type:
      - 'null'
      - boolean
    doc: If the id is in cmms format.
    inputBinding:
      position: 102
      prefix: --cmms_check
  - id: family_type
    type:
      - 'null'
      - string
    doc: If the analysis use one of the known setups, please specify which one (ped|alt|cmms|mip).
    inputBinding:
      position: 102
      prefix: --family_type
  - id: logfile
    type:
      - 'null'
      - File
    doc: Path to log file. If none logging is printed to stderr.
    inputBinding:
      position: 102
      prefix: --logfile
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set the level of log output (DEBUG|INFO|WARNING|ERROR|CRITICAL).
    inputBinding:
      position: 102
      prefix: --loglevel
  - id: to_dict
    type:
      - 'null'
      - boolean
    doc: Print the ped file in ped format with headers.
    inputBinding:
      position: 102
      prefix: --to_dict
  - id: to_json
    type:
      - 'null'
      - boolean
    doc: Print the ped file in json format.
    inputBinding:
      position: 102
      prefix: --to_json
  - id: to_madeline
    type:
      - 'null'
      - boolean
    doc: Print the ped file in madeline format.
    inputBinding:
      position: 102
      prefix: --to_madeline
  - id: to_ped
    type:
      - 'null'
      - boolean
    doc: Print the ped file in ped format with headers.
    inputBinding:
      position: 102
      prefix: --to_ped
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase output verbosity.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Specify the path to a file where results should be stored.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ped_parser:1.6.6--py27_1
