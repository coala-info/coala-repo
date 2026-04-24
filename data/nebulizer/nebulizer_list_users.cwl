cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - list_users
label: nebulizer_list_users
doc: "List users in Galaxy instance.\n\n  Prints details of user accounts in GALAXY
  instance.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy_instance
    type: string
    doc: GALAXY instance
    inputBinding:
      position: 1
  - id: long_listing
    type:
      - 'null'
      - boolean
    doc: use a long listing format that includes ids, disk usage and admin 
      status.
    inputBinding:
      position: 102
      prefix: --long
  - id: name
    type:
      - 'null'
      - string
    doc: list only users with matching email or user name. Can include 
      glob-style wild-cards.
    inputBinding:
      position: 102
      prefix: --name
  - id: show_id
    type:
      - 'null'
      - boolean
    doc: include internal Galaxy user ID.
    inputBinding:
      position: 102
      prefix: --show_id
  - id: sort
    type:
      - 'null'
      - string
    doc: comma-separated list of fields to output on; valid fields are 'email', 
      'disk_usage', 'quota', 'quota_usage'
    inputBinding:
      position: 102
      prefix: --sort
  - id: status
    type:
      - 'null'
      - string
    doc: list users with the specified status; can be one of 'active', 
      'deleted', 'purged', 'all'
    inputBinding:
      position: 102
      prefix: --status
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_list_users.out
