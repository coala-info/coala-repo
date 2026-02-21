cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dnmtools
  - amrfinder
label: dnmtools_amrfinder
doc: "The provided help text contains only system error messages regarding container
  execution and does not include usage information for the tool.\n\nTool homepage:
  https://github.com/smithlabcode/dnmtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnmtools:1.5.1--hb66fcc3_0
stdout: dnmtools_amrfinder.out
