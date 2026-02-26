cwlVersion: v1.2
class: CommandLineTool
baseCommand: ganon_update
label: ganon_update
doc: "Update an existing Ganon database.\n\nTool homepage: https://github.com/pirovc/ganon"
inputs:
  - id: db_prefix
    type: string
    doc: Existing database input prefix
    default: None
    inputBinding:
      position: 101
      prefix: --db-prefix
  - id: output_db_prefix
    type:
      - 'null'
      - string
    doc: Output database prefix. By default will be the same as --db-prefix and 
      overwrite files
    default: None
    inputBinding:
      position: 101
      prefix: --output-db-prefix
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet output mode
    default: false
    inputBinding:
      position: 101
      prefix: --quiet
  - id: restart
    type:
      - 'null'
      - boolean
    doc: Restart build/update from scratch, do not try to resume from the latest
      possible step. {db_prefix}_files/ will be deleted if present.
    default: false
    inputBinding:
      position: 101
      prefix: --restart
  - id: threads
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output mode
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
  - id: write_info_file
    type:
      - 'null'
      - boolean
    doc: Save copy of target info generated to {db_prefix}.info.tsv. Can be 
      re-used as --input-file for further attempts.
    default: false
    inputBinding:
      position: 101
      prefix: --write-info-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ganon:2.2.0--py312hfc6b275_0
stdout: ganon_update.out
