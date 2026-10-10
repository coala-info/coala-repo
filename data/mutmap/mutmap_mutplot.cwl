cwlVersion: v1.2
class: CommandLineTool
baseCommand: mutplot
label: mutmap_mutplot
doc: "MutPlot: calculate SNP-index from a VCF file of cultivar and mutant bulk, and plot it.\n\nTool homepage: https://github.com/YuSugihara/MutMap"
inputs:
  - id: vcf
    type: File
    doc: "VCF file which contains cultivar and mutant bulk, in this order. This VCF file must have the AD field"
    inputBinding:
      position: 101
      prefix: --vcf
  - id: out
    type: string
    doc: Output directory. The specified directory can already exist
    inputBinding:
      position: 101
      prefix: --out
  - id: n_bulk
    type: int
    doc: Number of individuals in the mutant bulk
    inputBinding:
      position: 101
      prefix: --N-bulk
  - id: window
    type:
      - 'null'
      - int
    doc: Window size in kilobases (kb) (default 2000)
    inputBinding:
      position: 101
      prefix: --window
  - id: step
    type:
      - 'null'
      - int
    doc: Step size in kilobases (kb) (default 100)
    inputBinding:
      position: 101
      prefix: --step
  - id: max_depth
    type:
      - 'null'
      - int
    doc: "Maximum depth of variants to be used, for the cultivar and the bulk (default 250)"
    inputBinding:
      position: 101
      prefix: --max-depth
  - id: min_depth
    type:
      - 'null'
      - int
    doc: "Minimum depth of variants to be used, for the cultivar and the bulk (default 8)"
    inputBinding:
      position: 101
      prefix: --min-depth
  - id: n_rep
    type:
      - 'null'
      - int
    doc: Number of replicates for simulations to generate the null distribution (default 5000)
    inputBinding:
      position: 101
      prefix: --N-rep
  - id: min_snpindex
    type:
      - 'null'
      - float
    doc: Cutoff of minimum SNP-index for clear results (default 0.3)
    inputBinding:
      position: 101
      prefix: --min-SNPindex
  - id: strand_bias
    type:
      - 'null'
      - int
    doc: Filter out spurious homozygous genotypes in the cultivar based on strand bias; 0 disables the filter (default 7)
    inputBinding:
      position: 101
      prefix: --strand-bias
  - id: snpeff
    type:
      - 'null'
      - string
    doc: Predict causal variants using SnpEff (SnpEff database name)
    inputBinding:
      position: 101
      prefix: --snpEff
  - id: igv
    type:
      - 'null'
      - boolean
    doc: Output IGV format file to check results on IGV
    inputBinding:
      position: 101
      prefix: --igv
  - id: indel
    type:
      - 'null'
      - boolean
    doc: Plot SNP-index with INDEL
    inputBinding:
      position: 101
      prefix: --indel
  - id: line_colors
    type:
      - 'null'
      - string
    doc: "Colors for threshold lines in plots, comma-separated: SNP-index, p95, p99"
    inputBinding:
      position: 101
      prefix: --line-colors
  - id: dot_color
    type:
      - 'null'
      - string
    doc: Color of the dots in plots
    inputBinding:
      position: 101
      prefix: --dot-color
  - id: fig_width
    type:
      - 'null'
      - float
    doc: Width allocated in chromosome figure (default 7.5)
    inputBinding:
      position: 101
      prefix: --fig-width
  - id: fig_height
    type:
      - 'null'
      - float
    doc: Height allocated in chromosome figure (default 4.0)
    inputBinding:
      position: 101
      prefix: --fig-height
  - id: white_space
    type:
      - 'null'
      - float
    doc: "White space between figures, vertical direction only (default 0.6)"
    inputBinding:
      position: 101
      prefix: --white-space
  - id: format
    type:
      - 'null'
      - string
    doc: "Format of the output image: eps, jpeg, jpg, pdf, pgf, png, rgba, svg, svgz, tif or tiff"
    inputBinding:
      position: 101
      prefix: --format
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: "$(inputs.out)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mutmap:2.3.9--pyhdfd78af_0
