cwlVersion: v1.2
class: CommandLineTool
baseCommand: watchdog
label: watchdog
doc: "Periodically write to watchdog device DEV\n\nTool homepage: https://github.com/gorakhargosh/watchdog"
inputs:
  - id: device
    type: string
    doc: watchdog device
    inputBinding:
      position: 1
  - id: foreground
    type:
      - 'null'
      - boolean
    doc: Run in foreground
    inputBinding:
      position: 102
      prefix: -F
  - id: reboot_timeout
    type:
      - 'null'
      - string
    doc: Reboot after N seconds if not reset
    inputBinding:
      position: 102
      prefix: -T
  - id: reset_interval
    type:
      - 'null'
      - string
    doc: Reset every N seconds
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/watchdog:0.8.3--py36_0
stdout: watchdog.out
