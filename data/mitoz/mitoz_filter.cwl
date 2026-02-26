cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitoz_filter
label: mitoz_filter
doc: "Filter input fastq reads.\n\nTool homepage: https://github.com/linzhi2013/MitoZ"
inputs:
  - id: data_size_for_mt_assembly
    type:
      - 'null'
      - string
    doc: Data size (Gbp) used for mitochondrial genome assembly, usually between
      3~8 Gbp is enough. The float1 means the size (Gbp) of raw data to be 
      subsampled, while the float2 means the size of clean data should be >= 
      float2 Gbp, otherwise MitoZ will stop to run. When only float1 is set, 
      float2 is assumed to be 0. Set float1 to be 0 if you want to use ALL raw 
      data.
    default: 5,0
    inputBinding:
      position: 101
      prefix: --data_size_for_mt_assembly
  - id: fastq_read_length
    type:
      - 'null'
      - int
    doc: read length of fastq reads, used to split clean fastq files.
    default: 150
    inputBinding:
      position: 101
      prefix: --fastq_read_length
  - id: filter_other_para
    type:
      - 'null'
      - string
    doc: other parar.
    default: ''
    inputBinding:
      position: 101
      prefix: --filter_other_para
  - id: fq1
    type: File
    doc: Fastq1 file
    inputBinding:
      position: 101
      prefix: --fq1
  - id: fq2
    type:
      - 'null'
      - File
    doc: Fastq2 file
    inputBinding:
      position: 101
      prefix: --fq2
  - id: outprefix
    type:
      - 'null'
      - string
    doc: output prefix
    default: out
    inputBinding:
      position: 101
      prefix: --outprefix
  - id: phred64
    type:
      - 'null'
      - boolean
    doc: Are the fastq phred64 encoded?
    default: false
    inputBinding:
      position: 101
      prefix: --phred64
  - id: thread_number
    type:
      - 'null'
      - int
    doc: thread number
    default: 4
    inputBinding:
      position: 101
      prefix: --thread_number
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: working directory
    default: ./
    inputBinding:
      position: 101
      prefix: --workdir
  - id: workdir_done
    type:
      - 'null'
      - Directory
    doc: done directory
    default: ./done
    inputBinding:
      position: 101
      prefix: --workdir_done
  - id: workdir_log
    type:
      - 'null'
      - Directory
    doc: log directory
    default: ./log
    inputBinding:
      position: 101
      prefix: --workdir_log
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
stdout: mitoz_filter.out
