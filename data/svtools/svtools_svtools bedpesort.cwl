cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - bedpesort
label: svtools_svtools bedpesort
doc: "Sort a BEDPE file.\n\nTool homepage: https://github.com/hall-lab/svtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
stdout: svtools_svtools bedpesort.out
