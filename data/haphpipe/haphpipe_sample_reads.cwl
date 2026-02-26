cwlVersion: v1.2
class: CommandLineTool
baseCommand: haphpipe sample_reads
label: haphpipe_sample_reads
doc: "Sample reads from fastq files.\n\nTool homepage: https://github.com/gwcbi/haphpipe"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print commands but do not run
    default: false
    inputBinding:
      position: 101
      prefix: --debug
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
    doc: Fastq file with read 2
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
  - id: frac
    type:
      - 'null'
      - float
    doc: Fraction of reads to sample, between 0 and 1. Each read has [frac] 
      probability of being sampled, so number of sampled reads is not precisely 
      [frac * num_reads].
    inputBinding:
      position: 101
      prefix: --frac
  - id: logfile
    type:
      - 'null'
      - File
    doc: Append console output to this file
    inputBinding:
      position: 101
      prefix: --logfile
  - id: nreads
    type:
      - 'null'
      - int
    doc: Number of reads to sample. If greater than the number of reads in file,
      all reads will be sampled.
    inputBinding:
      position: 101
      prefix: --nreads
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: .
    inputBinding:
      position: 101
      prefix: --outdir
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not write output to console (silence stdout and stderr)
    default: false
    inputBinding:
      position: 101
      prefix: --quiet
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for random number generator.
    inputBinding:
      position: 101
      prefix: --seed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
stdout: haphpipe_sample_reads.out
