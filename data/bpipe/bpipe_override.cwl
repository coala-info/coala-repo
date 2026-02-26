cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpipe override
label: bpipe_override
doc: "Override specified check to force it to pass\n\nTool homepage: http://docs.bpipe.org/"
inputs:
  - id: comment
    type:
      - 'null'
      - string
    doc: comment to add to given operation
    inputBinding:
      position: 101
      prefix: -c
  - id: fail_check
    type:
      - 'null'
      - string
    doc: fail specified check
    inputBinding:
      position: 101
      prefix: -f
  - id: list_checks
    type:
      - 'null'
      - boolean
    doc: list checks and exit, non-interactive mode
    inputBinding:
      position: 101
      prefix: -l
  - id: override_check
    type:
      - 'null'
      - string
    doc: override specified check to force it to pass
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
stdout: bpipe_override.out
