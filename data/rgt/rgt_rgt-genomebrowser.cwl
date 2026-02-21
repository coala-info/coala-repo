cwlVersion: v1.2
class: CommandLineTool
baseCommand: rgt-genomebrowser
label: rgt_rgt-genomebrowser
doc: "The provided text contains system logs and a fatal error message regarding a
  container build failure; it does not contain help text or usage information for
  the tool. Consequently, no arguments could be extracted.\n\nTool homepage: http://www.regulatory-genomics.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgt:1.0.2--py37he4a0461_0
stdout: rgt_rgt-genomebrowser.out
