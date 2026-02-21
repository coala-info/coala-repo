cwlVersion: v1.2
class: CommandLineTool
baseCommand: wg-blimp
label: wg-blimp
doc: "Whole genome bisulfite sequencing analysis pipeline (Note: The provided text
  is a container runtime error log and does not contain help documentation or argument
  definitions).\n\nTool homepage: https://github.com/MarWoes/wg-blimp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wg-blimp:0.10.0--pyh5e36f6f_0
stdout: wg-blimp.out
