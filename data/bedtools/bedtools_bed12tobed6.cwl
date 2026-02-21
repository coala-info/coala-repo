cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - bed12tobed6
label: bedtools_bed12tobed6
doc: "Splits BED12 features into discrete BED6 features.\n\nTool homepage: http://bedtools.readthedocs.org/"
inputs:
  - id: force_score
    type:
      - 'null'
      - boolean
    doc: Force the score to be the (1-based) block number from the BED12.
    inputBinding:
      position: 101
      prefix: -n
  - id: input_file
    type: File
    doc: Input BED12 file
    inputBinding:
      position: 101
      prefix: -i
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_bed12tobed6.out
