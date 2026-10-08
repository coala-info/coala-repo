cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transit
  - heatmap
label: transit_heatmap
doc: "Heatmap of the gene means from the output of the anova or zinb analysis. Genes are selected by q-value (below 0.05 by default). Needs R and rpy2.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: gene_means
    type: File
    doc: "Output file of the anova or zinb analysis"
    inputBinding:
      position: 1
  - id: output_filename
    type: string
    doc: "Output .png file name"
    inputBinding:
      position: 2
  - id: anova
    type: ['null', boolean]
    doc: "Input is the output of anova (give either anova or zinb)"
    inputBinding:
      position: 20
      prefix: -anova
  - id: zinb
    type: ['null', boolean]
    doc: "Input is the output of zinb (give either anova or zinb)"
    inputBinding:
      position: 20
      prefix: -zinb
  - id: topk
    type: ['null', int]
    doc: "Number of top genes to show. Default: all genes selected by q-value"
    inputBinding:
      position: 20
      prefix: -topk
  - id: qval
    type: ['null', float]
    doc: "Adjusted p-value (q-value) cutoff for selecting genes. Default: 0.05"
    inputBinding:
      position: 20
      prefix: -qval
  - id: low_mean_filter
    type: ['null', int]
    doc: "Filter out genes with a grand mean below this value. Default: 5"
    inputBinding:
      position: 20
      prefix: -low_mean_filter
outputs:
  - id: output_file
    type: File
    doc: "Output heatmap image"
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
