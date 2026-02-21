cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seg-sort
label: seg-suite_seg-sort
doc: "The provided text does not contain help information or usage instructions. It
  is an error log indicating a failure to build or run the container image due to
  insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/mcfrith/seg-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seg-suite:98--py310h184ae93_0
stdout: seg-suite_seg-sort.out
