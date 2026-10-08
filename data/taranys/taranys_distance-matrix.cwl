cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taranys
  - distance-matrix
label: taranys_distance-matrix
doc: "Calculate the Hamming distance matrix between samples from the allele matrix produced by allele-calling.\n\nTool homepage: https://github.com/BU-ISCIII/taranys"
inputs:
  - id: alleles
    type: File
    doc: "Alleles matrix file from which to obtain distances between samples"
    inputBinding:
      position: 1
      prefix: --alleles
  - id: output
    type: string
    doc: "Output folder to save distance matrix"
    inputBinding:
      position: 1
      prefix: --output
  - id: force
    type: ['null', boolean]
    doc: "Overwrite the output folder if it exists"
    inputBinding:
      position: 1
      prefix: --force
  - id: no_force
    type: ['null', boolean]
    doc: "Negation of --force. Overwrite the output folder if it exists"
    inputBinding:
      position: 1
      prefix: --no-force
  - id: locus_missing_threshold
    type: ['null', int]
    doc: "Maximum percentaje of missing values a locus can have, otherwise is filtered. By default core genome is calculated, locus must be found in all samples. Default 0."
    inputBinding:
      position: 1
      prefix: --locus-missing-threshold
  - id: sample_missing_threshold
    type: ['null', int]
    doc: "Maximum percentaje for missing values a sample can have, otherwise it is filtered. Default 20."
    inputBinding:
      position: 1
      prefix: --sample-missing-threshold
  - id: paralog_filter
    type: ['null', boolean]
    doc: "Consider paralog tags (NIPH, NIPHEM) as missing values."
    inputBinding:
      position: 1
      prefix: --paralog-filter
  - id: no_paralog_filter
    type: ['null', boolean]
    doc: "Negation of --paralog-filter. Consider paralog tags (NIPH, NIPHEM) as missing values."
    inputBinding:
      position: 1
      prefix: --no-paralog-filter
  - id: lnf_filter
    type: ['null', boolean]
    doc: "Consider LNF as missing values."
    inputBinding:
      position: 1
      prefix: --lnf-filter
  - id: no_lnf_filter
    type: ['null', boolean]
    doc: "Negation of --lnf-filter. Consider LNF as missing values."
    inputBinding:
      position: 1
      prefix: --no-lnf-filter
  - id: plot_filter
    type: ['null', boolean]
    doc: "Consider PLOT as missing values."
    inputBinding:
      position: 1
      prefix: --plot-filter
  - id: no_plot_filter
    type: ['null', boolean]
    doc: "Negation of --plot-filter. Consider PLOT as missing values."
    inputBinding:
      position: 1
      prefix: --no-plot-filter
outputs:
  - id: output_dir
    type: Directory
    doc: "Output folder with the distance matrix."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taranys:3.0.1--pyhdfd78af_0
