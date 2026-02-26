cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedparse_introns
label: bedparse_introns
doc: "Report BED12 lines corresponding to the introns of each transcript. Unspliced
  transcripts are not reported.\n\nTool homepage: https://github.com/tleonardi/bedparse"
inputs:
  - id: bedfile
    type:
      - 'null'
      - File
    doc: Path to the BED file.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedparse:0.2.3--py_0
stdout: bedparse_introns.out
