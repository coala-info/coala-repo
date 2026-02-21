cwlVersion: v1.2
class: CommandLineTool
baseCommand: panfeed-plot
label: panfeed_panfeed-plot
doc: "Plot association results from panfeed\n\nTool homepage: https://github.com/microbial-pangenomes-lab/panfeed"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: Opacity for non-passing k-mers (between 0 and 1, 0 indicates full transparency)
    default: 0.0
    inputBinding:
      position: 101
      prefix: --alpha
  - id: column
    type:
      - 'null'
      - string
    doc: P-value column in the associations file
    default: lrt-pvalue
    inputBinding:
      position: 101
      prefix: --column
  - id: dpi
    type:
      - 'null'
      - int
    doc: Output resolution (DPI)
    default: 300
    inputBinding:
      position: 101
      prefix: --dpi
  - id: format
    type:
      - 'null'
      - string
    doc: Output format for plots (png, tiff, pdf, or svg)
    default: png
    inputBinding:
      position: 101
      prefix: --format
  - id: height
    type:
      - 'null'
      - float
    doc: Figure height (inches)
    default: 9.0
    inputBinding:
      position: 101
      prefix: --height
  - id: kmers
    type: File
    doc: TSV file containing the output of panfeed-get-kmers
    inputBinding:
      position: 101
      prefix: --kmers
  - id: minimum_pvalue
    type:
      - 'null'
      - float
    doc: Minimum p-value for color and transparency
    default: 1e-10
    inputBinding:
      position: 101
      prefix: --minimum-pvalue
  - id: nucleotides
    type:
      - 'null'
      - boolean
    doc: 'Draw nucleotide sequence on all plots (WARNING: only makes sense if few
      samples and positions are considered)'
    inputBinding:
      position: 101
      prefix: --nucleotides
  - id: phenotype
    type: File
    doc: Phenotype file in TSV format, used to list all strains
    inputBinding:
      position: 101
      prefix: --phenotype
  - id: phenotype_column
    type:
      - 'null'
      - string
    doc: Column in phenotype TSV file for sorting (default is sorting by p-values)
    inputBinding:
      position: 101
      prefix: --phenotype-column
  - id: sample
    type:
      - 'null'
      - float
    doc: Only show a randomly picked set of sample (a value between 0 and 1 indicating
      the proportion to show, default all)
    inputBinding:
      position: 101
      prefix: --sample
  - id: start
    type:
      - 'null'
      - int
    doc: Relative position to start the plots (default all available positions)
    inputBinding:
      position: 101
      prefix: --start
  - id: stop
    type:
      - 'null'
      - int
    doc: Relative position to end the plots (default all available positions)
    inputBinding:
      position: 101
      prefix: --stop
  - id: threshold
    type:
      - 'null'
      - float
    doc: Association p-value threshold
    default: 1.0
    inputBinding:
      position: 101
      prefix: --threshold
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity level
    inputBinding:
      position: 101
      prefix: -v
  - id: width
    type:
      - 'null'
      - float
    doc: Figure width (inches)
    default: 10.0
    inputBinding:
      position: 101
      prefix: --width
  - id: xticks
    type:
      - 'null'
      - int
    doc: Spacing for ticks on x axis
    default: 200
    inputBinding:
      position: 101
      prefix: --xticks
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory for the plots
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panfeed:1.7.2--pyhdfd78af_0
