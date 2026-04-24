cwlVersion: v1.2
class: CommandLineTool
baseCommand: flumut
label: flumut
doc: "Flumut is a tool for the detection of mutations in influenza viruses.\n\nTool
  homepage: https://github.com/izsvenezie-virology/FluMut"
inputs:
  - id: fasta_file
    type: File
    doc: Input FASTA file containing viral sequences.
    inputBinding:
      position: 1
  - id: all_versions
    type:
      - 'null'
      - boolean
    doc: Prints all versions and exit.
    inputBinding:
      position: 102
      prefix: --all-versions
  - id: db_file
    type:
      - 'null'
      - string
    doc: Set source database.
    inputBinding:
      position: 102
      prefix: --db-file
  - id: name_regex
    type:
      - 'null'
      - string
    doc: Set regular expression to parse sequence name.
    inputBinding:
      position: 102
      prefix: --name-regex
  - id: relaxed
    type:
      - 'null'
      - boolean
    doc: Report markers of which at least one mutation is found.
    inputBinding:
      position: 102
      prefix: --relaxed
  - id: skip_unknown_segments
    type:
      - 'null'
      - boolean
    doc: Skip sequences with segment not present in the database.
    inputBinding:
      position: 102
      prefix: --skip-unknown-segments
  - id: skip_unmatch_names
    type:
      - 'null'
      - boolean
    doc: Skip sequences with name that does not match the regular expression 
      pattern.
    inputBinding:
      position: 102
      prefix: --skip-unmatch-names
  - id: update
    type:
      - 'null'
      - boolean
    doc: Update the database to the latest version and exit.
    inputBinding:
      position: 102
      prefix: --update
outputs:
  - id: markers_output
    type:
      - 'null'
      - File
    doc: TSV markers output file.
    outputBinding:
      glob: $(inputs.markers_output)
  - id: mutations_output
    type:
      - 'null'
      - File
    doc: TSV mutations output file.
    outputBinding:
      glob: $(inputs.mutations_output)
  - id: literature_output
    type:
      - 'null'
      - File
    doc: TSV literature output file.
    outputBinding:
      glob: $(inputs.literature_output)
  - id: excel_output
    type:
      - 'null'
      - File
    doc: Excel complete report.
    outputBinding:
      glob: $(inputs.excel_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flumut:0.6.4--pyhdfd78af_0
