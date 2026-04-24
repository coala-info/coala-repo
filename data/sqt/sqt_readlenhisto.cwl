cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sqt
  - readlen
  - histo
label: sqt_readlenhisto
doc: "Print and optionally plot a read length histogram of one or more FASTA or FASTQ
  files. If more than one file is given, a total is also printed.\n\nTool homepage:
  https://github.com/tdjsnelling/sqtracker"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input FASTA/FASTQ file(s) (may be gzipped).
    inputBinding:
      position: 1
  - id: bins
    type:
      - 'null'
      - int
    doc: Number of bins in the plot.
    inputBinding:
      position: 102
      prefix: --bins
  - id: max_y
    type:
      - 'null'
      - float
    doc: Maximum y in plot
    inputBinding:
      position: 102
      prefix: --maxy
  - id: min_x
    type:
      - 'null'
      - float
    doc: Minimum x in plot
    inputBinding:
      position: 102
      prefix: --left
  - id: plot_title
    type:
      - 'null'
      - string
    doc: Plot title. {} is replaced with the input file name.
    inputBinding:
      position: 102
      prefix: --title
  - id: print_zero_counts
    type:
      - 'null'
      - boolean
    doc: Print also rows with a count of zero
    inputBinding:
      position: 102
      prefix: --zero
  - id: summarize_outliers
    type:
      - 'null'
      - boolean
    doc: In the plot, summarize outliers greater than the 99.9 percentile in a 
      red bar.
    inputBinding:
      position: 102
      prefix: --outliers
outputs:
  - id: plot_file
    type:
      - 'null'
      - File
    doc: Plot to this file (.pdf or .png). If multiple sequence files given, 
      plot only total.
    outputBinding:
      glob: $(inputs.plot_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
