cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bigwig, stats]
label: bigwig-nim_stats
doc: "extract stats (mean, coverage, min, max, sum) from a bigwig for regions\n\nTool homepage: https://github.com/brentp/bigwig-nim"
inputs:
  - id: input
    type: File
    doc: input BigWig file
    inputBinding:
      position: 10
  - id: region
    type:
      - File
      - string
    doc: BED file of regions, or chromosome, or chrom:start-stop region to extract stats
    inputBinding:
      position: 11
  - id: stat
    type:
      - 'null'
      - type: enum
        symbols:
          - mean
          - coverage
          - min
          - max
          - sum
          - header
    doc: 'statistic to output; ''header'' shows the lengths, mean and coverage for each chromosome (default:
      mean)'
    inputBinding:
      position: 1
      prefix: --stat=
      separate: false
  - id: bins
    type:
      - 'null'
      - int
    doc: 'integer number of bins (default: 1)'
    inputBinding:
      position: 1
      prefix: --bins=
      separate: false
outputs:
  - id: stats
    type: stdout
    doc: Tab-delimited chrom, start, stop, stat for each region
stdout: $(inputs.input.nameroot).stats.tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigwig-nim:0.0.3--h9ee0642_0
