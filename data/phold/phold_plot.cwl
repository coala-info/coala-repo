cwlVersion: v1.2
class: CommandLineTool
baseCommand: phold_plot
label: phold_plot
doc: "Creates Phold Circular Genome Plots\n\nTool homepage: https://github.com/gbouras13/phold"
inputs:
  - id: all_contigs
    type:
      - 'null'
      - boolean
    doc: Plot every contig.
    inputBinding:
      position: 101
      prefix: --all
  - id: annotations
    type:
      - 'null'
      - float
    doc: "Controls the proporition of annotations\n                              \
      \    labelled. Must be a proportion between 0 and\n                        \
      \          1 inclusive.  0 = no annotations, 0.5 = half\n                  \
      \                of the annotations, 1 = all annotations.\n                \
      \                  Defaults to 1. Chosen in order of CDS size."
    inputBinding:
      position: 101
      prefix: --annotations
  - id: dpi
    type:
      - 'null'
      - int
    doc: "Resultion (dots per inch). Must be an\n                                \
      \  integer. Defaults to 600."
    inputBinding:
      position: 101
      prefix: --dpi
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrites the output directory
    inputBinding:
      position: 101
      prefix: --force
  - id: input_file
    type: File
    doc: "Path to input file in Genbank format (in the\n                         \
      \         phold output directory)"
    inputBinding:
      position: 101
      prefix: --input
  - id: interval
    type:
      - 'null'
      - int
    doc: "Axis tick interval. Must be an integer. Must\n                         \
      \         be an integer. Defaults to 5000."
    inputBinding:
      position: 101
      prefix: --interval
  - id: label_hypotheticals
    type:
      - 'null'
      - boolean
    doc: "Flag to label hypothetical or unknown\n                                \
      \  proteins. By default these are not labelled"
    inputBinding:
      position: 101
      prefix: --label_hypotheticals
  - id: label_ids_file
    type:
      - 'null'
      - File
    doc: "Text file with list of CDS IDs (from gff\n                             \
      \     file) that are guaranteed to be labelled."
    inputBinding:
      position: 101
      prefix: --label_ids
  - id: label_size
    type:
      - 'null'
      - int
    doc: "Controls annotation label size. Must be an\n                           \
      \       integer. Defaults to 8"
    inputBinding:
      position: 101
      prefix: --label_size
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory to store phold plots
    default: phold_plots
    inputBinding:
      position: 101
      prefix: --output
  - id: plot_title
    type:
      - 'null'
      - string
    doc: "Plot title. Only applies if --all is not\n                             \
      \     specified. Will default to the phage's\n                             \
      \     contig id."
    inputBinding:
      position: 101
      prefix: --plot_title
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix for output files. Needs to match what\n                         \
      \         phold was run with."
    default: phold
    inputBinding:
      position: 101
      prefix: --prefix
  - id: remove_other_features_labels
    type:
      - 'null'
      - boolean
    doc: "Flag to remove labels for\n                                  tRNA/tmRNA/CRISPRs.
      By default these are\n                                  labelled.  They will
      still be plotted in\n                                  black"
    inputBinding:
      position: 101
      prefix: --remove_other_features_labels
  - id: title_size
    type:
      - 'null'
      - float
    doc: "Controls title size. Must be an integer.\n                             \
      \     Defaults to 20"
    inputBinding:
      position: 101
      prefix: --title_size
  - id: truncate
    type:
      - 'null'
      - int
    doc: "Number of characters to include in annoation\n                         \
      \         labels before truncation with ellipsis.\n                        \
      \          Must be an integer. Defaults to 20."
    inputBinding:
      position: 101
      prefix: --truncate
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phold:1.2.2--pyhdfd78af_0
stdout: phold_plot.out
