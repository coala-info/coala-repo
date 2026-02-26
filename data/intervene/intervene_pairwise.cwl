cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - intervene
  - pairwise
label: intervene_pairwise
doc: "Pairwise intersection and heatmap of N genomic region sets in (BED/GTF/GFF)
  format or list/name sets.\n\nTool homepage: https://github.com/asntech/intervene"
inputs:
  - id: barcolor
    type:
      - 'null'
      - string
    doc: Boxplot color (hex vlaue or name, e.g. blue). Default is "#53cfff".
    default: '#53cfff'
    inputBinding:
      position: 101
      prefix: --barcolor
  - id: barlabel
    type:
      - 'null'
      - string
    doc: x-axis label of boxplot if --htype=tribar. Default is "Set size"
    default: Set size
    inputBinding:
      position: 101
      prefix: --barlabel
  - id: bedtools_options
    type:
      - 'null'
      - string
    doc: 'List any of the arguments available for bedtools subcommands: interset,
      jaccard, fisher, reldist. Type bedtools <subcommand> --help to view all the
      options. For example: --bedtools-options f=0.8,r,etc'
    inputBinding:
      position: 101
      prefix: --bedtools-options
  - id: compute
    type:
      - 'null'
      - string
    doc: 'Compute count/fraction of overlaps or other statistical relationships. count:
      calculates the number of overlaps. frac: calculates the fraction of overlap.
      (Default) jaccard: calculate the Jaccard statistic. reldist: calculate the distribution
      of relative distances. fisher: calculate Fisher`s statistic. Note: For jaccard
      and reldist regions should be pre-shorted or set --sort.'
    default: frac
    inputBinding:
      position: 101
      prefix: --compute
  - id: compute_correlation
    type:
      - 'null'
      - boolean
    doc: Compute the correlation. Default is "False".
    default: false
    inputBinding:
      position: 101
      prefix: --corr
  - id: corrtype
    type:
      - 'null'
      - string
    doc: 'Select the type of correlation. pearson: computes the Pearson correlation.
      (Default) kendall: computes the Kendall correlation. spearman: computes the
      Spearman correlation. Note: This only works if --corr is set.'
    default: pearson
    inputBinding:
      position: 101
      prefix: --corrtype
  - id: dpi
    type:
      - 'null'
      - string
    doc: 'Dots-per-inch (DPI) for the output. Default is: "300".'
    default: '300'
    inputBinding:
      position: 101
      prefix: --dpi
  - id: figsize
    type:
      - 'null'
      - type: array
        items: string
    doc: Figure size for the output plot (width,height). e.g.  --figsize 8 8
    inputBinding:
      position: 101
      prefix: --figsize
  - id: figtype
    type:
      - 'null'
      - string
    doc: Figure type for the plot. e.g. --figtype svg. Default is "pdf"
    default: pdf
    inputBinding:
      position: 101
      prefix: --figtype
  - id: fontsize
    type:
      - 'null'
      - string
    doc: Label font size. Default is "8".
    default: '8'
    inputBinding:
      position: 101
      prefix: --fontsize
  - id: genome
    type:
      - 'null'
      - string
    doc: Required argument if --compute=fisher. Needs to be a string assembly 
      name like "mm10" or "hg38"
    inputBinding:
      position: 101
      prefix: --genome
  - id: htype
    type:
      - 'null'
      - string
    doc: Heatmap plot type. Default is "tribar".
    default: tribar
    inputBinding:
      position: 101
      prefix: --htype
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: Input genomic regions in (BED/GTF/GFF) format. For files in a directory
      use *.<extension>. e.g. *.bed
    inputBinding:
      position: 101
      prefix: --input
  - id: labels
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Comma-separated list of names as labels for input files. If it is not set
      file names will be used as labels. For example: --names=A,B,C,D,E,F'
    inputBinding:
      position: 101
      prefix: --names
  - id: project
    type:
      - 'null'
      - string
    doc: 'Project name for the output. Default is: "Intervene"'
    default: Intervene
    inputBinding:
      position: 101
      prefix: --project
  - id: run_test_data
    type:
      - 'null'
      - boolean
    doc: This will run the program on test data.
    inputBinding:
      position: 101
      prefix: --test
  - id: scriptonly
    type:
      - 'null'
      - boolean
    doc: Set to generate Rscript only, if R/Corrplot package are not installed. 
      Default is "False".
    default: false
    inputBinding:
      position: 101
      prefix: --scriptonly
  - id: show_diagonal
    type:
      - 'null'
      - boolean
    doc: Show the diagonal values in the heatmap. Default is "False".
    default: false
    inputBinding:
      position: 101
      prefix: --diagonal
  - id: sort_input
    type:
      - 'null'
      - boolean
    doc: Set this only if your files are not sorted. Default is "False".
    default: false
    inputBinding:
      position: 101
      prefix: --sort
  - id: space
    type:
      - 'null'
      - string
    doc: White space between barplt and heatmap, if --htype=tribar. Default is 
      "1.3".
    default: '1.3'
    inputBinding:
      position: 101
      prefix: --space
  - id: title
    type:
      - 'null'
      - string
    doc: Heatmap main title. Default is "Pairwise intersection".
    default: Pairwise intersection
    inputBinding:
      position: 101
      prefix: --title
  - id: triangle
    type:
      - 'null'
      - string
    doc: Show lower/upper triangle of the matrix as heatmap if --htype=tribar. 
      Default is "lower".
    default: lower
    inputBinding:
      position: 101
      prefix: --triangle
  - id: type
    type:
      - 'null'
      - string
    doc: Type of input sets. Genomic regions or lists of genes/SNPs sets. 
      Default is "genomic".
    default: genomic
    inputBinding:
      position: 101
      prefix: --type
  - id: use_filenames_as_labels
    type:
      - 'null'
      - boolean
    doc: Use file names as labels instead. Default is "False".
    default: false
    inputBinding:
      position: 101
      prefix: --filenames
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output folder path where results will be stored. Default is current 
      working directory.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/intervene:0.6.5--pyh3252c3a_1
