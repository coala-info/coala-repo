cwlVersion: v1.2
class: CommandLineTool
baseCommand: tw
label: tower-cli_tw
doc: "Seqera Platform CLI\n\nTool homepage: https://github.com/seqeralabs/tower-cli"
inputs:
  - id: command
    type:
      - 'null'
      - string
    doc: The command to execute (actions, collaborators, compute-envs, 
      credentials, data-links, studios, datasets, generate-completion, info, 
      labels, launch, members, organizations, participants, pipelines, runs, 
      teams, workspaces, secrets)
    inputBinding:
      position: 1
  - id: access_token
    type:
      - 'null'
      - string
    doc: Seqera Platform personal access token (TOWER_ACCESS_TOKEN)
    inputBinding:
      position: 102
      prefix: --access-token
  - id: insecure
    type:
      - 'null'
      - boolean
    doc: Explicitly allow to connect to a non-SSL secured Seqera Platform server
      (not recommended)
    inputBinding:
      position: 102
      prefix: --insecure
  - id: output
    type:
      - 'null'
      - string
    doc: Show output in defined format (currently supports 'json')
    inputBinding:
      position: 102
      prefix: --output
  - id: url
    type:
      - 'null'
      - string
    doc: Seqera Platform API endpoint URL (TOWER_API_ENDPOINT)
    inputBinding:
      position: 102
      prefix: --url
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show HTTP request/response logs at stderr.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tower-cli:0.21.0--hdfd78af_0
stdout: tower-cli_tw.out
