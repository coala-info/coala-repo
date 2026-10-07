cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - heatmap
label: cnvkit_heatmap
doc: "Plot copy number for multiple samples as a heatmap.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: filenames
    type:
      type: array
      items: File
    doc: "Sample coverages as raw probes (.cnr) or segments (.cns)."
    inputBinding:
      position: 1
  - id: chromosome
    type:
      - 'null'
      - string
    doc: "Chromosome (e.g. 'chr1') or chromosomal range (e.g. 'chr1:2333000-2444000') to display. If a range is given, all targeted genes in this range will be shown, unless '--gene'/'-g' is already given."
    inputBinding:
      position: 101
      prefix: --chromosome
  - id: male_reference
    type:
      - 'null'
      - boolean
    doc: "Assume inputs were normalized to a male reference (i.e. female samples will have +1 log-CNR of chrX; otherwise male samples would have -1 chrX)."
    inputBinding:
      position: 101
      prefix: --male-reference
  - id: sample_sex
    type:
      - 'null'
      - string
    doc: "Specify the chromosomal sex of all given samples as male or female. [Default: guess each sample from coverage of X and Y chromosomes]. (choices: m, y, male, Male, f, x, female, Female)"
    inputBinding:
      position: 101
      prefix: --sample-sex
  - id: no_shift_xy
    type:
      - 'null'
      - boolean
    doc: "Don't adjust the X and Y chromosomes according to sample sex."
    inputBinding:
      position: 101
      prefix: --no-shift-xy
  - id: output
    type: string
    doc: "Output PDF file name."
    inputBinding:
      position: 101
      prefix: --output
  - id: by_bin
    type:
      - 'null'
      - boolean
    doc: "Plot data x-coordinates by bin indices instead of genomic coordinates. All bins will be shown with equal width, no blank regions will be shown, and x-axis values indicate bin number (within chromosome) instead of genomic position."
    inputBinding:
      position: 101
      prefix: --by-bin
  - id: desaturate
    type:
      - 'null'
      - boolean
    doc: "Tweak color saturation to focus on significant changes."
    inputBinding:
      position: 101
      prefix: --desaturate
  - id: vertical
    type:
      - 'null'
      - boolean
    doc: "Plot heatmap with samples as X-axis (instead of Y-axis)."
    inputBinding:
      position: 101
      prefix: --vertical
  - id: delimit_samples
    type:
      - 'null'
      - boolean
    doc: "Add an horizontal delimitation line between each sample."
    inputBinding:
      position: 101
      prefix: --delimit-samples
  - id: title
    type:
      - 'null'
      - string
    doc: "Plot title. [Default: Range if provided, otherwise none]"
    inputBinding:
      position: 101
      prefix: --title
  - id: diploid_parx_genome
    type:
      - 'null'
      - string
    doc: "Considers the given human genome's PAR of chromosome X as autosomal. Example: 'grch38'"
    inputBinding:
      position: 101
      prefix: --diploid-parx-genome
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
