cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metagenomics.py
  - kraken
label: viral-ngs_metagenomics_kraken
doc: "Classify reads by taxon using Kraken\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_bam
    type: File
    doc: "Input unaligned reads, BAM format."
    inputBinding:
      position: 1
  - id: db
    type: Directory
    doc: "Kraken database directory."
    inputBinding:
      position: 2
  - id: out_report
    type:
      - 'null'
      - string
    doc: "Kraken report output file."
    inputBinding:
      position: 20
      prefix: --outReport
  - id: out_reads
    type:
      - 'null'
      - string
    doc: "Kraken per read output file."
    inputBinding:
      position: 20
      prefix: --outReads
  - id: filter_threshold
    type:
      - 'null'
      - float
    doc: "Kraken filter threshold (default 0.05)"
    inputBinding:
      position: 20
      prefix: --filterThreshold
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Number of threads to run. (default 1)"
    inputBinding:
      position: 20
      prefix: --numThreads
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Base directory for temp files. [default: /tmp]"
    inputBinding:
      position: 20
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 20
      prefix: --tmp_dirKeep
outputs:
  - id: out_report_file
    type:
      - 'null'
      - File
    doc: "Output file written to out_report"
    outputBinding:
      glob: $(inputs.out_report)
  - id: out_reads_file
    type:
      - 'null'
      - File
    doc: "Output file written to out_reads"
    outputBinding:
      glob: $(inputs.out_reads)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
