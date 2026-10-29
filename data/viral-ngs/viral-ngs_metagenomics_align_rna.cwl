cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metagenomics.py
  - align_rna
label: viral-ngs_metagenomics_align_rna
doc: "Align to metagenomics bwa index, mark duplicates, and generate LCA report\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_bam
    type: File
    doc: "Input unaligned reads, BAM format."
    inputBinding:
      position: 1
  - id: db
    type: File
    secondaryFiles:
      - pattern: .amb
        required: false
      - pattern: .ann
        required: false
      - pattern: .bwt
        required: false
      - pattern: .pac
        required: false
      - pattern: .sa
        required: false
    doc: "Bwa index prefix."
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
  - id: dupe_report
    type:
      - 'null'
      - string
    doc: "Generate report including duplicates."
    inputBinding:
      position: 20
      prefix: --dupeReport
  - id: no_sensitive
    type:
      - 'null'
      - boolean
    doc: "Use default BWA mem options instead of sensitive options."
    inputBinding:
      position: 20
      prefix: --noSensitive
  - id: out_bam
    type:
      - 'null'
      - string
    doc: "Output aligned, indexed BAM file. Default is to write to temp."
    inputBinding:
      position: 20
      prefix: --outBam
  - id: out_lca
    type:
      - 'null'
      - string
    doc: "Output LCA assignments for each read."
    inputBinding:
      position: 20
      prefix: --outLca
  - id: dupe_lca
    type:
      - 'null'
      - string
    doc: "Output LCA assignments for each read including duplicates."
    inputBinding:
      position: 20
      prefix: --dupeLca
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
  - id: dupe_report_file
    type:
      - 'null'
      - File
    doc: "Output file written to dupe_report"
    outputBinding:
      glob: $(inputs.dupe_report)
  - id: out_bam_file
    type:
      - 'null'
      - File
    doc: "Output file written to out_bam"
    outputBinding:
      glob: $(inputs.out_bam)
  - id: out_lca_file
    type:
      - 'null'
      - File
    doc: "Output file written to out_lca"
    outputBinding:
      glob: $(inputs.out_lca)
  - id: dupe_lca_file
    type:
      - 'null'
      - File
    doc: "Output file written to dupe_lca"
    outputBinding:
      glob: $(inputs.dupe_lca)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
