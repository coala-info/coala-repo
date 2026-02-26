cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crux
  - spectral-counts
label: crux_spectral-counts
doc: "Calculate spectral counts for PSMs.\n\nTool homepage: https://github.com/redbadger/crux"
inputs:
  - id: input_psms
    type: File
    doc: A PSM file in either tab delimited text format (as produced by 
      percolator, q-ranker, or barista) or pepXML format.
    inputBinding:
      position: 1
  - id: custom_threshold_min
    type:
      - 'null'
      - boolean
    doc: When selecting matches with a custom threshold, custom-threshold-min 
      determines whether to filter matches with custom-threshold-name values 
      that are greater-than or equal (F) or less-than or equal (T) than the 
      threshold.
    default: true
    inputBinding:
      position: 102
      prefix: --custom-threshold-min
  - id: custom_threshold_name
    type:
      - 'null'
      - string
    doc: Specify which field to apply the threshold to. The direction of the 
      threshold (<= or >=) is governed by --custom-threshold-min. By default, 
      the threshold applies to the q-value, specified by "percolator q-value", 
      "q-ranker q-value", "decoy q-value (xcorr)", or "barista q-value".
    default: ''
    inputBinding:
      position: 102
      prefix: --custom-threshold-name
  - id: fileroot
    type:
      - 'null'
      - string
    doc: The fileroot string will be added as a prefix to all output file names.
    default: ''
    inputBinding:
      position: 102
      prefix: --fileroot
  - id: input_ms2
    type:
      - 'null'
      - string
    doc: MS2 file corresponding to the psm file. Required to measure the SIN. 
      Ignored for NSAF, dNSAF and EMPAI.
    default: ''
    inputBinding:
      position: 102
      prefix: --input-ms2
  - id: measure
    type:
      - 'null'
      - string
    doc: 'Type of analysis to make on the match results: (RAW|NSAF|dNSAF|SIN|EMPAI).
      With exception of the RAW metric, the database of sequences need to be provided
      using --protein-database.'
    default: NSAF
    inputBinding:
      position: 102
      prefix: --measure
  - id: mzid_use_pass_threshold
    type:
      - 'null'
      - boolean
    doc: Use mzid's passThreshold attribute to filter matches.
    default: false
    inputBinding:
      position: 102
      prefix: --mzid-use-pass-threshold
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
      - string
    doc: A file containing parameters.
    default: ''
    inputBinding:
      position: 102
      prefix: --parameter-file
  - id: parsimony
    type:
      - 'null'
      - string
    doc: Perform a parsimony analysis on the proteins, and report a "parsimony 
      rank" column in the output file. This column contains integers indicating 
      the protein's rank in a list sorted by spectral counts. If the parsimony 
      analysis results in two proteins being merged, then their parsimony rank 
      is the same. In such a case, the rank is assigned based on the largest 
      spectral count of any protein in the merged meta-protein. The "simple" 
      parsimony algorithm only merges two proteins A and B if the peptides 
      identified in protein A are the same as or a subset of the peptides 
      identified in protein B. The "greedy" parsimony algorithm does additional 
      merging, using the peptide q-values to greedily assign each peptide to a 
      single protein.
    default: none
    inputBinding:
      position: 102
      prefix: --parsimony
  - id: protein_database
    type:
      - 'null'
      - File
    doc: The name of the file in FASTA format.
    default: ''
    inputBinding:
      position: 102
      prefix: --protein-database
  - id: quant_level
    type:
      - 'null'
      - string
    doc: Quantification at protein or peptide level.
    default: protein
    inputBinding:
      position: 102
      prefix: --quant-level
  - id: spectrum_parser
    type:
      - 'null'
      - string
    doc: Specify the parser to use for reading in MS/MS spectra.
    default: pwiz
    inputBinding:
      position: 102
      prefix: --spectrum-parser
  - id: threshold
    type:
      - 'null'
      - float
    doc: Only consider PSMs with a threshold value. By default, q-values are 
      thresholded using a specified threshold value. This behavior can be 
      changed using the --custom-threshold and --threshold-min parameters.
    default: 0.01
    inputBinding:
      position: 102
      prefix: --threshold
  - id: threshold_type
    type:
      - 'null'
      - string
    doc: 'Determines what type of threshold to use when filtering matches. none :
      read all matches, qvalue : use calculated q-value from percolator or q-ranker,
      custom : use --custom-threshold-name and --custom-threshold-min parameters.'
    default: qvalue
    inputBinding:
      position: 102
      prefix: --threshold-type
  - id: unique_mapping
    type:
      - 'null'
      - boolean
    doc: Ignore peptides that map to multiple proteins.
    default: false
    inputBinding:
      position: 102
      prefix: --unique-mapping
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
stdout: crux_spectral-counts.out
