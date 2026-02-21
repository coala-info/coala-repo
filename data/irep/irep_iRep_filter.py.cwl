cwlVersion: v1.2
class: CommandLineTool
baseCommand: irep_iRep_filter.py
label: irep_iRep_filter.py
doc: "A tool for filtering iRep results. Note: The provided help text contains only
  system error messages regarding container execution and does not list specific command-line
  arguments.\n\nTool homepage: https://github.com/christophertbrown/iRep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irep:1.1.7--pyh24bf2e0_1
stdout: irep_iRep_filter.py.out
