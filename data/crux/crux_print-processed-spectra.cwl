cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crux
  - print-processed-spectra
label: crux_print-processed-spectra
doc: "Parse fragmentation spectra from MS2 files and write processed spectra to an
  output file.\n\nTool homepage: https://crux.ms"
inputs:
  - id: ms2_file
    type: File
    doc: The name of one or more files from which to parse the fragmentation 
      spectra, in any of the file formats supported by ProteoWizard.
    inputBinding:
      position: 1
  - id: output_file_name
    type: string
    doc: File where spectrum will be written (inside crux-output).
    inputBinding:
      position: 2
  - id: output_units
    type:
      - 'null'
      - string
    doc: Specify the output units for processed spectra.
    inputBinding:
      position: 102
      prefix: --output-units
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Replace existing files if true or fail when trying to overwrite a file 
      if false.
    inputBinding:
      position: 102
      prefix: --overwrite
      valueFrom: '$(self ? "T" : "F")'
  - id: parameter_file
    type:
      - 'null'
      - File
    doc: A file containing parameters.
    inputBinding:
      position: 102
      prefix: --parameter-file
  - id: spectrum_parser
    type:
      - 'null'
      - string
    doc: Specify the parser to use for reading in MS/MS spectra.
    inputBinding:
      position: 102
      prefix: --spectrum-parser
  - id: stop_after
    type:
      - 'null'
      - string
    doc: Stop after the specified pre-processing step.
    inputBinding:
      position: 102
      prefix: --stop-after
  - id: use_z_line
    type:
      - 'null'
      - boolean
    doc: Specify whether, when parsing an MS2 spectrum file, Crux obtains the 
      precursor mass information from the "S" line or the "Z" line.
    inputBinding:
      position: 102
      prefix: --use-z-line
      valueFrom: '$(self ? "T" : "F")'
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
    type: File
    doc: File where spectrum will be written (inside crux-output).
    outputBinding:
      glob: crux-output/$(inputs.output_file_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
