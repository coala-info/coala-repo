cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metagenomics.py
  - diamond
label: viral-ngs_metagenomics_diamond
doc: "Classify reads by the taxon of the Lowest Common Ancestor (LCA)\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_bam
    type: File
    doc: "Input unaligned reads, BAM format."
    inputBinding:
      position: 1
  - id: db
    type: Directory
    doc: "Diamond database directory."
    inputBinding:
      position: 2
  - id: tax_db
    type: Directory
    doc: "Taxonomy database directory."
    inputBinding:
      position: 3
  - id: out_report
    type: string
    doc: "Output taxonomy report."
    inputBinding:
      position: 4
  - id: out_m8
    type:
      - 'null'
      - string
    doc: "Blast m8 formatted output file."
    inputBinding:
      position: 20
      prefix: --outM8
  - id: out_lca
    type:
      - 'null'
      - string
    doc: "Output LCA assignments for each read."
    inputBinding:
      position: 20
      prefix: --outLca
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Number of threads (default: 1)"
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
    type: File
    doc: "Output file written to out_report"
    outputBinding:
      glob: $(inputs.out_report)
  - id: out_m8_file
    type:
      - 'null'
      - File
    doc: "Output file written to out_m8"
    outputBinding:
      glob: $(inputs.out_m8)
  - id: out_lca_file
    type:
      - 'null'
      - File
    doc: "Output file written to out_lca"
    outputBinding:
      glob: $(inputs.out_lca)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
