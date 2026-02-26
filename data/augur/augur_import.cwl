cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur import
label: augur_import
doc: "Import analyses into augur pipeline from other systems\n\nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: type
    type: string
    doc: Type of analysis to import (e.g., beast)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
stdout: augur_import.out
