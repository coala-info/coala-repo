cwlVersion: v1.2
class: CommandLineTool
baseCommand: comet
label: comet-ms_comet
doc: "Comet search engine for mass spectrometry data.\n\nTool homepage: http://comet-ms.sourceforge.net/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input files (mzXML, mzML, Thermo raw, mgf, ms2 variants)
    inputBinding:
      position: 1
  - id: create_peptide_index_only
    type:
      - 'null'
      - boolean
    doc: Create peptide index file only (specify .idx file as database for index
      search)
    inputBinding:
      position: 102
      prefix: -i
  - id: first_scan
    type:
      - 'null'
      - int
    doc: Specify the first/start scan to search, overriding entry in parameters 
      file
    inputBinding:
      position: 102
      prefix: -F
  - id: last_scan
    type:
      - 'null'
      - int
    doc: Specify the last/end scan to search, overriding entry in parameters 
      file. Required if -F option is used.
    inputBinding:
      position: 102
      prefix: -L
  - id: output_base_name
    type:
      - 'null'
      - string
    doc: Specify an alternate output base name; valid only with one input file
    inputBinding:
      position: 102
      prefix: -N
  - id: params_file
    type:
      - 'null'
      - File
    doc: Specify an alternate parameters file
    default: comet.params
    inputBinding:
      position: 102
      prefix: -P
  - id: print_params
    type:
      - 'null'
      - boolean
    doc: Print out a comet.params.new file
    inputBinding:
      position: 102
      prefix: -p
  - id: print_params_verbose
    type:
      - 'null'
      - boolean
    doc: Print out a comet.params.new file with more parameter entries
    inputBinding:
      position: 102
      prefix: -q
  - id: sequence_database
    type:
      - 'null'
      - File
    doc: Specify a sequence database, overriding entry in parameters file
    inputBinding:
      position: 102
      prefix: -D
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/comet-ms:2024011--hb319eff_0
stdout: comet-ms_comet.out
