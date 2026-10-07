cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - comb-p
  - peaks
label: combined-pvalues_peaks
doc: "find peaks or troughs in sorted bed files\n\nTool homepage: https://github.com/brentp/combined-pvalues"
inputs:
  - id: dist
    type:
      - 'null'
      - int
    doc: maximum distance to skip before finding a seed/thresh value; if exceeded,
      the region is ended
    inputBinding:
      position: 101
      prefix: --dist
  - id: seed
    type:
      - 'null'
      - float
    doc: a value must be at least this large/small in order to seed a region
    inputBinding:
      position: 101
      prefix: --seed
  - id: threshold
    type:
      - 'null'
      - float
    doc: after seeding, a value of at least this number can extend a region
    inputBinding:
      position: 101
      prefix: --threshold
  - id: invert
    type:
      - 'null'
      - boolean
    doc: test for greater-than (scores or -log10 p-values) instead of less-than
    inputBinding:
      position: 101
      prefix: --invert
  - id: column
    type:
      - 'null'
      - int
    doc: column number (1-based) containing the value for which to find peaks
    inputBinding:
      position: 101
      prefix: -c
  - id: bed_file
    type: File
    doc: sorted BED file
    inputBinding:
      position: 1
outputs:
  - id: output
    type: stdout
    doc: result written to standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/combined-pvalues:0.50.6--pyhdfd78af_0
stdout: combined-pvalues_peaks.out
