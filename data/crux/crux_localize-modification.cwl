cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux localize-modification
label: crux_localize-modification
doc: "Localize modifications in PSM files.\n\nTool homepage: https://github.com/redbadger/crux"
inputs:
  - id: input_psm_file
    type: File
    doc: The name of a PSM file in tab-delimited text, SQT, pepXML or mzIdentML 
      format
    inputBinding:
      position: 1
  - id: min_mod_mass
    type:
      - 'null'
      - float
    doc: Ignore implied modifications where the absolute value of its mass is 
      below this value and only score the unmodified peptide.
    default: 0.0
    inputBinding:
      position: 102
      prefix: --min-mod-mass
  - id: mod_precision
    type:
      - 'null'
      - int
    doc: Set the precision for modifications as written to .txt files.
    default: 2
    inputBinding:
      position: 102
      prefix: --mod-precision
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: The name of the directory where output files will be created.
    default: crux-output
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Replace existing files if true or fail when trying to overwrite a file 
      if false.
    default: false
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: parameter_file
    type:
      - 'null'
      - File
    doc: A file containing parameters.
    default: ''
    inputBinding:
      position: 102
      prefix: --parameter-file
  - id: top_match
    type:
      - 'null'
      - int
    doc: Specify the number of matches to report for each spectrum.
    default: 5
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
    default: 30
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_localize-modification.out
