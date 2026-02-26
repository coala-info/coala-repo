cwlVersion: v1.2
class: CommandLineTool
baseCommand: solvebio ls
label: solvebio_ls
doc: "List files and folders in the SolveBio vault\n\nTool homepage: https://github.com/solvebio/solvebio-python"
inputs:
  - id: full_path
    type:
      - 'null'
      - string
    doc: The full path where the files and folders should be listed from, 
      defaults to the root of your personal vault
    inputBinding:
      position: 1
  - id: access_token
    type:
      - 'null'
      - string
    doc: Manually provide a SolveBio OAuth2 access token
    inputBinding:
      position: 102
      prefix: --access-token
  - id: api_host
    type:
      - 'null'
      - string
    doc: Override the default SolveBio API host
    inputBinding:
      position: 102
      prefix: --api-host
  - id: api_key
    type:
      - 'null'
      - string
    doc: Manually provide a SolveBio API key
    inputBinding:
      position: 102
      prefix: --api-key
  - id: follow_shortcuts
    type:
      - 'null'
      - boolean
    doc: Resolves shortcuts when listing.
    inputBinding:
      position: 102
      prefix: --follow-shortcuts
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Recursively list the contents of subdirectories.
    inputBinding:
      position: 102
      prefix: --recursive
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/solvebio:2.34.0--pyh7e72e81_0
stdout: solvebio_ls.out
