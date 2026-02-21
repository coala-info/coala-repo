cwlVersion: v1.2
class: CommandLineTool
baseCommand: amplicon_classifier.py
label: ampliconclassifier_amplicon_classifier.py
doc: "Classify AA amplicon type\n\nTool homepage: https://github.com/jluebeck/AmpliconClassifier"
inputs:
  - id: add_chr_tag
    type:
      - 'null'
      - boolean
    doc: Add 'chr' to the beginning of chromosome names in input files.
    inputBinding:
      position: 101
      prefix: --add_chr_tag
  - id: cycles
    type:
      - 'null'
      - File
    doc: AA-formatted cycles file
    inputBinding:
      position: 101
      prefix: --cycles
  - id: decomposition_strictness
    type:
      - 'null'
      - float
    doc: Value between 0 and 1 reflecting how strictly to filter low CN decompositions
      (default = 0.1). Higher values filter more of the low-weight decompositions.
    default: 0.1
    inputBinding:
      position: 101
      prefix: --decomposition_strictness
  - id: exclude_bed
    type:
      - 'null'
      - File
    doc: List of regions in which to ignore classification.
    inputBinding:
      position: 101
      prefix: --exclude_bed
  - id: filter_similar
    type:
      - 'null'
      - boolean
    doc: Only use if all samples are of independent origins (not replicates and not
      multi-region biopsies). Permits filtering of false-positive amps arising in
      multiple independent samples based on similarity calculation
    inputBinding:
      position: 101
      prefix: --filter_similar
  - id: force
    type:
      - 'null'
      - boolean
    doc: Disable No amp/Invalid class if possible
    inputBinding:
      position: 101
      prefix: --force
  - id: graph
    type:
      - 'null'
      - File
    doc: AA-formatted graph file
    inputBinding:
      position: 101
      prefix: --graph
  - id: input
    type:
      - 'null'
      - File
    doc: 'Path to list of files to use. Each line formatted as: sample_name cycles.txt
      graph.txt. Give this argument if not using -c and -g.'
    inputBinding:
      position: 101
      prefix: --input
  - id: min_flow
    type:
      - 'null'
      - float
    doc: Minimum flow to consider among decomposed paths (1.0).
    default: 1.0
    inputBinding:
      position: 101
      prefix: --min_flow
  - id: min_size
    type:
      - 'null'
      - int
    doc: Minimum cycle size (in bp) to consider as valid amplicon (5000).
    default: 5000
    inputBinding:
      position: 101
      prefix: --min_size
  - id: no_lc_filter
    type:
      - 'null'
      - boolean
    doc: Do not filter low-complexity cycles. Not recommended to set this flag.
    inputBinding:
      position: 101
      prefix: --no_LC_filter
  - id: plotstyle
    type:
      - 'null'
      - string
    doc: Type of visualizations to produce (grouped, individual, noplot).
    inputBinding:
      position: 101
      prefix: --plotstyle
  - id: ref
    type: string
    doc: Reference genome name used for alignment, one of hg19, GRCh37, hg38, GRCh38,
      GRCh38_viral, mm10, GRCm38.
    inputBinding:
      position: 101
      prefix: --ref
  - id: report_complexity
    type:
      - 'null'
      - boolean
    doc: Compute a measure of amplicon entropy for each amplicon.
    inputBinding:
      position: 101
      prefix: --report_complexity
  - id: verbose_classification
    type:
      - 'null'
      - boolean
    doc: Generate verbose output with raw classification scores.
    inputBinding:
      position: 101
      prefix: --verbose_classification
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Output filename prefix
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ampliconclassifier:0.4.14--hdfd78af_0
