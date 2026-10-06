cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
  - assessSoftClipping
label: atlas_assesssoftclipping
doc: "Assessing the level of soft clipping in a BAM file.\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas"
inputs:
  - id: bam
    type: File
    doc: "Input BAM file."
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 1
      prefix: --bam
  - id: keep_reads_without_rg
    type:
      - 'null'
      - boolean
    doc: "Keep reads without a read group (by default ATLAS filters them out)."
    inputBinding:
      position: 1
      prefix: --keepReadsWithoutRG
  - id: fasta
    type:
      - 'null'
      - File
    doc: "Reference genome FASTA (with .fai index)."
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 1
      prefix: --fasta
  - id: write_reads
    type:
      - 'null'
      - boolean
    doc: "Also write per-read soft clipping statistics to <out>_softClippingStats.txt.gz."
    inputBinding:
      position: 1
      prefix: --writeReads
  - id: print_sequences
    type:
      - 'null'
      - boolean
    doc: "Also print the sequences (with --writeReads)."
    inputBinding:
      position: 1
      prefix: --printSequences
  - id: print_all
    type:
      - 'null'
      - boolean
    doc: "Write statistics for all reads (with --writeReads)."
    inputBinding:
      position: 1
      prefix: --printAll
  - id: filter_mq
    type:
      - 'null'
      - string
    doc: "Keep reads with mapping quality in this range, e.g. \"[30,256]\"."
    inputBinding:
      position: 1
      prefix: --filterMQ
  - id: chr
    type:
      - 'null'
      - string
    doc: "Comma-separated list of chromosomes to use."
    inputBinding:
      position: 1
      prefix: --chr
  - id: out_prefix
    type: string
    doc: "Prefix for all output files (ATLAS --out)."
    default: "atlas_assessSoftClipping"
    inputBinding:
      position: 1
      prefix: --out
outputs:
  - id: log
    type: stdout
    doc: ATLAS progress report (standard output).
  - id: soft_clipping_both
    type: File
    doc: "Distribution of soft clipping on both sides combined."
    outputBinding:
      glob: $(inputs.out_prefix)_softClippingMatrixBoth.txt
  - id: soft_clipping_left
    type: File
    doc: "Distribution of soft clipping on the left side."
    outputBinding:
      glob: $(inputs.out_prefix)_softClippingMatrixLeft.txt
  - id: soft_clipping_right
    type: File
    doc: "Distribution of soft clipping on the right side."
    outputBinding:
      glob: $(inputs.out_prefix)_softClippingMatrixRight.txt
  - id: soft_clipping_stats
    type:
      - 'null'
      - File
    doc: "Per-read soft clipping statistics (with --writeReads)."
    outputBinding:
      glob: $(inputs.out_prefix)_softClippingStats.txt.gz
  - id: parameters
    type:
      - 'null'
      - File
    doc: "Parameters used for the run."
    outputBinding:
      glob: $(inputs.out_prefix).parameters
  - id: filter_summary
    type:
      - 'null'
      - File
    doc: "Counts of reads removed by each filter."
    outputBinding:
      glob: $(inputs.out_prefix)_filterSummary.txt
  - id: rg_info
    type:
      - 'null'
      - File
    doc: "Read group information."
    outputBinding:
      glob: $(inputs.out_prefix)_RGInfo.json
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas:2.0.1--hadca570_0
stdout: atlas_assesssoftclipping.log
