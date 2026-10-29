cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxon_filter.py
  - filter_lastal
label: viral-ngs_taxon_filter_filter_lastal
doc: "Restrict input reads to those that align to the given reference database using LASTAL. Also, remove duplicates with prinseq.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_fastq
    type: File
    doc: "Input fastq file"
    inputBinding:
      position: 1
  - id: ref_db
    type: string
    doc: "Reference database to retain from input"
    inputBinding:
      position: 2
  - id: out_fastq
    type: string
    doc: "Output fastq file"
    inputBinding:
      position: 3
  - id: max_gapless_alignments_per_position
    type:
      - 'null'
      - int
    doc: "maximum gapless alignments per query position (default: 1)"
    inputBinding:
      position: 20
      prefix: -n
  - id: min_length_for_initial_matches
    type:
      - 'null'
      - int
    doc: "minimum length for initial matches (default: 5)"
    inputBinding:
      position: 20
      prefix: -l
  - id: max_length_for_initial_matches
    type:
      - 'null'
      - int
    doc: "maximum length for initial matches (default: 50)"
    inputBinding:
      position: 20
      prefix: -L
  - id: max_initial_matches_per_position
    type:
      - 'null'
      - int
    doc: "maximum initial matches per query position (default: 100)"
    inputBinding:
      position: 20
      prefix: -m
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
    doc: "Database files, staged in the working directory so that the prefix in ref_db resolves."
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_fastq_file
    type: File
    doc: "Output fastq"
    outputBinding:
      glob: $(inputs.out_fastq)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.ref_db_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_taxon_filter_filter_lastal.out
