cwlVersion: v1.2
class: CommandLineTool
baseCommand: go_bug
label: go_bug
doc: "Please file a new issue at golang.org/issue/new using this template:\n\nPlease
  answer these questions before submitting your issue. Thanks!\n\nTool homepage: https://github.com/avelino/awesome-go"
inputs:
  - id: what_did_you_do
    type:
      - 'null'
      - string
    doc: "If possible, provide a recipe for reproducing the error.\nA complete runnable
      program is good.\nA link on play.golang.org is best."
    inputBinding:
      position: 1
  - id: what_did_you_expect_to_see
    type:
      - 'null'
      - string
    doc: What did you expect to see?
    inputBinding:
      position: 2
  - id: what_did_you_see_instead
    type:
      - 'null'
      - string
    doc: What did you see instead?
    inputBinding:
      position: 3
  - id: system_details
    type:
      - 'null'
      - string
    doc: System details
    inputBinding:
      position: 4
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/go:1.11.3
stdout: go_bug.out
