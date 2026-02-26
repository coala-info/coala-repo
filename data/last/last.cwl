cwlVersion: v1.2
class: CommandLineTool
baseCommand: last
label: last
doc: "Show listing of the last users that logged into the system\n\nTool homepage:
  https://gitlab.com/mcfrith/last"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Read from FILE instead of /var/log/wtmp
    default: /var/log/wtmp
    inputBinding:
      position: 101
      prefix: -f
  - id: no_host_truncation
    type:
      - 'null'
      - boolean
    doc: Display with no host column truncation
    inputBinding:
      position: 101
      prefix: -W
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/last:1650--h5ca1c30_0
stdout: last.out
