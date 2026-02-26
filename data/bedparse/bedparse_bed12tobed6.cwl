cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedparse
  - bed12tobed6
label: bedparse_bed12tobed6
doc: "Convert the BED12 format into BED6 by reporting a separate line for each block
  of the original record.\n\nTool homepage: https://github.com/tleonardi/bedparse"
inputs:
  - id: bedfile
    type:
      - 'null'
      - File
    doc: Path to the GTF file.
    inputBinding:
      position: 1
  - id: append_exn
    type:
      - 'null'
      - boolean
    doc: Appends the exon number to the transcript name.
    inputBinding:
      position: 102
      prefix: --appendExN
  - id: keep_introns
    type:
      - 'null'
      - boolean
    doc: Add records for introns as well. Only allowed if --whichExon all
    inputBinding:
      position: 102
      prefix: --keepIntrons
  - id: which_exon
    type:
      - 'null'
      - string
    doc: Which exon to return. First and last respectively report the first or 
      last exon relative to the TSS (i.e. taking strand into account).
    inputBinding:
      position: 102
      prefix: --whichExon
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedparse:0.2.3--py_0
stdout: bedparse_bed12tobed6.out
