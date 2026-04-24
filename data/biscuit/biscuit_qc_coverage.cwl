cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biscuit
  - qc_coverage
label: biscuit_qc_coverage
doc: "BISCUIT QC coverage tool for calculating coverage statistics from BAM files.\n
  \nTool homepage: https://github.com/huishenlab/biscuit"
inputs:
  - id: reference_fasta
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 1
  - id: cpgs_bed
    type: File
    doc: CpGs BED file (gzipped)
    inputBinding:
      position: 2
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 3
  - id: bottom_gc_bed
    type:
      - 'null'
      - File
    doc: Bottom 10 percent GC content windows BED file
    inputBinding:
      position: 104
      prefix: -B
  - id: max_cytosine_retention
    type:
      - 'null'
      - int
    doc: Max cytosine retention in a read
    inputBinding:
      position: 104
      prefix: -t
  - id: max_nm_tag
    type:
      - 'null'
      - int
    doc: Maximum NM tag
    inputBinding:
      position: 104
      prefix: -n
  - id: min_alignment_score
    type:
      - 'null'
      - int
    doc: Minimum alignment score (from AS-tag)
    inputBinding:
      position: 104
      prefix: -a
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality
    inputBinding:
      position: 104
      prefix: -b
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimum read length
    inputBinding:
      position: 104
      prefix: -l
  - id: no_filter_duplicates
    type:
      - 'null'
      - boolean
    doc: NO filtering of duplicate reads
    inputBinding:
      position: 104
      prefix: -u
  - id: no_filter_improper_pair
    type:
      - 'null'
      - boolean
    doc: NO filtering of improper pair
    inputBinding:
      position: 104
      prefix: -p
  - id: step_size
    type:
      - 'null'
      - int
    doc: Step size of windows
    inputBinding:
      position: 104
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 104
      prefix: -@
  - id: top_gc_bed
    type:
      - 'null'
      - File
    doc: Top 10 percent GC content windows BED file
    inputBinding:
      position: 104
      prefix: -T
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix for output file names
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biscuit:1.7.1.20250908--hc4b60c0_0
