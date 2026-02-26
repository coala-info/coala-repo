cwlVersion: v1.2
class: CommandLineTool
baseCommand: haphpipe cliquesnv
label: haphpipe_cliquesnv
doc: "Haphpipe tool for CliqueSNV analysis.\n\nTool homepage: https://github.com/gwcbi/haphpipe"
inputs:
  - id: O22min
    type:
      - 'null'
      - float
    doc: minimum threshold for O22 value
    inputBinding:
      position: 101
      prefix: --O22min
  - id: O22minfreq
    type:
      - 'null'
      - float
    doc: minimum threshold for O22 frequency relative to read coverage
    inputBinding:
      position: 101
      prefix: --O22minfreq
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print commands but do not run
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: fasta_format
    type:
      - 'null'
      - string
    doc: 'Fasta defline format: short or extended, add number at end to adjust precision
      of frequency'
    default: extended4
    inputBinding:
      position: 101
      prefix: --fasta_format
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
  - id: fqU
    type:
      - 'null'
      - File
    doc: Fastq file with unpaired reads
    inputBinding:
      position: 101
      prefix: --fqU
  - id: jardir
    type:
      - 'null'
      - Directory
    doc: Path to clique-snv.jar (existing)
    default: .
    inputBinding:
      position: 101
      prefix: --jardir
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Do not delete temporary directory
    default: false
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: logfile
    type:
      - 'null'
      - File
    doc: Name for log file (output)
    inputBinding:
      position: 101
      prefix: --logfile
  - id: merging
    type:
      - 'null'
      - string
    doc: 'Cliques merging algorithm: accurate or fast'
    inputBinding:
      position: 101
      prefix: --merging
  - id: ncpu
    type:
      - 'null'
      - int
    doc: Number of CPU to use
    default: 1
    inputBinding:
      position: 101
      prefix: --ncpu
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: .
    inputBinding:
      position: 101
      prefix: --outdir
  - id: outputend
    type:
      - 'null'
      - int
    doc: Output end position
    inputBinding:
      position: 101
      prefix: --outputend
  - id: outputstart
    type:
      - 'null'
      - int
    doc: Output start position
    inputBinding:
      position: 101
      prefix: --outputstart
  - id: printlog
    type:
      - 'null'
      - boolean
    doc: Print log data to console
    default: false
    inputBinding:
      position: 101
      prefix: --printlog
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not write output to console (silence stdout and stderr)
    default: false
    inputBinding:
      position: 101
      prefix: --quiet
  - id: ref_fa
    type:
      - 'null'
      - File
    doc: Reference FASTA file
    inputBinding:
      position: 101
      prefix: --ref_fa
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
stdout: haphpipe_cliquesnv.out
