cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxon_filter.py
  - deplete_blastn_paired
label: viral-ngs_taxon_filter_deplete_blastn_paired
doc: "Use blastn to remove reads that match at least one of the databases.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: infq1
    type: File
    doc: "Input fastq file."
    inputBinding:
      position: 1
  - id: infq2
    type: File
    doc: "Input fastq file."
    inputBinding:
      position: 2
  - id: outfq1
    type: string
    doc: "Output fastq file with matching reads removed."
    inputBinding:
      position: 3
  - id: outfq2
    type: string
    doc: "Output fastq file with matching reads removed."
    inputBinding:
      position: 4
  - id: ref_dbs
    type:
      type: array
      items: string
    doc: "One or more reference databases for blast."
    inputBinding:
      position: 5
  - id: threads
    type:
      - 'null'
      - int
    doc: "The number of threads to use in running blastn."
    inputBinding:
      position: 20
      prefix: --threads
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
  - id: outfq1_file
    type: File
    doc: "Output fastq, 1st end"
    outputBinding:
      glob: $(inputs.outfq1)
  - id: outfq2_file
    type: File
    doc: "Output fastq, 2nd end"
    outputBinding:
      glob: $(inputs.outfq2)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.ref_db_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_taxon_filter_deplete_blastn_paired.out
