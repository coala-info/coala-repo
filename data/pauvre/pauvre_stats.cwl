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
outputs:
  - id: histogram
    type:
      - 'null'
      - File
    doc: Make a histogram of the read lengths and saves it to a new file
    outputBinding:
      glob: $(inputs.histogram)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pauvre:0.1924--py_0
