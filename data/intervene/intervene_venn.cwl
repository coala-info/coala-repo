cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - intervene
  - venn
label: intervene_venn
doc: "Create Venn diagram upto 6-way after intersection of genomic regions in (BED/GTF/GFF)
  format or list sets.\n\nTool homepage: https://github.com/asntech/intervene"
inputs:
  - id: bedtools_options
    type:
      - 'null'
      - string
    doc: "List any of the arguments available for bedtools intersect command.\n  \
      \                      Type bedtools intersect --help to view all the options.\n\
      \                        For example: --bedtools-options f=0.8,r,etc"
    inputBinding:
      position: 101
      prefix: --bedtools-options
  - id: bordercolors
    type:
      - 'null'
      - string
    doc: A matplotlib-valid color for venn borders. E.g., --bordercolor=red
    inputBinding:
      position: 101
      prefix: --bordercolors
  - id: colors
    type:
      - 'null'
      - string
    doc: Comma-separated list of matplotlib-valid colors for fill. E.g., 
      --colors=r,b,k
    inputBinding:
      position: 101
      prefix: --colors
  - id: dpi
    type:
      - 'null'
      - int
    doc: 'Dots-per-inch (DPI) for the output. Default is: "300"'
    inputBinding:
      position: 101
      prefix: --dpi
  - id: figsize
    type:
      - 'null'
      - type: array
        items: string
    doc: Figure size as width and height.e.g. --figsize 12 12.
    inputBinding:
      position: 101
      prefix: --figsize
  - id: figtype
    type:
      - 'null'
      - string
    doc: Figure type for the plot. e.g. --figtype svg. Default is "pdf"
    inputBinding:
      position: 101
      prefix: --figtype
  - id: filenames
    type:
      - 'null'
      - boolean
    doc: Use file names as labels instead. Default is "False"
    inputBinding:
      position: 101
      prefix: --filenames
  - id: fill
    type:
      - 'null'
      - string
    doc: Report number or  percentage of overlaps (Only if --type=list). Default
      is "number"
    inputBinding:
      position: 101
      prefix: --fill
  - id: fontsize
    type:
      - 'null'
      - string
    doc: 'Font size for the plot labels.Default is: "14"'
    inputBinding:
      position: 101
      prefix: --fontsize
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input genomic regions in (BED/GTF/GFF) format or lists of genes/SNPs IDs.\n\
      \                        For files in a directory use *.<extension>. e.g. *.bed"
    inputBinding:
      position: 101
      prefix: --input
  - id: names
    type:
      - 'null'
      - string
    doc: "Comma-separated list of names as labels for input files.\n             \
      \           If it is not set file names will be used as labels.\n          \
      \              For example: --names=A,B,C,D,E,F"
    inputBinding:
      position: 101
      prefix: --names
  - id: overlap_thresh
    type:
      - 'null'
      - string
    doc: 'Minimum threshold to save the overlapping regions/names as bed/txt. Default
      is: "1"'
    inputBinding:
      position: 101
      prefix: --overlap-thresh
  - id: project
    type:
      - 'null'
      - string
    doc: 'Project name for the output. Default is: "Intervene"'
    inputBinding:
      position: 101
      prefix: --project
  - id: save_overlaps
    type:
      - 'null'
      - boolean
    doc: Save overlapping regions/names for all the combinations as bed/txt. 
      Default is "False".
    inputBinding:
      position: 101
      prefix: --save-overlaps
  - id: test
    type:
      - 'null'
      - boolean
    doc: This will run the program on test data.
    inputBinding:
      position: 101
      prefix: --test
  - id: title
    type:
      - 'null'
      - string
    doc: Title of the plot. By default it is not set.
    inputBinding:
      position: 101
      prefix: --title
  - id: type
    type:
      - 'null'
      - string
    doc: Type of input sets. Genomic regions or lists of genes/SNPs.
    inputBinding:
      position: 101
      prefix: --type
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
