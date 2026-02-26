cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-join
label: ea-utils_fastq-join
doc: "Joins two paired-end reads on the overlapping ends.\n\nTool homepage: https://expressionanalysis.github.io/ea-utils/"
inputs:
  - id: read1_fq
    type: File
    doc: First paired-end read file
    inputBinding:
      position: 1
  - id: read2_fq
    type: File
    doc: Second paired-end read file
    inputBinding:
      position: 2
  - id: mate_fq
    type:
      - 'null'
      - File
    doc: Optional mate (barcode) read file
    inputBinding:
      position: 3
  - id: allow_insert_shorter_than_read
    type:
      - 'null'
      - boolean
    doc: Allow insert < read length
    inputBinding:
      position: 104
      prefix: -x
  - id: max_difference_percent
    type:
      - 'null'
      - int
    doc: N-percent maximum difference
    default: 8
    inputBinding:
      position: 104
      prefix: -p
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: N-minimum overlap
    default: 6
    inputBinding:
      position: 104
      prefix: -m
  - id: no_reverse_complement
    type:
      - 'null'
      - boolean
    doc: No reverse complement
    inputBinding:
      position: 104
      prefix: -R
  - id: stitch_report_file
    type:
      - 'null'
      - File
    doc: Verbose stitch length report
    inputBinding:
      position: 104
      prefix: -r
  - id: verify_char
    type:
      - 'null'
      - string
    doc: Verifies that the 2 files probe id's match up to char C (use ' ' for 
      Illumina reads)
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: output_template
    type:
      - 'null'
      - File
    doc: Output file name template or list of files for un1, un2, join
    outputBinding:
      glob: $(inputs.output_template)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ea-utils:1.1.2.779--h9dd4a16_0
