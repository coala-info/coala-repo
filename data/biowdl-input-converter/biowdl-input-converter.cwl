cwlVersion: v1.2
class: CommandLineTool
baseCommand: biowdl-input-converter
label: biowdl-input-converter
doc: "Parse samplesheets for BioWDL pipelines.\n\nTool homepage: https://github.com/biowdl/biowdl-input-converter"
inputs:
  - id: samplesheet
    type: File
    doc: The input samplesheet. Format will be automatically detected from file suffix
      if --format argument not provided
    inputBinding:
      position: 1
  - id: check_file_md5sums
    type:
      - 'null'
      - boolean
    doc: Do a md5sum check for reads which have md5sums added in the samplesheet.
    inputBinding:
      position: 102
      prefix: --check-file-md5sums
  - id: format
    type:
      - 'null'
      - string
    doc: The input samplesheet format - tsv, csv, json, or yaml
    inputBinding:
      position: 102
      prefix: --format
  - id: old
    type:
      - 'null'
      - boolean
    doc: Output old style JSON as used in BioWDL germline-DNA and RNA-seq version
      1 pipelines
    inputBinding:
      position: 102
      prefix: --old
  - id: skip_duplicate_check
    type:
      - 'null'
      - boolean
    doc: Skip the checks for duplicate files in the samplesheet.
    inputBinding:
      position: 102
      prefix: --skip-duplicate-check
  - id: skip_file_check
    type:
      - 'null'
      - boolean
    doc: Skip the checking if files in the samplesheet are present.
    inputBinding:
      position: 102
      prefix: --skip-file-check
  - id: validate
    type:
      - 'null'
      - boolean
    doc: Do not generate output but only validate the samplesheet.
    inputBinding:
      position: 102
      prefix: --validate
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'The output file to which the json is written. Default: stdout'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biowdl-input-converter:0.3.0--pyhdfd78af_0
