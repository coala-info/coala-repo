cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gencove
  - basespace
  - autoimports
  - create
label: gencove_basespace_autoimports_create
doc: "Sets up periodic import of BaseSpace projects (their Biosamples) whose name
  contain the identifier to a project in Gencove. Optionally assign metadata to the
  samples to be added when the automatic import job runs.\n\nTool homepage: https://docs.gencove.com"
inputs:
  - id: project_id
    type: string
    doc: Gencove project ID.
    inputBinding:
      position: 1
  - id: identifier
    type: string
    doc: String used for identifying projects on BaseSpace.
    inputBinding:
      position: 2
  - id: metadata_json
    type:
      - 'null'
      - string
    doc: Add metadata to all samples that are to be imported from BaseSpace to a
      project.
    inputBinding:
      position: 3
      prefix: --metadata-json
  - id: host
    type:
      - 'null'
      - string
    doc: Optional Gencove API host, including http/s protocol. Can be passed as
      GENCOVE_HOST environment variable.
    inputBinding:
      position: 4
      prefix: --host
  - id: email
    type:
      - 'null'
      - string
    doc: Gencove user email to be used in login. Can be passed as GENCOVE_EMAIL
      environment variable.
    inputBinding:
      position: 5
      prefix: --email
  - id: password
    type:
      - 'null'
      - string
    doc: Gencove user password to be used in login. Can be passed as
      GENCOVE_PASSWORD environment variable.
    inputBinding:
      position: 6
      prefix: --password
  - id: api_key
    type:
      - 'null'
      - string
    doc: Gencove api key. Can be passed as GENCOVE_API_KEY environment variable.
    inputBinding:
      position: 7
      prefix: --api-key
outputs:
  - id: stdout
    type: stdout
    doc: Result message of the autoimport setup.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gencove:4.2.0--pyhdfd78af_0
