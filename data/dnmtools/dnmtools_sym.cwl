cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dnmtools
  - sym
label: dnmtools_sym
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image creation (no space
  left on device).\n\nTool homepage: https://github.com/smithlabcode/dnmtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnmtools:1.5.1--hb66fcc3_0
stdout: dnmtools_sym.out
