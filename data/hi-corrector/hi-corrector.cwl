cwlVersion: v1.2
class: CommandLineTool
baseCommand: hi-corrector
label: hi-corrector
doc: "A tool for Hi-C data correction. Note: The provided help text contains only
  system error messages regarding container image building and does not list specific
  command-line arguments.\n\nTool homepage: https://github.com/jasminezhoulab/Hi-Corrector"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hi-corrector:1.2--h719ac0c_5
stdout: hi-corrector.out
