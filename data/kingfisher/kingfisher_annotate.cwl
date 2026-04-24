cwlVersion: v1.2
class: CommandLineTool
baseCommand: kingfisher_annotate
label: kingfisher_annotate
doc: "Annotate runs by their metadata e.g. number of sequenced bases, BioSample attributes,
  etc.\n\nTool homepage: https://github.com/wwood/kingfisher-download"
inputs:
  - id: all_columns
    type:
      - 'null'
      - boolean
    doc: Print all metadata columns
    inputBinding:
      position: 101
      prefix: --all-columns
  - id: bioprojects
    type:
      - 'null'
      - type: array
        items: string
    doc: BioProject IDs number(s) to download/extract from e.g. PRJNA621514 or 
      SRP260223
    inputBinding:
      position: 101
      prefix: --bioprojects
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
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format
    inputBinding:
      position: 101
      prefix: --output-format
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: only output errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: run_identifiers
    type:
      - 'null'
      - type: array
        items: string
    doc: Run number to download/extract e.g. ERR1739691
    inputBinding:
      position: 101
      prefix: --run-identifiers
  - id: run_identifiers_list
    type:
      - 'null'
      - File
    doc: Text file containing a newline-separated list of run identifiers i.e. a
      1 column CSV file.
    inputBinding:
      position: 101
      prefix: --run-identifiers-list
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to write to
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kingfisher:0.4.1--pyh7cba7a3_0
