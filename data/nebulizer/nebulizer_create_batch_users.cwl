cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - create_batch_users
label: nebulizer_create_batch_users
doc: "Create multiple Galaxy users from a template.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy
    type: string
    doc: GALAXY instance or identifier
    inputBinding:
      position: 1
  - id: template
    type: string
    doc: Template email address with '#' as placeholder for index
    inputBinding:
      position: 2
  - id: start
    type: int
    doc: Start of the integer range for user creation
    inputBinding:
      position: 3
  - id: end
    type:
      - 'null'
      - int
    doc: End of the integer range for user creation (defaults to START if not 
      provided)
    inputBinding:
      position: 4
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check user details but don't try to create the new account.
    inputBinding:
      position: 105
      prefix: --check
  - id: password
    type:
      - 'null'
      - string
    doc: Specify password for new user accounts (otherwise program will prompt 
      for password). All accounts will be created with the same password.
    inputBinding:
      position: 105
      prefix: --password
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_create_batch_users.out
