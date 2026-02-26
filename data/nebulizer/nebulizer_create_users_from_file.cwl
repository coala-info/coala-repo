cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - create_users_from_file
label: nebulizer_create_users_from_file
doc: "Create multiple Galaxy users from a file.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy_instance
    type: string
    doc: Galaxy instance to create users in
    inputBinding:
      position: 1
  - id: user_details_file
    type: File
    doc: Tab-delimited file with user details (email, password, optional 
      public_name)
    inputBinding:
      position: 2
  - id: check
    type:
      - 'null'
      - boolean
    doc: check user details but don't try to create the new account.
    inputBinding:
      position: 103
      prefix: --check
  - id: message_template
    type:
      - 'null'
      - File
    doc: Mako template to populate and output.
    inputBinding:
      position: 103
      prefix: --message
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_create_users_from_file.out
