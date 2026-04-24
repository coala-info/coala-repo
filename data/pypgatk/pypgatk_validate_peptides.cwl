cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypgatk validate_peptides
label: pypgatk_validate_peptides
doc: "Validate peptides using the pypgatk pipeline.\n\nTool homepage: http://github.com/bigbio/py-pgatk"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: Configuration file for the validate peptides pipeline
    inputBinding:
      position: 101
      prefix: --config_file
  - id: infile_name
    type:
      - 'null'
      - File
    doc: Variant peptide PSMs table
    inputBinding:
      position: 101
      prefix: --infile_name
  - id: ions_tolerance
    type:
      - 'null'
      - string
    doc: MS2 fragment ions mass accuracy
    inputBinding:
      position: 101
      prefix: --ions_tolerance
  - id: msgf
    type:
      - 'null'
      - boolean
    doc: If it is the standard format of MSGF output, please turn on this 
      switch, otherwise it defaults to mzTab format
    inputBinding:
      position: 101
      prefix: --msgf
  - id: mzml_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The mzml files.Different files are separated by ",".You only need to 
      use either mzml_path or mzml_files
    inputBinding:
      position: 101
      prefix: --mzml_files
  - id: mzml_path
    type:
      - 'null'
      - File
    doc: The mzml file path.You only need to use either mzml_path or mzml_files
    inputBinding:
      position: 101
      prefix: --mzml_path
  - id: number_of_processes
    type:
      - 'null'
      - string
    doc: Used to specify the number of processes. Default is 40.
    inputBinding:
      position: 101
      prefix: --number_of_processes
  - id: relative
    type:
      - 'null'
      - boolean
    doc: When using ppm as ions_tolerance (not Da), it needs to be turned on
    inputBinding:
      position: 101
      prefix: --relative
outputs:
  - id: outfile_name
    type:
      - 'null'
      - File
    doc: Output file for the results
    outputBinding:
      glob: $(inputs.outfile_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
