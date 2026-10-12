cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pauvre
  - stats
label: pauvre_stats
doc: "Generate statistics and optionally a histogram from FASTQ files.\n\nTool homepage:
  https://github.com/conchoecia/gloTK"
inputs:
  - id: fastq
    type:
      - 'null'
      - File
    doc: The input FASTQ file.
    inputBinding:
      position: 101
      prefix: --fastq
  - id: filt_maxlen
    type:
      - 'null'
      - int
    doc: This sets the max read length filter reads.
    inputBinding:
      position: 101
      prefix: --filt_maxlen
  - id: filt_maxqual
    type:
      - 'null'
      - float
    doc: This sets the max mean read quality to filter reads.
    inputBinding:
      position: 101
      prefix: --filt_maxqual
  - id: filt_minlen
    type:
      - 'null'
      - int
    doc: This sets the min read length to filter reads.
    inputBinding:
      position: 101
      prefix: --filt_minlen
  - id: filt_minqual
    type:
      - 'null'
      - float
    doc: This sets the min mean read quality to filter reads.
    inputBinding:
      position: 101
      prefix: --filt_minqual
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output warnings to stderr
    inputBinding:
      position: 101
      prefix: --quiet
  - id: histogram
    type:
      - 'null'
      - boolean
    doc: Make a histogram of the read lengths and saves it to a new file
    inputBinding:
      position: 101
      prefix: --histogram
outputs:
  - id: stdout
    type: stdout
    doc: Table of read statistics
  - id: histogram_files
    type:
      type: array
      items: File
    doc: Read length histogram as CSV (written when --histogram is set)
    outputBinding:
      glob: '*.hist.csv'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pauvre:0.1924--py_0
stdout: pauvre_stats.out
