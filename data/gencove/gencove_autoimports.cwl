cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gencove
  - basespace
  - autoimports
  - autoimport_list
label: gencove_autoimports
doc: "List BaseSpace autoimports\n\nTool homepage: https://docs.gencove.com"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output file if it exists
    inputBinding:
      position: 101
      prefix: --force
  - id: project_id
    type: string
    doc: Project ID
    inputBinding:
      position: 101
      prefix: --project-id
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gencove:4.2.0--pyhdfd78af_0
