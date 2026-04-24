cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux subtract-index
label: crux_subtract-index
doc: "A new peptide index containing all peptides that occur in the first index but
  not the second.\n\nTool homepage: https://github.com/redbadger/crux"
inputs:
  - id: tide_index_1
    type: File
    doc: A peptide index produced using tide-index
    inputBinding:
      position: 1
  - id: tide_index_2
    type: File
    doc: A second peptide index, to be subtracted from the first index.
    inputBinding:
      position: 2
  - id: mass_precision
    type:
      - 'null'
      - int
    doc: Set the precision for masses and m/z written to sqt and text files.
    inputBinding:
      position: 103
      prefix: --mass-precision
  - id: output_dir
    type:
      - 'null'
      - string
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
      - string
    doc: A file containing parameters.
    inputBinding:
      position: 103
      prefix: --parameter-file
  - id: peptide_list
    type:
      - 'null'
      - boolean
    doc: Create in the output directory a text file listing of all the peptides 
      in the database, along with their neutral masses, one per line. If decoys 
      are generated, then a second file will be created containing the decoy 
      peptides. Decoys that also appear in the target database are marked with 
      an asterisk in a third column.
    inputBinding:
      position: 103
      prefix: --peptide-list
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
  - id: output_index
    type: File
    doc: A new peptide index containing all peptides that occur in the first 
      index but not the second.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
