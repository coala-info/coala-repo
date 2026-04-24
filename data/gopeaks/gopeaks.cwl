cwlVersion: v1.2
class: CommandLineTool
baseCommand: GoPeaks
label: gopeaks
doc: "GoPeaks is a peak caller designed for CUT&TAG/CUT&RUN sequencing\ndata. GoPeaks
  by default works best with narrow peaks such as\nH3K4me3 and transcription factors.
  GoPeaks can be used with the\n\"--broad\" flag to call broad peaks like H3K27Ac/H3K4me1.
  We\nencourage users to explore the parameters of GoPeaks to analyze\ntheir data.\n\
  \nTool homepage: https://github.com/maxsonBraunLab/gopeaks"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM file (must be paired-end reads)
    inputBinding:
      position: 101
      prefix: --bam
  - id: broad_peak_calling
    type:
      - 'null'
      - boolean
    doc: Run GoPeaks on broad marks (--step 5000 & --slide 1000)
    inputBinding:
      position: 101
      prefix: --broad
  - id: chromsize_file
    type:
      - 'null'
      - File
    doc: Chromosome sizes for the genome if not found in the bam header
    inputBinding:
      position: 101
      prefix: --chromsize
  - id: control_bam_file
    type:
      - 'null'
      - File
    doc: Input BAM file with control signal to be normalized (e.g. IgG, Input)
    inputBinding:
      position: 101
      prefix: --control
  - id: merge_distance
    type:
      - 'null'
      - int
    doc: Merge peaks within <mdist> base pairs.
    inputBinding:
      position: 101
      prefix: --mdist
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Test genome bins with at least <minreads> read pairs..
    inputBinding:
      position: 101
      prefix: --minreads
  - id: min_width
    type:
      - 'null'
      - int
    doc: Minimum width (bp) of a peak.
    inputBinding:
      position: 101
      prefix: --minwidth
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix to write peaks and metrics file.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: p_value
    type:
      - 'null'
      - float
    doc: Define significance threshold <pval> with multiple hypothesis 
      correction via Benjamini-Hochberg.
    inputBinding:
      position: 101
      prefix: --pval
  - id: slide
    type:
      - 'null'
      - int
    doc: Slide size for coverage bins.
    inputBinding:
      position: 101
      prefix: --slide
  - id: step
    type:
      - 'null'
      - int
    doc: Bin size for coverage bins.
    inputBinding:
      position: 101
      prefix: --step
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Run GoPeaks in verbose mode.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gopeaks:1.0.0--h047eeb3_3
stdout: gopeaks.out
