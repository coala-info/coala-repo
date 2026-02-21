cwlVersion: v1.2
class: CommandLineTool
baseCommand: bctools_rm_spurious_events.py
label: bctools_rm_spurious_events.py
doc: "Remove spurious events from cross-linking data (Note: The provided help text
  was a system error log and did not contain usage information).\n\nTool homepage:
  https://github.com/dmaticzka/bctools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bctools:0.2.2--pl5.22.0_0
stdout: bctools_rm_spurious_events.py.out
