cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngsderive endedness
label: ngsderive_endedness
doc: "Derive the endedness of Next-Generation Sequencing files.\n\nTool homepage:
  https://github.com/claymcleod/ngsderive"
inputs:
  - id: ngsfiles
    type:
      type: array
      items: File
    doc: Next-generation sequencing files to process (BAM or FASTQ).
    inputBinding:
      position: 1
  - id: calc_rpt
    type:
      - 'null'
      - boolean
    doc: Calculate and output Reads-Per-Template. This will produce a more 
      sophisticated estimate for endedness, but uses substantially more memory 
      (can reach up to 60-70% of BAM size in memory consumption).
    default: false
    inputBinding:
      position: 102
      prefix: --calc-rpt
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable DEBUG log level.
    default: false
    inputBinding:
      position: 102
      prefix: --debug
  - id: n_reads
    type:
      - 'null'
      - int
    doc: How many reads to analyze from the start of the file. Any n < 1 to 
      parse whole file.
    default: -1
    inputBinding:
      position: 102
      prefix: --n-reads
  - id: no_split_by_rg
    type:
      - 'null'
      - boolean
    doc: Disable splitting by read group.
    inputBinding:
      position: 102
      prefix: --no-split-by-rg
  - id: paired_deviance
    type:
      - 'null'
      - float
    doc: Distance from 0.5 split between number of f+l- reads and f-l+ reads 
      allowed to be called 'Paired-End'. Default of `0.0` only appropriate if 
      the whole file is being processed.
    default: 0.0
    inputBinding:
      position: 102
      prefix: --paired-deviance
  - id: round_rpt
    type:
      - 'null'
      - boolean
    doc: Round RPT to the nearest INT before comparing to expected values. 
      Appropriate if using `-n` > 0.
    default: false
    inputBinding:
      position: 102
      prefix: --round-rpt
  - id: split_by_rg
    type:
      - 'null'
      - boolean
    doc: Contain one entry per read group.
    default: true
    inputBinding:
      position: 102
      prefix: --split-by-rg
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable INFO log level.
    default: false
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Write to filename rather than standard out.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsderive:4.0.0--pyhdfd78af_0
