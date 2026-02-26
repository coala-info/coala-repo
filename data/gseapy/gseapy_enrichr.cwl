cwlVersion: v1.2
class: CommandLineTool
baseCommand: gseapy enrichr
label: gseapy_enrichr
doc: "Enrichr uses a list of gene names as input.\n\nTool homepage: https://github.com/zqfang/gseapy"
inputs:
  - id: background
    type:
      - 'null'
      - string
    doc: "Choose background from one of the following. (1) A\n                   \
      \     BioMart Dataset name, e.g. 'hsapiens_gene_ensembl' .\n               \
      \         (2) A total gene number, e.g. 20000. Only works for\n            \
      \            GMT file input. (3) A text file contains the\n                \
      \        background gene list (one gene per row). Gene\n                   \
      \     identifier should be the same to your input (-i). (4)\n              \
      \          Default: None. It means all genes in the (-g) input as\n        \
      \                the background."
    inputBinding:
      position: 101
      prefix: --background
  - id: cut_off
    type:
      - 'null'
      - float
    doc: "Adjust-Pval cutoff, used for generating plots.\n                       \
      \ Default: 0.05."
    default: 0.05
    inputBinding:
      position: 101
      prefix: --cut-off
  - id: description
    type:
      - 'null'
      - string
    doc: "It is recommended to enter a short description for\n                   \
      \     your list so that multiple lists can be differentiated\n             \
      \           from each other if you choose to save or share your\n          \
      \              list."
    inputBinding:
      position: 101
      prefix: --description
  - id: figsize
    type:
      - 'null'
      - string
    doc: "The figsize keyword argument need two parameters to\n                  \
      \      define. Default: (6.5, 6)"
    default: (6.5, 6)
    inputBinding:
      position: 101
      prefix: --figsize
  - id: format
    type:
      - 'null'
      - string
    doc: "File extensions supported by Matplotlib active\n                       \
      \ backend, choose from {'pdf', 'png', 'jpeg','ps',\n                       \
      \ 'eps','svg'}. Default: 'pdf'."
    default: pdf
    inputBinding:
      position: 101
      prefix: --format
  - id: gene_sets
    type: string
    doc: "Enrichr library name(s) required. Separate each name\n                 \
      \       by comma."
    inputBinding:
      position: 101
      prefix: --gene-sets
  - id: graph
    type:
      - 'null'
      - int
    doc: 'Numbers of top graphs produced. Default: 20'
    default: 20
    inputBinding:
      position: 101
      prefix: --graph
  - id: ids
    type: string
    doc: Enrichr uses a list of gene names as input.
    inputBinding:
      position: 101
      prefix: --input-list
  - id: no_plot
    type:
      - 'null'
      - boolean
    doc: "Speed up computing by suppressing the plot output.This\n               \
      \         is useful only if data are interested. Default: False."
    default: false
    inputBinding:
      position: 101
      prefix: --no-plot
  - id: organism
    type:
      - 'null'
      - string
    doc: "Enrichr supported organism name. Default: human. See\n                 \
      \       here: https://amp.pharm.mssm.edu/modEnrichr."
    default: human
    inputBinding:
      position: 101
      prefix: --organism
  - id: top_term
    type:
      - 'null'
      - int
    doc: 'Numbers of top terms shown in the plot. Default: 10'
    default: 10
    inputBinding:
      position: 101
      prefix: --top-term
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase output verbosity, print out progress of your\n                \
      \        job"
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: "The GSEApy output directory. Default: the current\n                    \
      \    working directory"
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gseapy:1.1.11--py311h5e00ca1_1
