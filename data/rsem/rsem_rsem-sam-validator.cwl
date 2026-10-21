cwlVersion: v1.2
class: CommandLineTool
baseCommand: [rsem-sam-validator]
label: rsem_rsem-sam-validator
doc: "Validate that a SAM/BAM/CRAM file can be used as input for RSEM.\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: input_alignments
    type: File
    doc: Input SAM, BAM or CRAM file.
    inputBinding:
      position: 1
outputs:
  - id: validation_report
    type: stdout
    doc: Validation message printed by the tool.
stdout: rsem-sam-validator.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
