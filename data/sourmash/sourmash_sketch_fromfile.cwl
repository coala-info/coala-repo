cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- sketch
- fromfile
label: sourmash_sketch_fromfile
doc: 'Create sketches in batch from a CSV file of names and sequence files.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
- id: csvs
  type: File[]
  doc: CSV files with name, genome_filename and protein_filename columns.
  inputBinding:
    position: 0
- id: param_string
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --param-string
  doc: signature parameters to use.
  inputBinding:
    position: 1
- id: already_done
  type:
  - 'null'
  - type: array
    items: File
  doc: one or more collections of existing signatures to avoid recalculating
  inputBinding:
    position: 1
    prefix: --already-done
- id: license
  type:
  - 'null'
  - string
  doc: signature license. Currently only CC0 is supported.
  inputBinding:
    position: 1
    prefix: --license
- id: check_sequence
  type:
  - 'null'
  - boolean
  doc: 'complain if input sequence is invalid (NOTE: only checks DNA)'
  inputBinding:
    position: 1
    prefix: --check-sequence
- id: output_signatures
  type: string
  doc: output computed signatures to this file
  inputBinding:
    position: 1
    prefix: --output-signatures
  default: sketches.zip
- id: force_output_already_exists
  type:
  - 'null'
  - boolean
  doc: overwrite/append to --output-signatures location
  inputBinding:
    position: 1
    prefix: --force-output-already-exists
- id: ignore_missing
  type:
  - 'null'
  - boolean
  doc: proceed with building possible signatures, even if some input files are missing
  inputBinding:
    position: 1
    prefix: --ignore-missing
- id: output_csv_info
  type:
  - 'null'
  - string
  doc: output information about what signatures need to be generated
  inputBinding:
    position: 1
    prefix: --output-csv-info
- id: output_manifest_matching
  type:
  - 'null'
  - string
  doc: output a manifest file of already-existing signatures
  inputBinding:
    position: 1
    prefix: --output-manifest-matching
- id: report_duplicated
  type:
  - 'null'
  - boolean
  doc: report duplicated names
  inputBinding:
    position: 1
    prefix: --report-duplicated
- id: sequence_files
  type:
  - 'null'
  - type: array
    items: File
  doc: Sequence files named in the CSV file (genome_filename, protein_filename); staged next to the CSV so the names resolve.
outputs:
- id: output_signatures_result
  type: File
  doc: output computed signatures to this file
  outputBinding:
    glob: $(inputs.output_signatures)
- id: output_csv_info_result
  type:
  - 'null'
  - File
  doc: output information about what signatures need to be generated
  outputBinding:
    glob: $(inputs.output_csv_info)
- id: output_manifest_matching_result
  type:
  - 'null'
  - File
  doc: output a manifest file of already-existing signatures
  outputBinding:
    glob: $(inputs.output_manifest_matching)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
requirements:
- class: InitialWorkDirRequirement
  listing:
  - $(inputs.sequence_files)
