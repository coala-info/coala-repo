cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dnmtools
  - hmr
label: dnmtools_hmr
doc: "The provided text does not contain help information for dnmtools hmr; it contains
  a system error message regarding container image building (no space left on device).\n
  \nTool homepage: https://github.com/smithlabcode/dnmtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnmtools:1.5.1--hb66fcc3_0
stdout: dnmtools_hmr.out
