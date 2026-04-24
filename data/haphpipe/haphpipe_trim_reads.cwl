cwlVersion: v1.2
class: CommandLineTool
baseCommand: haphpipe trim_reads
label: haphpipe_trim_reads
doc: "Trims adapter sequences and low-quality bases from FASTQ files.\n\nTool homepage:
  https://github.com/gwcbi/haphpipe"
inputs:
  - id: adapter_file
    type:
      - 'null'
      - File
    doc: Adapter file
    inputBinding:
      position: 101
      prefix: --adapter_file
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
    type:
      - 'null'
      - File
    doc: Fastq file with read 1
    inputBinding:
      position: 101
      prefix: --fq1
  - id: fq2
    type:
      - 'null'
      - File
    doc: Fastq file with read 1
    inputBinding:
      position: 101
      prefix: --fq2
  - id: fqu
    type:
      - 'null'
      - File
    doc: Fastq file with unpaired reads
    inputBinding:
      position: 101
      prefix: --fqU
  - id: logfile
    type:
      - 'null'
      - File
    doc: Append console output to this file
    inputBinding:
      position: 101
      prefix: --logfile
  - id: ncpu
    type:
      - 'null'
      - int
    doc: Number of CPU to use
    inputBinding:
      position: 101
      prefix: --ncpu
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not write output to console (silence stdout and stderr)
    inputBinding:
      position: 101
      prefix: --quiet
  - id: trimmers
    type:
      - 'null'
      - string
    doc: Trim commands for trimmomatic
    inputBinding:
      position: 101
      prefix: --trimmers
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
stdout: haphpipe_trim_reads.out
