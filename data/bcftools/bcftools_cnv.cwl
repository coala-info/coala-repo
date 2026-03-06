cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- bcftools
- cnv
label: bcftools_cnv
doc: "Copy number variation caller, requires Illumina's B-allele frequency (BAF) and
  Log R Ratio intensity (LRR). The HMM considers the following copy number states:
  CN 2 (normal), 1 (single-copy loss), 0 (complete loss), 3 (single-copy gain)"
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bcftools:1.23--h3a4d415_0
inputs:
- id: input_vcf
  type: File
  doc: Input VCF file
  inputBinding:
    position: 1
- id: aberrant
  type:
  - 'null'
  - type: array
    items: float
  doc: Fraction of aberrant cells in query and control
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
  - type: array
    items: float
  doc: Expected BAF deviation in query and control
  inputBinding:
    position: 102
    prefix: --BAF-dev
- id: baf_weight
  type:
  - 'null'
  - float
  doc: Relative contribution from BAF
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
  inputBinding:
    position: 102
    prefix: --err-prob
- id: lrr_dev
  type:
  - 'null'
  - type: array
    items: float
  doc: Expected LRR deviation
  inputBinding:
    position: 102
    prefix: --LRR-dev
- id: lrr_smooth_win
  type:
  - 'null'
  - int
  doc: Window of LRR moving average smoothing
  inputBinding:
    position: 102
    prefix: --LRR-smooth-win
- id: lrr_weight
  type:
  - 'null'
  - float
  doc: Relative contribution from LRR
  inputBinding:
    position: 102
    prefix: --LRR-weight
- id: optimize
  type:
  - 'null'
  - float
  doc: Estimate fraction of aberrant cells down to FLOAT
  inputBinding:
    position: 102
    prefix: --optimize
- id: output_dir
  type: string
  doc: Output directory path
  inputBinding:
    position: 102
    prefix: --output-dir
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
  inputBinding:
    position: 102
    prefix: --regions-overlap
- id: same_prob
  type:
  - 'null'
  - float
  doc: Prior probability of -s/-c being the same
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
  inputBinding:
    position: 102
    prefix: --targets-overlap
- id: xy_prob
  type:
  - 'null'
  - float
  doc: P(x|y) transition probability
  inputBinding:
    position: 102
    prefix: --xy-prob
outputs:
- id: output_output_dir
  type: Directory
  doc: Output directory path
  outputBinding:
    glob: $(inputs.output_dir)
$namespaces:
  s: https://schema.org/
s:url: https://github.com/samtools/bcftools
