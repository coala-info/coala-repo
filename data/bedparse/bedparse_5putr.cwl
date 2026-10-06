cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedparse
  - 5pUTR
label: bedparse_5putr
doc: "Report the 5'UTR of each coding transcript (i.e. transcripts with distinct\nvalues
  of thickStart and thickEnd). Transcripts without CDS are not reported.\n\nTool homepage:
  https://github.com/tleonardi/bedparse"
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
stdout: bedparse_5putr.out
