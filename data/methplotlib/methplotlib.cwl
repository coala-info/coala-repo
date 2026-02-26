cwlVersion: v1.2
class: CommandLineTool
baseCommand: methplotlib
label: methplotlib
doc: "plotting nanopolish methylation calls or frequency\n\nTool homepage: https://github.com/wdecoster/methplotlib"
inputs:
  - id: bed
    type:
      - 'null'
      - File
    doc: add annotation based on a bed file
    inputBinding:
      position: 101
      prefix: --bed
  - id: binary
    type:
      - 'null'
      - boolean
    doc: Make the nanopolish plot ignorning log likelihood nuances
    inputBinding:
      position: 101
      prefix: --binary
  - id: dotsize
    type:
      - 'null'
      - float
    doc: Control the size of dots in the per read plots
    inputBinding:
      position: 101
      prefix: --dotsize
  - id: example
    type:
      - 'null'
      - boolean
    doc: Show example command and exit.
    inputBinding:
      position: 101
      prefix: --example
  - id: fasta
    type:
      - 'null'
      - File
    doc: required when --window is an entire chromosome, contig or transcript
    inputBinding:
      position: 101
      prefix: --fasta
  - id: gtf
    type:
      - 'null'
      - File
    doc: add annotation based on a gtf file
    inputBinding:
      position: 101
      prefix: --gtf
  - id: methylation
    type:
      type: array
      items: File
    doc: data in nanopolish, nanocompore, ont-cram or bedgraph format
    inputBinding:
      position: 101
      prefix: --methylation
  - id: minqual
    type:
      - 'null'
      - int
    doc: The minimal phred quality to show [for bam/cram input only]
    inputBinding:
      position: 101
      prefix: --minqual
  - id: names
    type:
      type: array
      items: string
    doc: names of datasets in --methylation
    inputBinding:
      position: 101
      prefix: --names
  - id: simplify
    type:
      - 'null'
      - boolean
    doc: simplify annotation track to show genes rather than transcripts
    inputBinding:
      position: 101
      prefix: --simplify
  - id: smooth
    type:
      - 'null'
      - int
    doc: Rolling window size for averaging frequency values
    inputBinding:
      position: 101
      prefix: --smooth
  - id: split
    type:
      - 'null'
      - boolean
    doc: split, rather than overlay the methylation tracks
    inputBinding:
      position: 101
      prefix: --split
  - id: static
    type:
      - 'null'
      - string
    doc: Make a static image of the browser window
    inputBinding:
      position: 101
      prefix: --static
  - id: window
    type: string
    doc: window (region) to which the visualisation has to be restricted
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: 'File to write results to. Default: methylation_browser_{chr}_{start}_{end}.html.
      Use {region} as a shorthand for {chr}_{start}_{end} in the filename. Missing
      paths will be created.'
    outputBinding:
      glob: $(inputs.outfile)
  - id: qcfile
    type:
      - 'null'
      - File
    doc: 'File to write the qc report to. Default: The path in outfile prefixed with
      qc_, default is qc_report_methylation_browser_{chr}_{start}_{end}.html. Use
      {region} as a shorthand for {chr}_{start}_{end} in the filename. Missing paths
      will be created.'
    outputBinding:
      glob: $(inputs.qcfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methplotlib:0.21.2--pyhdfd78af_0
