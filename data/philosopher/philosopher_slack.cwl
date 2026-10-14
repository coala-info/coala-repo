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
    doc: "specify the channel name"
    inputBinding:
      position: 100
      prefix: --channel
  - id: direct
    type:
      - 'null'
      - string
    doc: "send a direct message to a user ID"
    inputBinding:
      position: 100
      prefix: --direct
  - id: message
    type:
      - 'null'
      - string
    doc: "specify the text of the message to send"
    inputBinding:
      position: 100
      prefix: --message
  - id: token
    type:
      - 'null'
      - string
    doc: "specify the Slack API token"
    inputBinding:
      position: 100
      prefix: --token
  - id: username
    type:
      - 'null'
      - string
    doc: "specify the name of the bot"
    inputBinding:
      position: 100
      prefix: --username
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
    dockerOutputDirectory: /work
stdout: philosopher_slack.out
