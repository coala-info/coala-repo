cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - diagram
label: cnvkit_diagram
doc: "Draw copy number (log2 coverages, segments) on chromosomes as a diagram. If both the raw probes and segments are given, show them side-by-side on each chromosome (segments on the left side, probes on the right side).\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: filename
    type:
      - 'null'
      - File
    doc: "Processed coverage data file (*.cnr), the output of the 'fix' sub-command."
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
    doc: "Chromosome to display, e.g. 'chr1' (no chromosomal range allowed)"
    inputBinding:
      position: 101
      prefix: --chromosome
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Copy number change threshold to label genes. [Default: 0.5]"
    inputBinding:
      position: 101
      prefix: --threshold
  - id: min_probes
    type:
      - 'null'
      - int
    doc: "Minimum number of covered probes to label a gene. [Default: %(default)d]"
    inputBinding:
      position: 101
      prefix: --min-probes
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
    doc: "Specify the sample's chromosomal sex as male or female. (Otherwise guessed from X and Y coverage). (choices: m, y, male, Male, f, x, female, Female)"
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
  - id: title
    type:
      - 'null'
      - string
    doc: "Plot title. [Default: sample ID, from filename or -i]"
    inputBinding:
      position: 101
      prefix: --title
  - id: no_gene_labels
    type:
      - 'null'
      - boolean
    doc: "Disable gene_name labels on plot (useful when a lot of CNV were called)."
    inputBinding:
      position: 101
      prefix: --no-gene-labels
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
