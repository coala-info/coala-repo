cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - scatter
label: cnvkit_scatter
doc: "Plot probe log2 coverages and segmentation calls together.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: filename
    type:
      - 'null'
      - File
    doc: "Processed bin-level copy ratios (*.cnr), the output of the 'fix' sub-command."
    inputBinding:
      position: 1
  - id: segment
    type:
      - 'null'
      - File
    doc: "Segmentation calls (.cns), the output of the 'segment' command."
    inputBinding:
      position: 101
      prefix: --segment
  - id: chromosome
    type:
      - 'null'
      - string
    doc: "Chromosome or chromosomal range, e.g. 'chr1' or 'chr1:2333000-2444000', to display. If a range is given, all targeted genes in this range will be shown, unless -g/--gene is also given."
    inputBinding:
      position: 101
      prefix: --chromosome
  - id: gene
    type:
      - 'null'
      - string
    doc: "Name of gene or genes (comma-separated) to display."
    inputBinding:
      position: 101
      prefix: --gene
  - id: range_list
    type:
      - 'null'
      - File
    doc: "File listing the chromosomal ranges to display, as BED, interval list or 'chr:start-end' text. Creates focal plots similar to -c/--chromosome for each listed region, combined into a multi-page PDF. The output filename must also be specified (-o/--output)."
    inputBinding:
      position: 101
      prefix: --range-list
  - id: width
    type:
      - 'null'
      - float
    doc: "Width of margin to show around the selected gene(s) (-g/--gene) or small chromosomal region (-c/--chromosome). [Default: %(default)d]"
    inputBinding:
      position: 101
      prefix: --width
  - id: output
    type: string
    doc: "Output PDF file name."
    inputBinding:
      position: 101
      prefix: --output
  - id: antitarget_marker
    type:
      - 'null'
      - string
    doc: "Plot antitargets using this symbol when plotting in a selected chromosomal region (-g/--gene or -c/--chromosome). [Default: same as targets]"
    inputBinding:
      position: 101
      prefix: --antitarget-marker
  - id: by_bin
    type:
      - 'null'
      - boolean
    doc: "Plot data x-coordinates by bin indices instead of genomic coordinates. All bins will be shown with equal width, no blank regions will be shown, and x-axis values indicate bin number (within chromosome) instead of genomic position."
    inputBinding:
      position: 101
      prefix: --by-bin
  - id: segment_color
    type:
      - 'null'
      - string
    doc: "Plot segment lines in this color. Value can be any string accepted by matplotlib, e.g. 'red' or '#CC0000'."
    inputBinding:
      position: 101
      prefix: --segment-color
  - id: title
    type:
      - 'null'
      - string
    doc: "Plot title. [Default: sample ID, from filename or -i]"
    inputBinding:
      position: 101
      prefix: --title
  - id: trend
    type:
      - 'null'
      - boolean
    doc: "Draw a smoothed local trendline on the scatter plot."
    inputBinding:
      position: 101
      prefix: --trend
  - id: y_max
    type:
      - 'null'
      - float
    doc: "y-axis upper limit."
    inputBinding:
      position: 101
      prefix: --y-max
  - id: y_min
    type:
      - 'null'
      - float
    doc: "y-axis lower limit."
    inputBinding:
      position: 101
      prefix: --y-min
  - id: fig_size
    type:
      - 'null'
      - type: array
        items: float
    doc: "Width and height of the plot in inches. [Default: Pre-defined in Matplotlib 'rcParams' variable (most of the time: '6.4 4.8')]"
    inputBinding:
      position: 101
      prefix: --fig-size
  - id: vcf
    type:
      - 'null'
      - File
    doc: "VCF file name containing variants to plot for SNV b-allele frequencies."
    inputBinding:
      position: 101
      prefix: --vcf
  - id: sample_id
    type:
      - 'null'
      - string
    doc: "Name of the sample in the VCF to use for b-allele frequency extraction and as the default plot title."
    inputBinding:
      position: 101
      prefix: --sample-id
  - id: normal_id
    type:
      - 'null'
      - string
    doc: "Corresponding normal sample ID in the input VCF. This sample is used to select only germline SNVs to plot."
    inputBinding:
      position: 101
      prefix: --normal-id
  - id: min_variant_depth
    type:
      - 'null'
      - int
    doc: "Minimum read depth for a SNV to be used in the b-allele frequency calculation. [Default: 20]"
    inputBinding:
      position: 101
      prefix: --min-variant-depth
  - id: zygosity_freq
    type:
      - 'null'
      - float
    doc: "Ignore VCF's genotypes (GT field) and instead infer zygosity from allele frequencies. [Default if used without a number: %(const)s]"
    inputBinding:
      position: 101
      prefix: --zygosity-freq
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: "Output PDF file name."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
