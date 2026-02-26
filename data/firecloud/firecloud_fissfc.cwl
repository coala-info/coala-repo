cwlVersion: v1.2
class: CommandLineTool
baseCommand: fissfc
label: firecloud_fissfc
doc: "FISS: The FireCloud CLI\n\nTool homepage: https://github.com/broadinstitute/fiss"
inputs:
  - id: command
    type:
      type: array
      items: string
    doc: Command and arguments to run.
    inputBinding:
      position: 1
  - id: api_url
    type:
      - 'null'
      - string
    doc: Firecloud API root URL
    default: https://api.firecloud.org/api/
    inputBinding:
      position: 102
      prefix: --url
  - id: credentials
    type:
      - 'null'
      - File
    doc: Firecloud credentials file
    inputBinding:
      position: 102
      prefix: --credentials
  - id: function
    type:
      - 'null'
      - type: array
        items: string
    doc: Show the code for the given command(s) and exit
    inputBinding:
      position: 102
      prefix: --function
  - id: list
    type:
      - 'null'
      - type: array
        items: string
    doc: list or search available commands and exit
    inputBinding:
      position: 102
      prefix: --list
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Emit progressively more detailed feedback during execution, e.g. to 
      confirm when actions have completed or to show URL and parameters of REST 
      calls. Multiple -V may be given.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Assume yes for any prompts
    inputBinding:
      position: 102
      prefix: --yes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/firecloud:0.16.38--pyhdfd78af_0
stdout: firecloud_fissfc.out
