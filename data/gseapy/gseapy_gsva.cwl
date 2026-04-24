cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gseapy
  - gsva
label: gseapy_gsva
doc: "Performs Gene Set Variation Analysis (GSVA)\n\nTool homepage: https://github.com/zqfang/gseapy"
inputs:
  - id: abs_ranking
    type:
      - 'null'
      - boolean
    doc: Flag used only when --mx-diff is not set. When set, the original Kuiper
      statistic is used
    inputBinding:
      position: 101
      prefix: --abs-ranking
  - id: data
    type: File
    doc: Input gene expression dataset file in txt format. Same with GSEA.
    inputBinding:
      position: 101
      prefix: --data
  - id: gmt
    type: File
    doc: Gene set database in GMT format. Same with GSEA.
    inputBinding:
      position: 101
      prefix: --gmt
  - id: kernel_cdf
    type:
      - 'null'
      - string
    doc: Gaussian is suitable when input expression values are continuous. If 
      input integer counts, then this argument should be set to 'Poisson'
    inputBinding:
      position: 101
      prefix: --kernel-cdf
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
  - id: mx_diff
    type:
      - 'null'
      - boolean
    doc: 'When set, ES is calculated as the maximum distance of the random walk from
      0. Default: False'
    inputBinding:
      position: 101
      prefix: --mx-diff
  - id: seed
    type:
      - 'null'
      - int
    doc: Number of random seed.
    inputBinding:
      position: 101
      prefix: -s
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
    doc: tau in the random walk performed by the gsva.
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
