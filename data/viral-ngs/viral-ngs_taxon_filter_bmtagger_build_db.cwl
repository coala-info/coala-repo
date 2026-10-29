cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxon_filter.py
  - bmtagger_build_db
label: viral-ngs_taxon_filter_bmtagger_build_db
doc: "Create a database for use with Bmtagger from an input FASTA file.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: input_fasta
    type: File
    doc: "Location of the input FASTA file"
    inputBinding:
      position: 1
  - id: output_directory
    type: string
    doc: "Location for the output files (Where *.bitmask and *.srprism files will be stored)"
    inputBinding:
      position: 2
  - id: output_file_prefix
    type:
      - 'null'
      - string
    doc: "Prefix for the output file name (default: inputFasta name, sans \".fasta\" extension)"
    inputBinding:
      position: 20
      prefix: --outputFilePrefix
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: db_files
    type:
      type: array
      items: File
    doc: "Database files written in the output directory"
    outputBinding:
      glob: $(inputs.output_directory)/*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_taxon_filter_bmtagger_build_db.out
