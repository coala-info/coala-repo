cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - freyja
  - plot-covariants
label: freyja_plot-covariants
doc: "Plot COVARIANTS output as a heatmap\n\nTool homepage: https://github.com/andersen-lab/Freyja"
inputs:
  - id: covariants
    type: string
    doc: COVARIANTS output
    inputBinding:
      position: 1
  - id: min_mutations
    type:
      - 'null'
      - int
    doc: minimum number of mutations in a cluster to be plotted
    inputBinding:
      position: 102
      prefix: --min_mutations
  - id: nt_muts
    type:
      - 'null'
      - boolean
    doc: if included, include nucleotide mutations in x-labels
    inputBinding:
      position: 102
      prefix: --nt_muts
  - id: num_clusters
    type:
      - 'null'
      - int
    doc: number of clusters to plot (sorted by frequency)
    inputBinding:
      position: 102
      prefix: --num_clusters
  - id: output_path
    type: string
    doc: 'name for aggregated results  [default: aggregated_result.tsv]'
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
