cwlVersion: v1.2
class: CommandLineTool
baseCommand: haphpipe join_reads
label: haphpipe_join_reads
doc: "Joins paired-end reads using FLASH.\n\nTool homepage: https://github.com/gwcbi/haphpipe"
inputs:
  - id: allow_outies
    type:
      - 'null'
      - boolean
    doc: Also try combining read pairs in the "outie" orientation
    inputBinding:
      position: 101
      prefix: --allow_outies
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print commands but do not run
    inputBinding:
      position: 101
      prefix: --debug
  - id: encoding
    type:
      - 'null'
      - string
    doc: Quality score encoding
    inputBinding:
      position: 101
      prefix: --encoding
  - id: fq1
    type: File
    doc: Fastq file with read 1
    inputBinding:
      position: 101
      prefix: --fq1
  - id: fq2
    type: File
    doc: Fastq file with read 1
    inputBinding:
      position: 101
      prefix: --fq2
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keep temporary directory
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: logfile
    type:
      - 'null'
      - File
    doc: Append console output to this file
    inputBinding:
      position: 101
      prefix: --logfile
  - id: max_overlap
    type:
      - 'null'
      - int
    doc: Maximum overlap length expected in approximately 90 pct of read pairs, 
      longer overlaps are penalized.
    inputBinding:
      position: 101
      prefix: --max_overlap
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: The minimum required overlap length between two reads to provide a 
      confident overlap.
    inputBinding:
      position: 101
      prefix: --min_overlap
  - id: ncpu
    type:
      - 'null'
      - int
    doc: Number of CPU to use
    inputBinding:
      position: 101
      prefix: --ncpu
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not write output to console (silence stdout and stderr)
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
