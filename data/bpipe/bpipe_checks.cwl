cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpipe_checks
label: bpipe_checks
doc: "Check Report\n\nTool homepage: http://docs.bpipe.org/"
inputs:
  - id: check_override
    type:
      - 'null'
      - string
    doc: Enter a number of a check to override, * for all
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
stdout: bpipe_checks.out
