cwlVersion: v1.2
class: CommandLineTool
baseCommand: crass
label: crass
doc: "CRisprASSembler (crass) - A tool for identifying and assembling CRISPR loci
  from metagenomic sequencing data.\n\nTool homepage: https://mummer4.github.io/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input file(s) to process
    inputBinding:
      position: 1
  - id: cov_cutoff
    type:
      - 'null'
      - int
    doc: Remove groups with less than x spacers
    inputBinding:
      position: 102
      prefix: --covCutoff
  - id: graph_colour
    type:
      - 'null'
      - string
    doc: Defines the range of colours to use for the output graph (red-blue, blue-red,
      green-red-blue, red-blue-green)
    inputBinding:
      position: 102
      prefix: --graphColour
  - id: graph_node_len
    type:
      - 'null'
      - int
    doc: Length of the kmers used to make crispr nodes
    inputBinding:
      position: 102
      prefix: --graphNodeLen
  - id: kmer_count
    type:
      - 'null'
      - int
    doc: The number of the kmers that need to be shared for clustering
    inputBinding:
      position: 102
      prefix: --kmerCount
  - id: layout_algorithm
    type:
      - 'null'
      - string
    doc: Graphviz layout algorithm to use for printing spacer graphs (neato, dot,
      fdp, sfdp, circo, twopi)
    inputBinding:
      position: 102
      prefix: --layoutAlgorithm
  - id: log_level
    type:
      - 'null'
      - int
    doc: Output a log file and set a log level [1 - 4]
    inputBinding:
      position: 102
      prefix: --logLevel
  - id: log_to_screen
    type:
      - 'null'
      - boolean
    doc: Print the logging information to screen rather than a file
    inputBinding:
      position: 102
      prefix: --logToScreen
  - id: long_description
    type:
      - 'null'
      - boolean
    doc: Set if you want the spacer sequence printed along with the ID in the spacer
      graph
    inputBinding:
      position: 102
      prefix: --longDescription
  - id: max_dr
    type:
      - 'null'
      - int
    doc: Maximim length of the direct repeat to search for
    inputBinding:
      position: 102
      prefix: --maxDR
  - id: max_spacer
    type:
      - 'null'
      - int
    doc: Maximim length of the spacer to search for
    inputBinding:
      position: 102
      prefix: --maxSpacer
  - id: min_dr
    type:
      - 'null'
      - int
    doc: Minimim length of the direct repeat to search for
    inputBinding:
      position: 102
      prefix: --minDR
  - id: min_num_repeats
    type:
      - 'null'
      - int
    doc: Total number of direct repeats in a CRISPR for it to be considered real
    inputBinding:
      position: 102
      prefix: --minNumRepeats
  - id: min_spacer
    type:
      - 'null'
      - int
    doc: Minimim length of the spacer to search for
    inputBinding:
      position: 102
      prefix: --minSpacer
  - id: no_rendering
    type:
      - 'null'
      - boolean
    doc: Stops rendering of .gv files even if the RENDERING preprocessor macro is
      set
    inputBinding:
      position: 102
      prefix: --noRendering
  - id: num_bins
    type:
      - 'null'
      - int
    doc: The number of colour bins for the output graph
    inputBinding:
      position: 102
      prefix: --numBins
  - id: show_singletons
    type:
      - 'null'
      - boolean
    doc: Set if you want to print singleton spacers in the spacer graph
    inputBinding:
      position: 102
      prefix: --showSingltons
  - id: window_length
    type:
      - 'null'
      - int
    doc: The length of the search window. Can only be a number between 6 - 9
    inputBinding:
      position: 102
      prefix: --windowLength
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crass:1.0.1--hcb2000e_7
