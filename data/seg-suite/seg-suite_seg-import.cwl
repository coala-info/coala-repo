cwlVersion: v1.2
class: CommandLineTool
baseCommand: seg-import
label: seg-suite_seg-import
doc: "The provided text does not contain help information or usage instructions as
  it is a log of a failed container build process (no space left on device).\n\nTool
  homepage: https://github.com/mcfrith/seg-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seg-suite:98--py310h184ae93_0
stdout: seg-suite_seg-import.out
