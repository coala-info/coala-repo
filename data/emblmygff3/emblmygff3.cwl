cwlVersion: v1.2
class: CommandLineTool
baseCommand: emblmygff3
label: emblmygff3
doc: "A tool for converting GFF3 files to EMBL format. (Note: The provided help text
  contains only system error messages and no usage information.)\n\nTool homepage:
  https://github.com/NBISweden/EMBLmyGFF3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emblmygff3:2.4--pyhdfd78af_1
stdout: emblmygff3.out
