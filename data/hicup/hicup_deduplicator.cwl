cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicup_deduplicator
label: hicup_deduplicator
doc: 'The hicup_deduplicator script removes duplicated di-tags (retaining one copy
  of each) from the data set. PCR duplicates from the Hi-C amplification step could
  result in incorrect inferences about genomic conformation.


  Tool homepage: http://www.bioinformatics.babraham.ac.uk/projects/hicup/'
inputs:
  - id: sam_bam_files
    type:
      type: array
      items: File
    doc: SAM/BAM files of filtered di-tags (hicup_filter output)
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
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress progress reports (except warnings)
    inputBinding:
      position: 103
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, allowing simultaneous processing of different files
    inputBinding:
      position: 103
      prefix: --threads
  - id: zip_output
    type:
      - 'null'
      - boolean
    doc: Compress output
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
  - id: deduplicated_pairs
    type:
      - 'null'
      - type: array
        items: File
    doc: De-duplicated di-tag file (SAM, or BAM with --zip)
    outputBinding:
      glob: $(inputs.output_directory_path)/*.dedup.*
  - id: summary
    type:
      - 'null'
      - type: array
        items: File
    doc: Deduplicator summary table
    outputBinding:
      glob: $(inputs.output_directory_path)/hicup_deduplicator_summary_*
  - id: charts
    type:
      - 'null'
      - type: array
        items: File
    doc: De-duplication charts
    outputBinding:
      glob: $(inputs.output_directory_path)/*.svg
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
