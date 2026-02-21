cwlVersion: v1.2
class: CommandLineTool
baseCommand: idba_subasm_fq2fa
label: idba_subasm_fq2fa
doc: "A tool within the IDBA suite, likely used for converting FASTQ files to FASTA
  format for sub-assembly.\n\nTool homepage: https://github.com/abishara/idba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/idba:v1.1.3-3-deb_cv1
stdout: idba_subasm_fq2fa.out
