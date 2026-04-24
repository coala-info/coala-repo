cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux assign-confidence
label: crux_assign-confidence
doc: "Assign confidence estimates to peptide-spectrum matches (PSMs).\n\nTool homepage:
  https://github.com/redbadger/crux"
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
  - id: combine_charge_states
    type:
      - 'null'
      - boolean
    doc: Specify this parameter to T in order to combine charge states with 
      peptide sequencesin peptide-centric search. Works only if 
      estimation-method = peptide-level.
    inputBinding:
      position: 102
      prefix: --combine-charge-states
  - id: combine_modified_peptides
    type:
      - 'null'
      - boolean
    doc: Specify this parameter to T in order to treat peptides carrying 
      different or no modifications as being the same. Works only if estimation 
      = peptide-level.
    inputBinding:
      position: 102
      prefix: --combine-modified-peptides
  - id: decoy_prefix
    type:
      - 'null'
      - string
    doc: Specifies the prefix of the protein names that indicate a decoy.
    inputBinding:
      position: 102
      prefix: --decoy-prefix
  - id: estimation_method
    type:
      - 'null'
      - string
    doc: Specify the method used to estimate q-values. The mix-max procedure or 
      target-decoy competition apply to PSMs. The peptide-level option 
      eliminates any PSM for which there exists a better scoring PSM involving 
      the same peptide, and then uses decoys to assign confidence estimates.
    inputBinding:
      position: 102
      prefix: --estimation-method
  - id: fileroot
    type:
      - 'null'
      - string
    doc: The fileroot string will be added as a prefix to all output file names.
    inputBinding:
      position: 102
      prefix: --fileroot
  - id: list_of_files
    type:
      - 'null'
      - boolean
    doc: Specify that the search results are provided as lists of files, rather 
      than as individual files.
    inputBinding:
      position: 102
      prefix: --list-of-files
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
      - string
    doc: A file containing parameters.
    inputBinding:
      position: 102
      prefix: --parameter-file
  - id: score
    type:
      - 'null'
      - string
    doc: Specify the column (for tab-delimited input) or tag (for XML input) 
      used as input to the q-value estimation procedure. If this parameter is 
      unspecified, then the program searches for "xcorr score", "evalue" 
      (comet), "exact p-value" score fields in this order in the input file.
    inputBinding:
      position: 102
      prefix: --score
  - id: sidak
    type:
      - 'null'
      - boolean
    doc: Adjust the score using the Sidak adjustment and reports them in a new 
      column in the output file. Note that this adjustment only makes sense if 
      the given scores are p-values, and that it requires the presence of the 
      "distinct matches/spectrum" feature for each PSM.
    inputBinding:
      position: 102
      prefix: --sidak
  - id: top_match_in
    type:
      - 'null'
      - int
    doc: Specify the maximum rank to allow when parsing results files. Matches 
      with ranks higher than this value will be ignored (a value of zero allows 
      matches with any rank).
    inputBinding:
      position: 102
      prefix: --top-match-in
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
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_assign-confidence.out
