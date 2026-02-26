cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycistopic qc
label: pycistopic_qc
doc: "QC for scATAC-seq data.\n\nTool homepage: https://github.com/aertslab/pycistopic"
inputs:
  - id: dont_collapse_duplicates
    type:
      - 'null'
      - boolean
    doc: Don't collapse duplicate fragments (same chromosomal positions and 
      linked to the same cell barcode).
    default: false
    inputBinding:
      position: 101
      prefix: --dont-collapse_duplicates
  - id: fragments_tsv_filename
    type: File
    doc: Fragments TSV filename which contains scATAC fragments.
    inputBinding:
      position: 101
      prefix: --fragments
  - id: min_fragments_per_cb
    type:
      - 'null'
      - int
    doc: Minimum number of fragments needed per cell barcode to keep the 
      fragments for those cell barcodes.
    default: 10
    inputBinding:
      position: 101
      prefix: --min_fragments_per_cb
  - id: output_prefix
    type: string
    doc: Output prefix to use for QC statistics parquet output files.
    inputBinding:
      position: 101
      prefix: --output
  - id: regions_bed_filename
    type: File
    doc: Consensus peaks / SCREEN regions BED file. Used to calculate amount of 
      fragments in peaks.
    inputBinding:
      position: 101
      prefix: --regions
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use when calculating kernel-density estimate (KDE)
      to get probability density function (PDF) values for log10 unique 
      fragments in peaks vs TSS enrichment, fractions of fragments in peaks and 
      duplication ratio.
    default: 8
    inputBinding:
      position: 101
      prefix: --threads
  - id: tss_annotation_bed_filename
    type: File
    doc: TSS annotation BED file. Used to calculate distance of fragments to TSS
      positions.
    inputBinding:
      position: 101
      prefix: --tss
  - id: tss_flank_window
    type:
      - 'null'
      - int
    doc: Flanking window around the TSS. Used for intersecting fragments with 
      TSS positions and keeping cut sites.
    default: 2000
    inputBinding:
      position: 101
      prefix: --tss_flank_window
  - id: tss_min_norm
    type:
      - 'null'
      - float
    doc: Minimum normalization score. If the average minimum signal value is 
      below this value, this number is used to normalize the TSS signal. This 
      approach penalizes cells with fewer reads.
    default: 0.2
    inputBinding:
      position: 101
      prefix: --tss_min_norm
  - id: tss_minimum_signal_window
    type:
      - 'null'
      - int
    doc: Average signal in the tails of the flanking window around the TSS 
      ([-flank_window, -flank_window + minimum_signal_window + 1], [flank_window
      - minimum_signal_window + 1, flank_window]) is used to normalize the TSS 
      enrichment.
    default: 100
    inputBinding:
      position: 101
      prefix: --tss_minimum_signal_window
  - id: tss_smoothing_rolling_window
    type:
      - 'null'
      - int
    doc: Rolling window used to smooth the cut sites signal.
    default: 10
    inputBinding:
      position: 101
      prefix: --tss_smoothing_rolling_window
  - id: tss_window
    type:
      - 'null'
      - int
    doc: Window around the TSS used to count fragments in the TSS when 
      calculating the TSS enrichment per cell barcode.
    default: 50
    inputBinding:
      position: 101
      prefix: --tss_window
  - id: use_pyranges
    type:
      - 'null'
      - boolean
    doc: Use pyranges instead of genomic ranges implementation for calculating 
      intersections.
    inputBinding:
      position: 101
      prefix: --use-pyranges
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycistopic:2.0a--pyhdfd78af_0
stdout: pycistopic_qc.out
