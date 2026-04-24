cwlVersion: v1.2
class: CommandLineTool
baseCommand: covtobed
label: covtobed
doc: "Computes coverage from alignments\n\nTool homepage: https://github.com/telatin/covtobed/"
inputs:
  - id: bam
    type:
      - 'null'
      - type: array
        items: File
    doc: Input BAM file(s)
    inputBinding:
      position: 1
  - id: discard_invalid_alignments
    type:
      - 'null'
      - boolean
    doc: 'skip duplicates, failed QC, and non primary alignment, minq>0 (or user-defined
      if higher) (default: enabled)'
    inputBinding:
      position: 102
      prefix: --discard-invalid-alignments
  - id: format
    type:
      - 'null'
      - string
    doc: output format
    inputBinding:
      position: 102
      prefix: --format
  - id: keep_invalid_alignments
    type:
      - 'null'
      - boolean
    doc: Keep duplicates, failed QC, and non primary alignment, min=0 (or user-defined
      if higher) - reverts to legacy behavior
    inputBinding:
      position: 102
      prefix: --keep-invalid-alignments
  - id: max_cov
    type:
      - 'null'
      - int
    doc: print BED feature only if the coverage is lower than MAXCOV
    inputBinding:
      position: 102
      prefix: --max-cov
  - id: min_cov
    type:
      - 'null'
      - int
    doc: print BED feature only if the coverage is bigger than (or equal to) MINCOV
    inputBinding:
      position: 102
      prefix: --min-cov
  - id: min_ctg_len
    type:
      - 'null'
      - int
    doc: Skip reference sequences (contigs) shorter than this value
    inputBinding:
      position: 102
      prefix: --min-ctg-len
  - id: min_len
    type:
      - 'null'
      - int
    doc: print BED feature only if its length is bigger (or equal to) than MINLELN
    inputBinding:
      position: 102
      prefix: --min-len
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: skip alignments whose mapping quality is less than MINQ
    inputBinding:
      position: 102
      prefix: --min-mapq
  - id: output_strands
    type:
      - 'null'
      - boolean
    doc: output coverage and stats separately for each strand
    inputBinding:
      position: 102
      prefix: --output-strands
  - id: physical_coverage
    type:
      - 'null'
      - boolean
    doc: compute physical coverage (needs paired alignments in input)
    inputBinding:
      position: 102
      prefix: --physical-coverage
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/covtobed:1.4.0--h077b44d_0
stdout: covtobed.out
