cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - add_epi_week
label: datafunk_add_epi_week
doc: "Add epidemiological week and day columns to metadata.\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: date_column
    type: string
    doc: Column name to convert to epi week
    inputBinding:
      position: 101
      prefix: --date-column
  - id: epi_day_column_name
    type:
      - 'null'
      - string
    doc: Column name for epi day column
    inputBinding:
      position: 101
      prefix: --epi-day-column-name
  - id: epi_week_column_name
    type:
      - 'null'
      - string
    doc: Column name for epi week column
    inputBinding:
      position: 101
      prefix: --epi-week-column-name
  - id: input_metadata
    type: File
    doc: Input CSV or TSV
    inputBinding:
      position: 101
      prefix: --input-metadata
outputs:
  - id: output_metadata
    type: File
    doc: Input CSV or TSV
    outputBinding:
      glob: $(inputs.output_metadata)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
