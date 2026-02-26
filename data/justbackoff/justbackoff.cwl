cwlVersion: v1.2
class: CommandLineTool
baseCommand: justbackoff
label: justbackoff
doc: "A tool to retry a command with exponential backoff.\n\nTool homepage: https://github.com/admiralobvious/justbackoff"
inputs:
  - id: command
    type: string
    doc: The command to execute
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
  - id: factor
    type:
      - 'null'
      - float
    doc: Backoff factor
    default: 2.0
    inputBinding:
      position: 103
      prefix: --factor
  - id: max_retries
    type:
      - 'null'
      - int
    doc: Maximum number of retries
    default: 5
    inputBinding:
      position: 103
      prefix: --max-retries
  - id: sleep
    type:
      - 'null'
      - float
    doc: Initial sleep time in seconds
    default: 1.0
    inputBinding:
      position: 103
      prefix: --sleep
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/justbackoff:0.4.0--py36_0
stdout: justbackoff.out
