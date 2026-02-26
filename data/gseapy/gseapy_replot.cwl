cwlVersion: v1.2
class: CommandLineTool
baseCommand: gseapy replot
label: gseapy_replot
doc: "Reproduce GSEA figures from GSEA desktop results directory.\n\nTool homepage:
  https://github.com/zqfang/gseapy"
inputs:
  - id: figsize
    type:
      - 'null'
      - string
    doc: The figsize keyword argument need two parameters to define.
    default: (6.5, 6)
    inputBinding:
      position: 101
      prefix: --fs
  - id: format
    type:
      - 'null'
      - string
    doc: File extensions supported by Matplotlib active backend, choose from 
      {'pdf', 'png', 'jpeg','ps', 'eps','svg'}.
    default: "'pdf'"
    inputBinding:
      position: 101
      prefix: --format
  - id: graph
    type:
      - 'null'
      - int
    doc: Numbers of top graphs produced.
    default: 20
    inputBinding:
      position: 101
      prefix: --graph
  - id: indir
    type: Directory
    doc: The GSEA desktop results directroy that you want to reproduce the 
      figure
    inputBinding:
      position: 101
      prefix: --indir
  - id: no_plot
    type:
      - 'null'
      - boolean
    doc: Speed up computing by suppressing the plot output.This is useful only 
      if data are interested.
    default: false
    inputBinding:
      position: 101
      prefix: --no-plot
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: The GSEApy output directory.
    default: the current working directory
    inputBinding:
      position: 101
      prefix: --outdir
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
    doc: Weighted_score of rank_metrics. Please Use the same value in GSEA. 
      Choose from (0, 1, 1.5, 2)
    default: 1
    inputBinding:
      position: 101
      prefix: --weight
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gseapy:1.1.11--py311h5e00ca1_1
stdout: gseapy_replot.out
