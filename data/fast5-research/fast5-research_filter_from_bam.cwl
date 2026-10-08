cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter_from_bam
label: fast5-research_filter_from_bam
doc: "Create filter file from BAM and sequencing summary. The table of read ids and
  fast5 file names is written to standard output.\n\nTool homepage: https://github.com/nanoporetech/fast5_research"
inputs:
  - id: bam_file
    type: File
    doc: Path to BAM file
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 101
  - id: summary_files
    type:
      type: array
      items: File
    doc: Sequencing summary files (gzip compressed)
    inputBinding:
      position: 102
  - id: separator
    type:
      - 'null'
      - string
    doc: Seperator in sequencing summary files
    inputBinding:
      position: 1
      prefix: --seperator
  - id: id_col
    type:
      - 'null'
      - string
    doc: Column name for read_id in sequencing summary files
    inputBinding:
      position: 1
      prefix: --id-col
  - id: fname_col
    type:
      - 'null'
      - string
    doc: Column name for fast5 filename in sequencing summary files
    inputBinding:
      position: 1
      prefix: --fname-col
  - id: region
    type:
      - 'null'
      - string
    doc: Print reads only from this region
    inputBinding:
      position: 1
      prefix: --region
  - id: workers
    type:
      - 'null'
      - int
    doc: Number of worker processes.
    inputBinding:
      position: 1
      prefix: --workers
  - id: primary_only
    type:
      - 'null'
      - boolean
    doc: Ignore secondary and supplementary alignments
    inputBinding:
      position: 1
      prefix: --primary-only
outputs:
  - id: filter_table
    type: stdout
    doc: Tab separated table with columns read_id and filename.
stdout: fast5-research_filter_from_bam.tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast5-research:1.2.22--pyh864c0ab_0
