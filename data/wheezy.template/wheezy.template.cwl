cwlVersion: v1.2
class: CommandLineTool
baseCommand: wheezy.template
label: wheezy.template
doc: "Renders a template with the provided context.\n\nTool homepage: https://bitbucket.org/akorn/wheezy.template"
inputs:
  - id: template
    type: File
    doc: The template filename.
    inputBinding:
      position: 1
  - id: context
    type:
      - 'null'
      - type: array
        items: string
    doc: A filename or JSON string representing the context.
    inputBinding:
      position: 2
  - id: line_join_token
    type:
      - 'null'
      - string
    doc: Line join token
    default: \
    inputBinding:
      position: 103
      prefix: -j
  - id: search_path
    type:
      - 'null'
      - Directory
    doc: Search path for templates
    default: .
    inputBinding:
      position: 103
      prefix: -s
  - id: token_start
    type:
      - 'null'
      - string
    doc: Token start
    default: '@'
    inputBinding:
      position: 103
      prefix: -t
  - id: whitespace_cleanup
    type:
      - 'null'
      - boolean
    doc: Enable whitespace cleanup.
    inputBinding:
      position: 103
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wheezy.template:3.2.5--pyhdfd78af_0
stdout: wheezy.template.out
