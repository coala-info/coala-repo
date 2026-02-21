cwlVersion: v1.2
class: CommandLineTool
baseCommand: bctools_merge_pcr_duplicates.py
label: bctools_merge_pcr_duplicates.py
doc: "Merge PCR duplicates (Note: The provided text is a system error log and does
  not contain help information or argument definitions).\n\nTool homepage: https://github.com/dmaticzka/bctools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bctools:0.2.2--pl5.22.0_0
stdout: bctools_merge_pcr_duplicates.py.out
