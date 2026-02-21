cwlVersion: v1.2
class: CommandLineTool
baseCommand: seg-join
label: seg-suite_seg-join
doc: "No description available: The provided text was a system error log rather than
  help text.\n\nTool homepage: https://github.com/mcfrith/seg-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seg-suite:98--py310h184ae93_0
stdout: seg-suite_seg-join.out
