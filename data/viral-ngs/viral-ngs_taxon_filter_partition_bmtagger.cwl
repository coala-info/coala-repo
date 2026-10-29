cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxon_filter.py
  - partition_bmtagger
label: viral-ngs_taxon_filter_partition_bmtagger
doc: "Use bmtagger to partition input reads into ones that match at least one of several databases and ones that don't match any of the databases.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_fastq1
    type: File
    doc: "Input fastq file; 1st end of paired-end reads."
    inputBinding:
      position: 1
  - id: in_fastq2
    type: File
    doc: "Input fastq file; 2nd end of paired-end reads. Must have same names as inFastq1"
    inputBinding:
      position: 2
  - id: ref_dbs
    type:
      type: array
      items: string
    doc: "Reference databases (one or more) to deplete from input. For each db, requires prior creation of db.bitmask by bmtool, and db.srprism.idx, db.srprism.map, etc. by srprism mkindex."
    inputBinding:
      position: 3
  - id: out_match
    type:
      - 'null'
      - type: array
        items: string
    doc: "Filenames for fastq output of matching reads."
    inputBinding:
      position: 20
      prefix: --outMatch
  - id: out_no_match
    type:
      - 'null'
      - type: array
        items: string
    doc: "Filenames for fastq output of unmatched reads."
    inputBinding:
      position: 20
      prefix: --outNoMatch
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
      position: 21
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 21
      prefix: --tmp_dirKeep
  - id: ref_db_files
    type:
      type: array
      items: File
    doc: "Database files, staged in the working directory so that the prefixes in ref_dbs resolve."
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_match_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Fastq files of matching reads"
    outputBinding:
      glob: $(inputs.out_match || [])
  - id: out_no_match_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Fastq files of unmatched reads"
    outputBinding:
      glob: $(inputs.out_no_match || [])
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.ref_db_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_taxon_filter_partition_bmtagger.out
