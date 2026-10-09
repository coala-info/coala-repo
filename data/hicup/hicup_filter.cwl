cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicup_filter
label: hicup_filter
doc: 'The hicup_filter script classifies read pairs, identifying valid Hi-C di-tags.
  A substantial number of read pairs represent Hi-C artefacts, and HiCUP Filter categorises
  and removes them.


  Tool homepage: http://www.bioinformatics.babraham.ac.uk/projects/hicup/'
inputs:
  - id: mapper_output_files
    type:
      type: array
      items: File
    doc: hicup_mapper output files (SAM/BAM)
    inputBinding:
      position: 2
  - id: config
    type:
      - 'null'
      - File
    doc: Specify the configuration file
    inputBinding:
      position: 103
      prefix: --config
  - id: digest_file
    type:
      - 'null'
      - File
    doc: Specify the genome digest file (created by hicup_digester)
    inputBinding:
      position: 103
      prefix: --digest
  - id: longest_insert_size
    type:
      - 'null'
      - int
    doc: Maximum allowable insert size (bps)
    inputBinding:
      position: 103
      prefix: --longest
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress all progress reports
    inputBinding:
      position: 103
      prefix: --quiet
  - id: shortest_insert_size
    type:
      - 'null'
      - int
    doc: Minimum allowable insert size (bps)
    inputBinding:
      position: 103
      prefix: --shortest
  - id: threads
    type:
      - 'null'
      - int
    doc: Specify the number of threads, allowing simultaneous processing of multiple
      files
    inputBinding:
      position: 103
      prefix: --threads
  - id: zip_output
    type:
      - 'null'
      - boolean
    doc: Compress final output files using gzip, or if SAMtools is installed, to BAM
      format
    inputBinding:
      position: 103
      prefix: --zip
  - id: output_directory_path
    type: string
    default: hicup_out
    doc: Directory to write output files
    inputBinding:
      position: 104
      prefix: --outdir
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory with all output files
    outputBinding:
      glob: $(inputs.output_directory_path)
  - id: filtered_pairs
    type:
      - 'null'
      - type: array
        items: File
    doc: Valid Hi-C di-tag file (SAM, or BAM with --zip)
    outputBinding:
      glob: $(inputs.output_directory_path)/*.filt.*
  - id: summary
    type:
      - 'null'
      - type: array
        items: File
    doc: Filter summary table
    outputBinding:
      glob: $(inputs.output_directory_path)/hicup_filter_summary_*
  - id: charts
    type:
      - 'null'
      - type: array
        items: File
    doc: Filter charts (pie chart, di-tag size distribution)
    outputBinding:
      glob: $(inputs.output_directory_path)/*.svg
  - id: ditag_rejects
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Directory with rejected di-tag files
    outputBinding:
      glob: $(inputs.output_directory_path)/hicup_filter_ditag_rejects_*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_directory_path)
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
