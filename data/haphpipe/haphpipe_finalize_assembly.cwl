cwlVersion: v1.2
class: CommandLineTool
baseCommand: haphpipe finalize_assembly
label: haphpipe_finalize_assembly
doc: "Finalize assembly by mapping reads to consensus and fixing consensus.\n\nTool
  homepage: https://github.com/gwcbi/haphpipe"
inputs:
  - id: bt2_preset
    type:
      - 'null'
      - string
    doc: Bowtie2 preset to use
    default: very-sensitive
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
    doc: Number of CPU to use
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
    doc: Consensus fasta file
    inputBinding:
      position: 101
      prefix: --ref_fa
  - id: sample_id
    type:
      - 'null'
      - string
    doc: Sample ID
    default: sampleXX
    inputBinding:
      position: 101
      prefix: --sample_id
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
stdout: haphpipe_finalize_assembly.out
