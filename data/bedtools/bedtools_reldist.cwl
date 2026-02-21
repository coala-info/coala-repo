cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - reldist
label: bedtools_reldist
doc: "Calculate the relative distance distribution b/w two feature files.\n\nTool
  homepage: http://bedtools.readthedocs.org/"
inputs:
  - id: detail
    type:
      - 'null'
      - boolean
    doc: Report the relativedistance for each interval in A
    inputBinding:
      position: 101
      prefix: -detail
  - id: input_a
    type: File
    doc: BED/GFF/VCF file A
    inputBinding:
      position: 101
      prefix: -a
  - id: input_b
    type: File
    doc: BED/GFF/VCF file B
    inputBinding:
      position: 101
      prefix: -b
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
stdout: bedtools_reldist.out
