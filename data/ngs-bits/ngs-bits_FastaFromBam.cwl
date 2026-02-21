cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastaFromBam
label: ngs-bits_FastaFromBam
doc: "Extracts sequences from a BAM file into FASTA format. (Note: The provided help
  text contained only system error messages regarding container execution and did
  not list specific arguments.)\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_09--py313h572c47f_0
stdout: ngs-bits_FastaFromBam.out
