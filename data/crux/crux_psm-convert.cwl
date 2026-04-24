cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crux
  - psm-convert
label: crux_psm-convert
doc: "Convert PSM files to different formats.\n\nTool homepage: https://github.com/redbadger/crux"
inputs:
  - id: input_psm_file
    type: File
    doc: The name of a PSM file in tab-delimited text, SQT, pepXML or mzIdentML 
      format
    inputBinding:
      position: 1
  - id: output_format
    type: string
    doc: The desired format of the output file. Legal values are tsv, html, sqt,
      pin, pepxml, mzidentml.
    inputBinding:
      position: 2
  - id: distinct_matches
    type:
      - 'null'
      - boolean
    doc: Whether matches/ion are distinct (as opposed to total).
    inputBinding:
      position: 103
      prefix: --distinct-matches
  - id: input_format
    type:
      - 'null'
      - string
    doc: Legal values are auto, tsv, sqt, pepxml or mzidentml format.
    inputBinding:
      position: 103
      prefix: --input-format
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: The name of the directory where output files will be created.
    inputBinding:
      position: 103
      prefix: --output-dir
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Replace existing files if true or fail when trying to overwrite a file 
      if false.
    inputBinding:
      position: 103
      prefix: --overwrite
  - id: parameter_file
    type:
      - 'null'
      - File
    doc: A file containing parameters.
    inputBinding:
      position: 103
      prefix: --parameter-file
  - id: protein_database
    type:
      - 'null'
      - File
    doc: The name of the file in FASTA format.
    inputBinding:
      position: 103
      prefix: --protein-database
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Specify the verbosity of the current processes. Each level prints the following
      messages, including all those at lower verbosity levels: 0-fatal errors, 10-non-fatal
      errors, 20-warnings, 30-information on the progress of execution, 40-more progress
      information, 50-debug info, 60-detailed debug info.'
    inputBinding:
      position: 103
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_psm-convert.out
