cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sambamba
  - validate
label: sambamba_validate
doc: "Validates a bam file.\n\nTool homepage: https://github.com/biod/sambamba"
inputs:
  - id: input_bam
    type:
      type: array
      items: File
    doc: Input BAM file(s) to validate
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (validation messages)
  - id: stderr
    type: stderr
    doc: Standard error (progress and error messages)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sambamba:1.0.1--he614052_4
stdout: sambamba_validate.out
stderr: sambamba_validate.err
