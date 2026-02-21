cwlVersion: v1.2
class: CommandLineTool
baseCommand: hifieval_hifieval.py
label: hifieval_hifieval.py
doc: "A tool for HiFi sequencing evaluation. (Note: The provided help text contains
  system error messages regarding container execution and does not list command-line
  arguments.)\n\nTool homepage: https://github.com/magspho/hifieval"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifieval:0.4.0--pyh7cba7a3_0
stdout: hifieval_hifieval.py.out
