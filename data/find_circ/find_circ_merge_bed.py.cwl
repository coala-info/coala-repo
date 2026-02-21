cwlVersion: v1.2
class: CommandLineTool
baseCommand: find_circ_merge_bed.py
label: find_circ_merge_bed.py
doc: "Merge BED files (Note: The provided help text contains system error messages
  and does not list specific tool arguments).\n\nTool homepage: https://github.com/marvin-jens/find_circ"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/find_differential_primers:0.1.4--py_0
stdout: find_circ_merge_bed.py.out
