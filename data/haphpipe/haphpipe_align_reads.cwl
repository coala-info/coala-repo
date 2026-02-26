cwlVersion: v1.2
class: CommandLineTool
baseCommand: haphpipe align_reads
label: haphpipe_align_reads
doc: "Align reads to a reference genome using Bowtie2.\n\nTool homepage: https://github.com/gwcbi/haphpipe"
inputs:
  - id: bt2_preset
    type:
      - 'null'
      - string
    doc: Bowtie2 preset
    default: sensitive-local
    inputBinding:
      position: 101
      prefix: --bt2_preset
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print commands but do not run
    default: false
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
    doc: Do not delete temporary directory
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
    doc: Number of CPUs to use
    default: 1
    inputBinding:
      position: 101
      prefix: --ncpu
  - id: no_realign
    type:
      - 'null'
      - boolean
    doc: Do not realign indels
    default: false
    inputBinding:
      position: 101
      prefix: --no_realign
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
  - id: ref_fa
    type: File
    doc: Reference fasta file.
    inputBinding:
      position: 101
      prefix: --ref_fa
  - id: remove_duplicates
    type:
      - 'null'
      - boolean
    doc: Remove duplicates from final alignment. Otherwise duplicates are marked
      but not removed.
    default: false
    inputBinding:
      position: 101
      prefix: --remove_duplicates
  - id: sample_id
    type:
      - 'null'
      - string
    doc: Sample ID. Used as read group ID in BAM
    default: sampleXX
    inputBinding:
      position: 101
      prefix: --sample_id
  - id: xmx
    type:
      - 'null'
      - string
    doc: Maximum heap size for Java VM, in GB.
    default: '32'
    inputBinding:
      position: 101
      prefix: --xmx
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
stdout: haphpipe_align_reads.out
