cwlVersion: v1.2
class: CommandLineTool
baseCommand: bctools_rm_spurious_events.pl
label: bctools_rm_spurious_events.pl
doc: "A tool from the bctools suite to remove spurious events. (Note: The provided
  help text contains only system error logs and no usage information; arguments could
  not be extracted.)\n\nTool homepage: https://github.com/dmaticzka/bctools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bctools:0.2.2--pl5.22.0_0
stdout: bctools_rm_spurious_events.pl.out
