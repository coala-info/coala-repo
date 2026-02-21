cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribocode_GTFupdate
label: ribocode_GTFupdate
doc: "Update GTF file for RiboCode. (Note: The provided help text contains system
  error logs and does not list specific arguments or usage instructions.)\n\nTool
  homepage: https://github.com/xryanglab/RiboCode"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribocode:1.2.15--pyhdc42f0e_1
stdout: ribocode_GTFupdate.out
