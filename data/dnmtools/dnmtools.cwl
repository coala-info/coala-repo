cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnmtools
label: dnmtools
doc: "DNA methylation analysis tools (Note: The provided input text contains a system
  error message rather than the tool's help documentation. No arguments could be extracted.)\n
  \nTool homepage: https://github.com/smithlabcode/dnmtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnmtools:1.5.1--hb66fcc3_0
stdout: dnmtools.out
