cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux make-pin
label: crux_make-pin
doc: "Creates a pin file from one or more input files containing peptide-spectrum
  matches (PSMs).\n\nTool homepage: https://github.com/redbadger/crux"
inputs:
  - id: target_input
    type:
      type: array
      items: File
    doc: One or more files, each containing a collection of peptide-spectrum 
      matches (PSMs) in tab-delimited text, PepXML, or mzIdentML format. In 
      tab-delimited text format, only the specified score column is required. 
      However if --estimation-method is tdc, then the columns "scan" and 
      "charge" are required, as well as "protein ID" if the search was run with 
      concat=F. Furthermore, if the --estimation-method is specified to 
      peptide-level is set to T, then the column "peptide" must be included, and
      if --sidak is set to T, then the "distinct matches/spectrum" column must 
      be included.
    inputBinding:
      position: 1
  - id: decoy_prefix
    type:
      - 'null'
      - string
    doc: Specifies the prefix of the protein names that indicate a decoy.
    inputBinding:
      position: 102
      prefix: --decoy-prefix
  - id: fileroot
    type:
      - 'null'
      - string
    doc: The fileroot string will be added as a prefix to all output file names.
    inputBinding:
      position: 102
      prefix: --fileroot
  - id: max_charge_feature
    type:
      - 'null'
      - int
    doc: Specifies the maximum charge state feature. When set to zero, use the 
      maximum observed charge state.
    inputBinding:
      position: 102
      prefix: --max-charge-feature
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: The name of the directory where output files will be created.
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Replace existing files if true or fail when trying to overwrite a file 
      if false.
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: parameter_file
    type:
      - 'null'
      - File
    doc: A file containing parameters.
    inputBinding:
      position: 102
      prefix: --parameter-file
  - id: top_match
    type:
      - 'null'
      - int
    doc: Specify the number of matches to report for each spectrum.
    inputBinding:
      position: 102
      prefix: --top-match
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Specify the verbosity of the current processes. Each level prints the following
      messages, including all those at lower verbosity levels: 0-fatal errors, 10-non-fatal
      errors, 20-warnings, 30-information on the progress of execution, 40-more progress
      information, 50-debug info, 60-detailed debug info.'
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path where pin file will be written instead of make-pin.pin.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
