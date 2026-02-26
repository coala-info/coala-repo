cwlVersion: v1.2
class: CommandLineTool
baseCommand: singlem data
label: singlem_data
doc: "Download reference metapackage data\n\nTool homepage: https://github.com/wwood/singlem"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: full_help
    type:
      - 'null'
      - boolean
    doc: print longer help message
    inputBinding:
      position: 101
      prefix: --full-help
  - id: full_help_roff
    type:
      - 'null'
      - boolean
    doc: print longer help message in ROFF (manpage) format
    inputBinding:
      position: 101
      prefix: --full-help-roff
  - id: output_directory
    type: Directory
    doc: Output directory [required unless SINGLEM_METAPACKAGE_PATH is 
      specified]
    inputBinding:
      position: 101
      prefix: --output-directory
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verify_only
    type:
      - 'null'
      - boolean
    doc: Check that the data is up to date and each file has the correct 
      checksum
    inputBinding:
      position: 101
      prefix: --verify-only
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlem:0.20.3--pyhdfd78af_2
stdout: singlem_data.out
