cwlVersion: v1.2
class: CommandLineTool
baseCommand: haphpipe assemble_denovo
label: haphpipe_assemble_denovo
doc: "De novo assembly using Haphpipe\n\nTool homepage: https://github.com/gwcbi/haphpipe"
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
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keep temporary directory
    default: false
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
  - id: ncpu
    type:
      - 'null'
      - int
    doc: Number of CPU to use
    default: 1
    inputBinding:
      position: 101
      prefix: --ncpu
  - id: no_error_correction
    type:
      - 'null'
      - boolean
    doc: Do not perform error correction [spades only]
    default: false
    inputBinding:
      position: 101
      prefix: --no_error_correction
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
    doc: Seed for random number generator (ignored if not subsampling).
    inputBinding:
      position: 101
      prefix: --seed
  - id: subsample
    type:
      - 'null'
      - int
    doc: Use a subsample of reads for assembly.
    inputBinding:
      position: 101
      prefix: --subsample
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
stdout: haphpipe_assemble_denovo.out
