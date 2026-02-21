cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dnmtools
  - xcounts
label: dnmtools_xcounts
doc: "The provided text does not contain help information for dnmtools_xcounts; it
  contains an error message regarding a container runtime failure (no space left on
  device).\n\nTool homepage: https://github.com/smithlabcode/dnmtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnmtools:1.5.1--hb66fcc3_0
stdout: dnmtools_xcounts.out
