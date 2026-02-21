cwlVersion: v1.2
class: CommandLineTool
baseCommand: gencube
label: gencube
doc: "GenCube is a command-line tool for genomic data management. (Note: The provided
  text contains system error logs and does not include the tool's help documentation;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/snu-cdrc/gencube"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gencube:1.11.0--pyh7e72e81_0
stdout: gencube.out
