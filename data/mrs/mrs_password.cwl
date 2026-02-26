cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrs_password
label: mrs_password
doc: "Modify user password information\n\nTool homepage: https://github.com/ctu-mrs/mrs_uav_system"
inputs:
  - id: config
    type:
      - 'null'
      - string
    doc: Configuration file
    inputBinding:
      position: 101
      prefix: --config
  - id: realm
    type:
      - 'null'
      - string
    doc: Realm to modify
    inputBinding:
      position: 101
      prefix: --realm
  - id: user
    type:
      - 'null'
      - string
    doc: User to modify
    inputBinding:
      position: 101
      prefix: --user
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
stdout: mrs_password.out
