cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metawrap
  - read_qc
label: metawrap_read_qc
doc: "Performs quality control on raw sequencing reads.\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs:
  - id: host_index_prefix
    type:
      - 'null'
      - string
    doc: prefix of host index in bmtagger database folder
    inputBinding:
      position: 101
      prefix: -x
  - id: reads_1
    type: File
    doc: forward fastq reads
    inputBinding:
      position: 101
      prefix: '-1'
  - id: reads_2
    type: File
    doc: reverse fastq reads
    inputBinding:
      position: 101
      prefix: '-2'
  - id: skip_bmtagger
    type:
      - 'null'
      - boolean
    doc: dont remove human sequences with bmtagger
    inputBinding:
      position: 101
      prefix: --skip-bmtagger
  - id: skip_post_qc_report
    type:
      - 'null'
      - boolean
    doc: dont make FastQC report of final sequences
    inputBinding:
      position: 101
      prefix: --skip-post-qc-report
  - id: skip_pre_qc_report
    type:
      - 'null'
      - boolean
    doc: dont make FastQC report of input sequences
    inputBinding:
      position: 101
      prefix: --skip-pre-qc-report
  - id: skip_trimming
    type:
      - 'null'
      - boolean
    doc: dont trim sequences with trimgalore
    inputBinding:
      position: 101
      prefix: --skip-trimming
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_dir
    type: Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap:1.2--0
