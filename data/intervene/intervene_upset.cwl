cwlVersion: v1.2
class: CommandLineTool
baseCommand: intervene upset
label: intervene_upset
doc: "Create UpSet diagram after intersection of genomic regions in (BED/GTF/GFF)
  or list sets.\n\nTool homepage: https://github.com/asntech/intervene"
inputs:
  - id: bedtools_options
    type:
      - 'null'
      - string
    doc: 'List any of the arguments available for bedtools intersect command. Type
      bedtools intersect --help to view all the options. For example: --bedtools-options
      f=0.8,r,etc'
    inputBinding:
      position: 101
      prefix: --bedtools-options
  - id: dpi
    type:
      - 'null'
      - int
    doc: Dots-per-inch (DPI) for the output.
    default: 300
    inputBinding:
      position: 101
      prefix: --dpi
  - id: figsize
    type:
      - 'null'
      - string
    doc: Figure size for the output plot (width,height). e.g. --figsize 14 8
    inputBinding:
      position: 101
      prefix: --figsize
  - id: figtype
    type:
      - 'null'
      - string
    doc: Figure type for the plot. e.g. --figtype svg.
    default: pdf
    inputBinding:
      position: 101
      prefix: --figtype
  - id: filenames
    type:
      - 'null'
      - boolean
    doc: Use file names as labels instead.
    default: false
    inputBinding:
      position: 101
      prefix: --filenames
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: Input genomic regions in (BED/GTF/GFF) format or lists of genes/SNPs 
      IDs. For files in a directory use *.<extension>. e.g. *.bed
    inputBinding:
      position: 101
      prefix: --input
  - id: mbcolor
    type:
      - 'null'
      - string
    doc: Color of the main bar plot.
    default: '#ea5d4e'
    inputBinding:
      position: 101
      prefix: --mbcolor
  - id: mblabel
    type:
      - 'null'
      - string
    doc: The y-axis label of the intersection size bars.
    default: No. of Intersections
    inputBinding:
      position: 101
      prefix: --mblabel
  - id: names
    type:
      - 'null'
      - string
    doc: 'Comma-separated list of names as labels for input files. If it is not set
      file names will be used as labels. For example: --names=A,B,C,D,E,F'
    inputBinding:
      position: 101
      prefix: --names
  - id: ninter
    type:
      - 'null'
      - int
    doc: Number of top intersections to show in plot.
    default: 30
    inputBinding:
      position: 101
      prefix: --ninter
  - id: order
    type:
      - 'null'
      - string
    doc: The order of intersections of sets. e.g. --order degree.
    default: freq
    inputBinding:
      position: 101
      prefix: --order
  - id: overlap_thresh
    type:
      - 'null'
      - string
    doc: Minimum threshold to save the overlapping regions/names as bed/txt.
    default: '1'
    inputBinding:
      position: 101
      prefix: --overlap-thresh
  - id: project
    type:
      - 'null'
      - string
    doc: Project name for the output.
    default: Intervene
    inputBinding:
      position: 101
      prefix: --project
  - id: save_overlaps
    type:
      - 'null'
      - boolean
    doc: Save overlapping regions/names for all the combinations as bed/txt.
    default: false
    inputBinding:
      position: 101
      prefix: --save-overlaps
  - id: sbcolor
    type:
      - 'null'
      - string
    doc: Color of the set size bar plot.
    default: '#317eab'
    inputBinding:
      position: 101
      prefix: --sbcolor
  - id: scriptonly
    type:
      - 'null'
      - boolean
    doc: Set to generate Rscript only, if R/UpSetR package is not installed.
    default: false
    inputBinding:
      position: 101
      prefix: --scriptonly
  - id: showshiny
    type:
      - 'null'
      - boolean
    doc: Print the combinations of intersections to input to Shiny App.
    default: false
    inputBinding:
      position: 101
      prefix: --showshiny
  - id: showsize
    type:
      - 'null'
      - boolean
    doc: Show intersection sizes above bars.
    default: true
    inputBinding:
      position: 101
      prefix: --showsize
  - id: showzero
    type:
      - 'null'
      - boolean
    doc: Show empty intersection combinations.
    default: false
    inputBinding:
      position: 101
      prefix: --showzero
  - id: sxlabel
    type:
      - 'null'
      - string
    doc: The x-axis label of the set size bars.
    default: Set size
    inputBinding:
      position: 101
      prefix: --sxlabel
  - id: test
    type:
      - 'null'
      - boolean
    doc: This will run the program on test data.
    inputBinding:
      position: 101
      prefix: --test
  - id: type
    type:
      - 'null'
      - string
    doc: Type of input sets. Genomic regions or lists of genes/SNPs sets.
    default: genomic
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output folder path where results will be stored.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/intervene:0.6.5--pyh3252c3a_1
