cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - womtool
  - highlight
label: womtool_highlight
doc: "(Deprecated; WDL draft 2 only) Print out the Hermes parser's abstract syntax tree for the source file. Requires 'html' or 'console'.\n\nTool homepage: https://cromwell.readthedocs.io/en/develop/WOMtool/"
inputs:
  - id: workflow_source
    type: File
    doc: Path to workflow file.
    inputBinding:
      position: 1
  - id: highlight_mode
    type: string
    doc: "Highlighting mode, one of 'html', 'console'."
    inputBinding:
      position: 0
      prefix: --highlight-mode
outputs:
  - id: stdout
    type: stdout
    doc: Result printed by womtool
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/womtool:61--hdfd78af_0
stdout: womtool_highlight.out
