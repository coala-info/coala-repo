cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gseapy
  - ssgsea
label: gseapy_ssgsea
doc: "Single Sample GSEA\n\nTool homepage: https://github.com/zqfang/gseapy"
inputs:
  - id: ascending
    type:
      - 'null'
      - boolean
    doc: Rank metric sorting order. If the -a flag was chosen, then ascending 
      equals to True.
    inputBinding:
      position: 101
      prefix: --ascending
  - id: correl_type
    type:
      - 'null'
      - string
    doc: Input data transformation after sample normalization. Choose from 
      {'rank','symrank', 'zscore'}.
    inputBinding:
      position: 101
      prefix: --correl-type
  - id: data
    type: File
    doc: Input gene expression dataset file in txt format. Same with GSEA.
    inputBinding:
      position: 101
      prefix: --data
  - id: figsize
    type:
      - 'null'
      - type: array
        items: string
    doc: The figsize keyword argument need two parameters to define.
    inputBinding:
      position: 101
      prefix: --figsize
  - id: format
    type:
      - 'null'
      - string
    doc: File extensions supported by Matplotlib active backend, choose from 
      {'pdf', 'png', 'jpeg','ps', 'eps','svg'}.
    inputBinding:
      position: 101
      prefix: --format
  - id: gmt
    type: File
    doc: Gene set database in GMT format. Same with GSEA.
    inputBinding:
      position: 101
      prefix: --gmt
  - id: graph
    type:
      - 'null'
      - int
    doc: Numbers of top graphs produced.
    inputBinding:
      position: 101
      prefix: --graph
  - id: max_size
    type:
      - 'null'
      - int
    doc: Max size of input genes presented in Gene Sets.
    inputBinding:
      position: 101
      prefix: --max-size
  - id: min_size
    type:
      - 'null'
      - int
    doc: Min size of input genes presented in Gene Sets.
    inputBinding:
      position: 101
      prefix: --min-size
  - id: no_plot
    type:
      - 'null'
      - boolean
    doc: Speed up computing by suppressing the plot output.This is useful only 
      if data are interested.
    inputBinding:
      position: 101
      prefix: --no-plot
  - id: no_scale
    type:
      - 'null'
      - boolean
    doc: If the flag was set, don't normalize the enrichment scores by number of
      genes.
    inputBinding:
      position: 101
      prefix: --ns
  - id: nperm
    type:
      - 'null'
      - int
    doc: Number of random permutations. For calculating esnulls.
    inputBinding:
      position: 101
      prefix: --permu-num
  - id: sample_norm
    type:
      - 'null'
      - string
    doc: Sample normalization method. Choose from {'rank', 'log', 
      'log_rank','custom'}.
    inputBinding:
      position: 101
      prefix: --sample-norm
  - id: seed
    type:
      - 'null'
      - int
    doc: Number of random seed.
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of Processes you are going to use.
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase output verbosity, print out progress of your job
    inputBinding:
      position: 101
      prefix: --verbose
  - id: weight
    type:
      - 'null'
      - float
    doc: Weighted_score of rank_metrics. For weighting input genes.
    inputBinding:
      position: 101
      prefix: --weight
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: The GSEApy output directory.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gseapy:1.1.11--py311h5e00ca1_1
