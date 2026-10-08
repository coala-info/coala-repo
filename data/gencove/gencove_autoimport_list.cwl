cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gencove
  - basespace
  - autoimports
  - list
label: gencove_autoimport_list
doc: "Lists periodic import of BaseSpace projects (their Biosamples) jobs.\n\nTool
  homepage: https://docs.gencove.com"
inputs:
  - id: host
    type:
      - 'null'
      - string
    doc: Optional Gencove API host, including http/s protocol. Can be passed as
      GENCOVE_HOST environment variable.
    inputBinding:
      position: 1
      prefix: --host
  - id: email
    type:
      - 'null'
      - string
    doc: Gencove user email to be used in login. Can be passed as GENCOVE_EMAIL
      environment variable.
    inputBinding:
      position: 2
      prefix: --email
  - id: password
    type:
      - 'null'
      - string
    doc: Gencove user password to be used in login. Can be passed as
      GENCOVE_PASSWORD environment variable.
    inputBinding:
      position: 3
      prefix: --password
  - id: api_key
    type:
      - 'null'
      - string
    doc: Gencove api key. Can be passed as GENCOVE_API_KEY environment variable.
    inputBinding:
      position: 4
      prefix: --api-key
outputs:
  - id: stdout
    type: stdout
    doc: List of BaseSpace autoimport jobs.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gencove:4.2.0--pyhdfd78af_0
