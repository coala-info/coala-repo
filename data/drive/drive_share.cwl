cwlVersion: v1.2
class: CommandLineTool
baseCommand: share
label: drive_share
doc: "Share a file\n\nTool homepage: https://github.com/kamranahmedse/driver.js"
inputs:
  - id: emails
    type:
      - 'null'
      - string
    doc: emails to share the file to
    inputBinding:
      position: 101
      prefix: --emails
  - id: id
    type:
      - 'null'
      - boolean
    doc: share by id instead of path
    inputBinding:
      position: 101
      prefix: --id
  - id: message
    type:
      - 'null'
      - string
    doc: message to send receipients
    inputBinding:
      position: 101
      prefix: --message
  - id: no_prompt
    type:
      - 'null'
      - boolean
    doc: disables the prompt
    inputBinding:
      position: 101
      prefix: --no-prompt
  - id: notify
    type:
      - 'null'
      - boolean
    doc: toggle whether to notify receipients about share
    default: true
    inputBinding:
      position: 101
      prefix: --notify
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: if set, do not log anything but errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: role
    type:
      - 'null'
      - string
    doc: "role to set to receipients of share. Possible values: \n\t* owner.\n\t*
      reader.\n\t* writer.\n\t* commenter."
    inputBinding:
      position: 101
      prefix: --role
  - id: type
    type:
      - 'null'
      - string
    doc: "scope of accounts to share files with. Possible values: \n\t* anyone.\n\t
      * user.\n\t* domain.\n\t* group"
    inputBinding:
      position: 101
      prefix: --type
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show step by step information verbosely
    default: true
    inputBinding:
      position: 101
      prefix: --verbose
  - id: with_link
    type:
      - 'null'
      - boolean
    doc: turn off file indexing so that only those with the link can view it
    inputBinding:
      position: 101
      prefix: --with-link
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drive:0.3.9--0
stdout: drive_share.out
