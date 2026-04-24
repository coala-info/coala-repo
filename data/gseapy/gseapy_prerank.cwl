cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gseapy
  - prerank
label: gseapy_prerank
doc: "GSEA prerank module\n\nTool homepage: https://github.com/zqfang/gseapy"
inputs:
  - id: ascending
    type:
      - 'null'
      - boolean
    doc: 'Rank metric sorting order. If the -a flag was chosen, then ascending equals
      to True. Default: False.'
    inputBinding:
      position: 101
      prefix: --ascending
  - id: figsize
    type:
      - 'null'
      - type: array
        items: string
    doc: 'The figsize keyword argument need two parameters to define. Default: (6.5,
      6)'
    inputBinding:
      position: 101
      prefix: --figsize
  - id: format
    type:
      - 'null'
      - string
    doc: "File extensions supported by Matplotlib active backend, choose from {'pdf',
      'png', 'jpeg','ps', 'eps','svg'}. Default: 'pdf'."
    inputBinding:
      position: 101
      prefix: --format
  - id: gmt_file
    type: File
    doc: Gene set database in GMT format. Same with GSEA.
    inputBinding:
      position: 101
      prefix: --gmt
  - id: graph_count
    type:
      - 'null'
      - int
    doc: 'Numbers of top graphs produced. Default: 20'
    inputBinding:
      position: 101
      prefix: --graph
  - id: max_size
    type:
      - 'null'
      - int
    doc: 'Max size of input genes presented in Gene Sets. Default: 500'
    inputBinding:
      position: 101
      prefix: --max-size
  - id: min_size
    type:
      - 'null'
      - int
    doc: 'Min size of input genes presented in Gene Sets. Default: 15'
    inputBinding:
      position: 101
      prefix: --min-size
  - id: no_plot
    type:
      - 'null'
      - boolean
    doc: 'Speed up computing by suppressing the plot output.This is useful only if
      data are interested. Default: False.'
    inputBinding:
      position: 101
      prefix: --no-plot
  - id: nperm
    type:
      - 'null'
      - int
    doc: 'Number of random permutations. For calculating esnulls. Default: 1000'
    inputBinding:
      position: 101
      prefix: --permu-num
  - id: phenotype_labels
    type:
      - 'null'
      - type: array
        items: string
    doc: The phenotype label argument need two parameters to define.
    inputBinding:
      position: 101
      prefix: --label
  - id: procs
    type:
      - 'null'
      - int
    doc: 'Number of threads you are going to use. Default: 4'
    inputBinding:
      position: 101
      prefix: --threads
  - id: rnk_file
    type: File
    doc: Ranking metric file in .rnk format. Same with GSEA.
    inputBinding:
      position: 101
      prefix: --rnk
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Number of random seed. Default: 123'
    inputBinding:
      position: 101
      prefix: --seed
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
    doc: 'Weighted_score of rank_metrics. For weighting input genes. Choose from {0,
      1, 1.5, 2}. Default: 1'
    inputBinding:
      position: 101
      prefix: --weight
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: 'The GSEApy output directory. Default: the current working directory'
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gseapy:1.1.11--py311h5e00ca1_1
