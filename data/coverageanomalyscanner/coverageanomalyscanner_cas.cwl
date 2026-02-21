cwlVersion: v1.2
class: CommandLineTool
baseCommand: cas
label: coverageanomalyscanner_cas
doc: "CAS - The Coverage Anomaly Scanner. Detects coverage anomalies in BAM files.\n
  \nTool homepage: https://github.com/rki-mf1/CoverageAnomalyScanner"
inputs:
  - id: bam
    type: File
    doc: Read alignment in BAM file format.
    inputBinding:
      position: 101
      prefix: --bam
  - id: chr
    type:
      - 'null'
      - int
    doc: A 0-based chromosome index from the BAM file.
    inputBinding:
      position: 101
      prefix: --chr
  - id: end
    type:
      - 'null'
      - int
    doc: End position in the chromosome.
    inputBinding:
      position: 101
      prefix: --end
  - id: range
    type:
      - 'null'
      - string
    doc: Genomic range in SAMTOOLS style, e.g. chr:beg-end
    inputBinding:
      position: 101
      prefix: --range
  - id: start
    type:
      - 'null'
      - int
    doc: Start position in the chromosome.
    inputBinding:
      position: 101
      prefix: --start
  - id: threshold
    type:
      - 'null'
      - float
    doc: Constant threshold for the anomaly detection. Overwrites the internal default
      formula.
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coverageanomalyscanner:0.2.3--h69ac913_4
stdout: coverageanomalyscanner_cas.out
