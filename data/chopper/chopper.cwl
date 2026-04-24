cwlVersion: v1.2
class: CommandLineTool
baseCommand: chopper
label: chopper
doc: "Filtering and trimming of fastq files. Reads on stdin and writes to stdout.\n\
  \nTool homepage: https://github.com/wdecoster/chopper"
inputs:
  - id: contaminant_fasta
    type:
      - 'null'
      - File
    doc: Filter contaminants against a fasta
    inputBinding:
      position: 101
      prefix: --contam
  - id: headcrop
    type:
      - 'null'
      - int
    doc: Trim N bases from the start of each read. Required only when using the 
      `fixed-crop` trimming approach
    inputBinding:
      position: 101
      prefix: --headcrop
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input filename
    inputBinding:
      position: 101
      prefix: --input
  - id: inverse
    type:
      - 'null'
      - boolean
    doc: Output the opposite of the normal results
    inputBinding:
      position: 101
      prefix: --inverse
  - id: max_gc
    type:
      - 'null'
      - float
    doc: Filter max GC content
    inputBinding:
      position: 101
      prefix: --maxgc
  - id: max_length
    type:
      - 'null'
      - string
    doc: Sets a maximum read length
    inputBinding:
      position: 101
      prefix: --maxlength
  - id: max_quality
    type:
      - 'null'
      - int
    doc: Sets a maximum Phred average quality score
    inputBinding:
      position: 101
      prefix: --maxqual
  - id: min_gc
    type:
      - 'null'
      - float
    doc: Filter min GC content
    inputBinding:
      position: 101
      prefix: --mingc
  - id: min_length
    type:
      - 'null'
      - int
    doc: Sets a minimum read length
    inputBinding:
      position: 101
      prefix: --minlength
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Sets a minimum Phred average quality score
    inputBinding:
      position: 101
      prefix: --quality
  - id: quality_cutoff
    type:
      - 'null'
      - int
    doc: Set the minimum quality score (Q-score) threshold for trimming 
      low-quality bases from read ends. Required when using the 
      `trim-by-quality` or `best-read-segment` trimming approaches
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: tailcrop
    type:
      - 'null'
      - int
    doc: Trim N bases from the end of each read. Required only when using the 
      `fixed-crop` trimming approach
    inputBinding:
      position: 101
      prefix: --tailcrop
  - id: threads
    type:
      - 'null'
      - int
    doc: Use N parallel threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: trim_approach
    type:
      - 'null'
      - string
    doc: Select the trimming strategy to apply to the reads
    inputBinding:
      position: 101
      prefix: --trim-approach
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chopper:0.12.0--hcdda2d0_0
stdout: chopper.out
