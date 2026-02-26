cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - slack
label: philosopher_slack
doc: "Send messages to Slack\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: channel
    type:
      - 'null'
      - string
    doc: specify the channel name
    inputBinding:
      position: 101
      prefix: --channel
  - id: direct
    type:
      - 'null'
      - string
    doc: send a direct message to a user ID
    inputBinding:
      position: 101
      prefix: --direct
  - id: message
    type:
      - 'null'
      - string
    doc: specify the text of the message to send
    inputBinding:
      position: 101
      prefix: --message
  - id: token
    type:
      - 'null'
      - string
    doc: specify the Slack API token
    inputBinding:
      position: 101
      prefix: --token
  - id: username
    type:
      - 'null'
      - string
    doc: specify the name of the bot
    default: Philosopher
    inputBinding:
      position: 101
      prefix: --username
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
stdout: philosopher_slack.out
