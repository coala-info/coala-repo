cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gencove
  - basespace
  - autoimports
  - autoimport_list
label: gencove_autoimport_list
doc: "List BaseSpace autoimports.\n\nTool homepage: https://docs.gencove.com"
inputs:
  - id: after
    type:
      - 'null'
      - string
    doc: Filter by date (YYYY-MM-DD). Only show autoimports created after this 
      date.
    inputBinding:
      position: 101
      prefix: --after
  - id: before
    type:
      - 'null'
      - string
    doc: Filter by date (YYYY-MM-DD). Only show autoimports created before this 
      date.
    inputBinding:
      position: 101
      prefix: --before
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Output format. Supported formats: json, tsv.'
    inputBinding:
      position: 101
      prefix: --output-format
  - id: page_size
    type:
      - 'null'
      - int
    doc: Number of items to return per page.
    inputBinding:
      position: 101
      prefix: --page-size
  - id: page_token
    type:
      - 'null'
      - string
    doc: Page token for pagination.
    inputBinding:
      position: 101
      prefix: --page-token
  - id: project_id
    type:
      - 'null'
      - string
    doc: Filter by project ID.
    inputBinding:
      position: 101
      prefix: --project-id
  - id: project_name
    type:
      - 'null'
      - string
    doc: Filter by project name.
    inputBinding:
      position: 101
      prefix: --project-name
  - id: run_id
    type:
      - 'null'
      - string
    doc: Filter by run ID.
    inputBinding:
      position: 101
      prefix: --run-id
  - id: run_name
    type:
      - 'null'
      - string
    doc: Filter by run name.
    inputBinding:
      position: 101
      prefix: --run-name
  - id: sample_id
    type:
      - 'null'
      - string
    doc: Filter by sample ID.
    inputBinding:
      position: 101
      prefix: --sample-id
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Filter by sample name.
    inputBinding:
      position: 101
      prefix: --sample-name
  - id: status
    type:
      - 'null'
      - string
    doc: 'Filter by status. Supported statuses: pending, imported, failed.'
    inputBinding:
      position: 101
      prefix: --status
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file path.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gencove:4.2.0--pyhdfd78af_0
