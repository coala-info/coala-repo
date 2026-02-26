cwlVersion: v1.2
class: CommandLineTool
baseCommand: chips learn
label: chips_learn
doc: "Learn parameters from a ChIP dataset.\n\nTool homepage: https://github.com/gymreklab/chips"
inputs:
  - id: absolute_threshold
    type:
      - 'null'
      - float
    doc: Absolute threshold for peak scores. Only consider peaks with at least 
      this score. ChIPs applies `--thres` or `--thres-scale` whichever is 
      stricter.
    default: 100.0
    inputBinding:
      position: 101
      prefix: --thres
  - id: bed_column_index
    type: int
    doc: The index of the BED file column used to score each peak (index 
      starting from 1)
    inputBinding:
      position: 101
      prefix: -c
  - id: estimated_fragment_length
    type:
      - 'null'
      - int
    doc: The estimated fragment length. Please set this number as the loose 
      upper-bound of your estimated fragment length. This can result in more 
      robust estimates especially for data with narrow peaks.
    default: 300
    inputBinding:
      position: 101
      prefix: --est
  - id: high_score_peak_ratio
    type:
      - 'null'
      - float
    doc: Ratio of high score peaks to ignore
    default: 0.0
    inputBinding:
      position: 101
      prefix: -r
  - id: load_paired_end_reads
    type:
      - 'null'
      - boolean
    doc: Loading paired-end reads
    default: false
    inputBinding:
      position: 101
      prefix: --paired
  - id: noscale
    type:
      - 'null'
      - boolean
    doc: Don't scale peak scores by the max score.
    default: false
    inputBinding:
      position: 101
      prefix: --noscale
  - id: outprefix
    type: string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: -o
  - id: peakfile_type
    type: string
    doc: File type of the input peak file. Only `homer` or `bed` supported.
    inputBinding:
      position: 101
      prefix: -t
  - id: peaks_bed
    type: File
    doc: BED file with peak regions (Homer format or BED format)
    inputBinding:
      position: 101
      prefix: -p
  - id: reads_bam
    type: File
    doc: BAM file with ChIP reads (.bai index required)
    inputBinding:
      position: 101
      prefix: -b
  - id: region
    type:
      - 'null'
      - string
    doc: Only consider peaks from this region chrom:start-end
    default: genome-wide
    inputBinding:
      position: 101
      prefix: --region
  - id: scale_outliers
    type:
      - 'null'
      - boolean
    doc: Set all peaks with scores >2*median score to have binding prob 1. 
      Recommended with real data.
    default: false
    inputBinding:
      position: 101
      prefix: --scale-outliers
  - id: scaled_threshold
    type:
      - 'null'
      - float
    doc: Scale threshold for peak scores. Only consider peaks with at least this
      score. after scaling scores to be between 0-1. ChIPs applies `--thres` or 
      `--thres-scale` whichever is stricter.
    default: 0.0
    inputBinding:
      position: 101
      prefix: --thres-scale
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chips:2.4--h43eeafb_7
stdout: chips_learn.out
