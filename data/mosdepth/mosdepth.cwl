cwlVersion: v1.2
class: CommandLineTool
baseCommand: mosdepth
label: mosdepth
doc: "fast BAM/CRAM depth calculation for WGS, exome, or targeted sequencing\n\nTool
  homepage: https://github.com/brentp/mosdepth"
inputs:
  - id: prefix
    type: string
    doc: Prefix for output files
    inputBinding:
      position: 1
  - id: bam_or_cram
    type: File
    doc: Input BAM or CRAM file
    inputBinding:
      position: 2
  - id: by
    type:
      - 'null'
      - string
    doc: optional BED file or fixed window size
    inputBinding:
      position: 103
      prefix: --by
  - id: chrom
    type:
      - 'null'
      - string
    doc: chromosome to restrict depth calculation to
    inputBinding:
      position: 103
      prefix: --chrom
  - id: fast_mode
    type:
      - 'null'
      - boolean
    doc: dont look at internal BAM flags. much faster for simple depth
    inputBinding:
      position: 103
      prefix: --fast-mode
  - id: mapq
    type:
      - 'null'
      - int
    doc: mapping quality threshold
    inputBinding:
      position: 103
      prefix: --mapq
  - id: no_per_base
    type:
      - 'null'
      - boolean
    doc: dont output per-base depth. skipping this makes mosdepth much faster
    inputBinding:
      position: 103
      prefix: --no-per-base
  - id: quantize
    type:
      - 'null'
      - string
    doc: write output quantized to these specific depth ranges
    inputBinding:
      position: 103
      prefix: --quantize
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 103
      prefix: --threads
  - id: thresholds
    type:
      - 'null'
      - string
    doc: for each interval in --by, write number of bases covered by at least threshold
      bases
    inputBinding:
      position: 103
      prefix: --thresholds
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mosdepth:0.3.12--h0ec343a_0
stdout: mosdepth.out
