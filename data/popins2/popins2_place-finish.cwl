cwlVersion: v1.2
class: CommandLineTool
baseCommand: popins2 place-finish
label: popins2_place-finish
doc: "Combining breakpoint positions from split-read alignment.\n\nTool homepage:
  https://github.com/kehrlab/PopIns2"
inputs:
  - id: insertions
    type:
      - 'null'
      - File
    doc: 'Name of VCF output file. Valid filetype is: vcf.'
    inputBinding:
      position: 101
      prefix: --insertions
  - id: prefix
    type:
      - 'null'
      - Directory
    doc: Path to the sample directories.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reference
    type:
      - 'null'
      - File
    doc: 'Name of reference genome file. Valid filetypes are: fa, fna, and fasta.'
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
stdout: popins2_place-finish.out
