cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - cnv
label: bcftools_cnv
doc: "Copy number variation caller, requires Illumina's B-allele frequency (BAF) and
  Log R Ratio intensity (LRR). The HMM considers the following copy number states:
  CN 2 (normal), 1 (single-copy loss), 0 (complete loss), 3 (single-copy gain)\n\n\
  Tool homepage: https://github.com/samtools/bcftools"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: aberrant
    type:
      - 'null'
      - string
    doc: Fraction of aberrant cells in query and control
    default: 1.0,1.0
    inputBinding:
      position: 102
      prefix: --aberrant
  - id: af_file
    type:
      - 'null'
      - File
    doc: Read allele frequencies from file (CHR\tPOS\tREF,ALT\tAF)
    inputBinding:
      position: 102
      prefix: --AF-file
  - id: baf_dev
    type:
      - 'null'
      - string
    doc: Expected BAF deviation in query and control
    default: 0.04,0.04
    inputBinding:
      position: 102
      prefix: --BAF-dev
  - id: baf_weight
    type:
      - 'null'
      - float
    doc: Relative contribution from BAF
    default: 1
    inputBinding:
      position: 102
      prefix: --BAF-weight
  - id: control_sample
    type:
      - 'null'
      - string
    doc: Optional control sample name to highlight differences
    inputBinding:
      position: 102
      prefix: --control-sample
  - id: err_prob
    type:
      - 'null'
      - float
    doc: Uniform error probability
    default: 0.0001
    inputBinding:
      position: 102
      prefix: --err-prob
  - id: lrr_dev
    type:
      - 'null'
      - string
    doc: Expected LRR deviation
    default: 0.2,0.2
    inputBinding:
      position: 102
      prefix: --LRR-dev
  - id: lrr_smooth_win
    type:
      - 'null'
      - int
    doc: Window of LRR moving average smoothing
    default: 10
    inputBinding:
      position: 102
      prefix: --LRR-smooth-win
  - id: lrr_weight
    type:
      - 'null'
      - float
    doc: Relative contribution from LRR
    default: 0.2
    inputBinding:
      position: 102
      prefix: --LRR-weight
  - id: optimize
    type:
      - 'null'
      - float
    doc: Estimate fraction of aberrant cells down to FLOAT
    default: 1.0
    inputBinding:
      position: 102
      prefix: --optimize
  - id: plot_threshold
    type:
      - 'null'
      - float
    doc: Plot aberrant chromosomes with quality at least FLOAT
    inputBinding:
      position: 102
      prefix: --plot-threshold
  - id: query_sample
    type:
      - 'null'
      - string
    doc: Query samply name
    inputBinding:
      position: 102
      prefix: --query-sample
  - id: regions
    type:
      - 'null'
      - string
    doc: Restrict to comma-separated list of regions
    inputBinding:
      position: 102
      prefix: --regions
  - id: regions_file
    type:
      - 'null'
      - File
    doc: Restrict to regions listed in a file
    inputBinding:
      position: 102
      prefix: --regions-file
  - id: regions_overlap
    type:
      - 'null'
      - int
    doc: Include if POS in the region (0), record overlaps (1), variant overlaps
      (2)
    default: 1
    inputBinding:
      position: 102
      prefix: --regions-overlap
  - id: same_prob
    type:
      - 'null'
      - float
    doc: Prior probability of -s/-c being the same
    default: 0.5
    inputBinding:
      position: 102
      prefix: --same-prob
  - id: targets
    type:
      - 'null'
      - string
    doc: Similar to -r but streams rather than index-jumps
    inputBinding:
      position: 102
      prefix: --targets
  - id: targets_file
    type:
      - 'null'
      - File
    doc: Similar to -R but streams rather than index-jumps
    inputBinding:
      position: 102
      prefix: --targets-file
  - id: targets_overlap
    type:
      - 'null'
      - int
    doc: Include if POS in the region (0), record overlaps (1), variant overlaps
      (2)
    default: 0
    inputBinding:
      position: 102
      prefix: --targets-overlap
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Verbosity level
    inputBinding:
      position: 102
      prefix: --verbosity
  - id: xy_prob
    type:
      - 'null'
      - float
    doc: P(x|y) transition probability
    default: 1e-09
    inputBinding:
      position: 102
      prefix: --xy-prob
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory path
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
