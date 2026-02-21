cwlVersion: v1.2
class: CommandLineTool
baseCommand: motulizer_anvi-run-motupan.py
label: motulizer_anvi-run-motupan.py
doc: "mOTUlizer: anvi-run-motupan.py (Note: The provided text contains system error
  logs regarding a container execution failure and does not include usage instructions
  or argument definitions).\n\nTool homepage: https://github.com/moritzbuck/mOTUlizer/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motulizer:0.3.2--pyhdfd78af_0
stdout: motulizer_anvi-run-motupan.py.out
