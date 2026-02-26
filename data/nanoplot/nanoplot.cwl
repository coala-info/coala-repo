cwlVersion: v1.2
class: CommandLineTool
baseCommand: NanoPlot
label: nanoplot
doc: "Plotting tool for long-read sequencing data and alignments.\n\nTool homepage:
  https://github.com/wdecoster/NanoPlot"
inputs:
  - id: bam
    type:
      - 'null'
      - type: array
        items: File
    doc: Input BAM file(s)
    inputBinding:
      position: 101
      prefix: --bam
  - id: drop_outliers
    type:
      - 'null'
      - boolean
    doc: Drop outliers (top 5%) from the plots
    inputBinding:
      position: 101
      prefix: --drop_outliers
  - id: fasta
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTA file(s)
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fastq
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTQ file(s)
    inputBinding:
      position: 101
      prefix: --fastq
  - id: format
    type:
      - 'null'
      - string
    doc: Specify the output format of the plots (png, jpg, svg, pdf, html, etc.)
    default: html
    inputBinding:
      position: 101
      prefix: --format
  - id: loglength
    type:
      - 'null'
      - boolean
    doc: Logarithmic transformation of length axis
    inputBinding:
      position: 101
      prefix: --loglength
  - id: maxlength
    type:
      - 'null'
      - int
    doc: Hide reads longer than the specified length
    inputBinding:
      position: 101
      prefix: --maxlength
  - id: minlength
    type:
      - 'null'
      - int
    doc: Hide reads shorter than the specified length
    inputBinding:
      position: 101
      prefix: --minlength
  - id: minqual
    type:
      - 'null'
      - int
    doc: Hide reads with an average quality score lower than the specified value
    inputBinding:
      position: 101
      prefix: --minqual
  - id: prefix
    type:
      - 'null'
      - string
    doc: Specify a prefix for the output filenames
    inputBinding:
      position: 101
      prefix: --prefix
  - id: summary
    type:
      - 'null'
      - File
    doc: Statistically summarize the sequencing run using a 
      sequencing_summary.txt file from Albacore/Guppy
    inputBinding:
      position: 101
      prefix: --summary
  - id: threads
    type:
      - 'null'
      - int
    doc: Set the allowed number of threads to be used by the script
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: title
    type:
      - 'null'
      - string
    doc: Add a title to the plots
    inputBinding:
      position: 101
      prefix: --title
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to deposit the results
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoplot:1.46.2--pyhdfd78af_0
