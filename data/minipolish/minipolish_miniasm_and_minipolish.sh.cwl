cwlVersion: v1.2
class: CommandLineTool
baseCommand: minipolish_miniasm_and_minipolish.sh
label: minipolish_miniasm_and_minipolish.sh
doc: "A script to run the miniasm and minipolish pipeline. Note: The provided help
  text contains only system error messages regarding container execution and does
  not list specific command-line arguments.\n\nTool homepage: https://github.com/rrwick/Minipolish"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minipolish:0.2.0--pyhdfd78af_0
stdout: minipolish_miniasm_and_minipolish.sh.out
