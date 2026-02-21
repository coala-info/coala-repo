cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtforms-components
label: wtforms-components
doc: "WTForms-Components provides various additional fields, validators and widgets
  for WTForms. (Note: The provided text appears to be a container build log rather
  than help text, so no arguments could be extracted.)\n\nTool homepage: https://github.com/kvesteri/wtforms-components"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wtforms-components:0.10.0--py35_0
stdout: wtforms-components.out
