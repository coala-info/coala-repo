cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sqt
  - readcov
label: sqt_readcov
doc: "Print a report for individual reads in a SAM/BAM file.\n\nTool homepage: https://github.com/tdjsnelling/sqtracker"
inputs:
  - id: sam_bam
    type: File
    doc: Name of a SAM or BAM file
    inputBinding:
      position: 1
  - id: region
    type: string
    doc: Region
    inputBinding:
      position: 2
  - id: minimum_cover_fraction
    type:
      - 'null'
      - float
    doc: Alignment must cover at least FRACTION of the read to appear in the 
      cover report.
    inputBinding:
      position: 103
      prefix: --minimum-cover-fraction
  - id: minimum_length
    type:
      - 'null'
      - int
    doc: Minimum read length. Ignore reads that are shorter.
    inputBinding:
      position: 103
      prefix: --minimum-length
  - id: quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    inputBinding:
      position: 103
      prefix: --quality
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
stdout: sqt_readcov.out
