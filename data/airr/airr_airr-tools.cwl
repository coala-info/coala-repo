cwlVersion: v1.2
class: CommandLineTool
baseCommand: airr-tools
label: airr_airr-tools
doc: "AIRR Community Standards utility commands.\n\nTool homepage: http://docs.airr-community.org"
inputs:
  - id: subcommand
    type:
      type: enum
      symbols:
        - merge
        - validate
    doc: The subcommand to execute (merge or validate)
    inputBinding:
      position: 1
  - id: validate_type
    type:
      - 'null'
      - type: enum
        symbols:
          - rearrangement
          - airr
          - repertoire
    doc: 'File type to validate; required with the validate subcommand (rearrangement:
      AIRR rearrangement files, airr: AIRR Data Model files, repertoire: AIRR repertoire
      metadata files)'
    inputBinding:
      position: 2
  - id: out_file
    type:
      - 'null'
      - string
    doc: Output file name; required with the merge subcommand
    inputBinding:
      position: 101
      prefix: -o
  - id: drop
    type:
      - 'null'
      - boolean
    doc: If specified, drop fields that do not exist in all input files 
      (merge only). Otherwise, include all columns in all files and fill 
      missing data with empty strings.
    inputBinding:
      position: 101
      prefix: --drop
  - id: airr_files
    type:
      type: array
      items: File
    doc: A list of AIRR rearrangement (or repertoire / Data Model) files.
    inputBinding:
      position: 102
      prefix: -a
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (validate reports its results here)
  - id: merged
    type:
      - 'null'
      - File
    doc: Merged AIRR rearrangement file (merge subcommand)
    outputBinding:
      glob: $(inputs.out_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/airr:1.6.1--pyh106432d_0
stdout: airr_airr-tools.out
stderr: airr_airr-tools.err
