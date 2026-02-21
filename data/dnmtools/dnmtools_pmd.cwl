cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dnmtools
  - pmd
label: dnmtools_pmd
doc: "The provided text does not contain help information for dnmtools_pmd; it contains
  system environment logs and a fatal error message regarding container execution.\n
  \nTool homepage: https://github.com/smithlabcode/dnmtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnmtools:1.5.1--hb66fcc3_0
stdout: dnmtools_pmd.out
