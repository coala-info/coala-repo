cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - create_user
label: nebulizer_create_user
doc: "Create new Galaxy user.\n\nCreates a new user in GALAXY, using EMAIL for the
  username. If PUBLIC_NAME\nis not supplied then it will be generated automatically
  from the leading\npart of the email address.\n\nIf a password for the new account
  is not supplied using the --password\noption then nebulizer will prompt for one.\n\
  \nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy
    type: string
    doc: GALAXY instance identifier
    inputBinding:
      position: 1
  - id: email
    type: string
    doc: Email address for the new user
    inputBinding:
      position: 2
  - id: public_name
    type:
      - 'null'
      - string
    doc: Public name for the new user (defaults to part of email)
    inputBinding:
      position: 3
  - id: check
    type:
      - 'null'
      - boolean
    doc: check user details but don't try to create the new account
    inputBinding:
      position: 104
      prefix: --check
  - id: message
    type:
      - 'null'
      - File
    doc: Mako template to populate and output
    inputBinding:
      position: 104
      prefix: --message
  - id: password
    type:
      - 'null'
      - string
    doc: specify password for new user account (otherwise program will prompt 
      for password)
    inputBinding:
      position: 104
      prefix: --password
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_create_user.out
