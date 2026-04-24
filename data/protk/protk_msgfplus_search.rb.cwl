cwlVersion: v1.2
class: CommandLineTool
baseCommand: msgfplus_search.rb
label: protk_msgfplus_search.rb
doc: "Run an MSGFPlus msms search on a set of msms spectrum input files.\n\nTool homepage:
  https://github.com/iracooke/protk"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: MSMS spectrum input files (e.g., file1.mzML file2.mzML ...)
    inputBinding:
      position: 1
  - id: acetyl_nterm
    type:
      - 'null'
      - boolean
    doc: Expect N-terminal acetylation as a variable mod in a search or as a 
      parameter when building statistical models
    inputBinding:
      position: 102
      prefix: --acetyl-nterm
  - id: add_features
    type:
      - 'null'
      - boolean
    doc: output additional features
    inputBinding:
      position: 102
      prefix: --add-features
  - id: carbamidomethyl
    type:
      - 'null'
      - boolean
    doc: Expect Carbamidomethyl C modifications as fixed mod in a search
    inputBinding:
      position: 102
      prefix: --carbamidomethyl
  - id: cleavage_semi
    type:
      - 'null'
      - boolean
    doc: Search for peptides with up to 1 non-enzymatic cleavage site
    inputBinding:
      position: 102
      prefix: --cleavage-semi
  - id: database
    type:
      - 'null'
      - string
    doc: Specify the database to use for this search. Can be a named protk 
      database or the path to a fasta file
    inputBinding:
      position: 102
      prefix: --database
  - id: decoy_search
    type:
      - 'null'
      - boolean
    doc: Build and search a decoy database on the fly. Input db should not 
      contain decoys if this option is used
    inputBinding:
      position: 102
      prefix: --decoy-search
  - id: enzyme
    type:
      - 'null'
      - string
    doc: Enzyme
    inputBinding:
      position: 102
      prefix: --enzyme
  - id: fix_mods
    type:
      - 'null'
      - string
    doc: Fixed modifications. These should be provided in a comma separated list
    inputBinding:
      position: 102
      prefix: --fix-mods
  - id: fragment_method
    type:
      - 'null'
      - int
    doc: 'Fragment method 0: As written in the spectrum or CID if no info (Default),
      1: CID, 2: ETD, 3: HCD, 4: Merge spectra from the same precursor'
    inputBinding:
      position: 102
      prefix: --fragment-method
  - id: glyco
    type:
      - 'null'
      - boolean
    doc: Expect N-Glycosylation modifications as variable mod in a search or as 
      a parameter when building statistical models
    inputBinding:
      position: 102
      prefix: --glyco
  - id: instrument
    type:
      - 'null'
      - string
    doc: Instrument
    inputBinding:
      position: 102
      prefix: --instrument
  - id: isotope_error_range
    type:
      - 'null'
      - string
    doc: Takes into account of the error introduced by chooosing a 
      non-monoisotopic peak for fragmentation.
    inputBinding:
      position: 102
      prefix: --isotope-error-range
  - id: java_mem
    type:
      - 'null'
      - string
    doc: Java memory limit when running the search (Default 3.5Gb)
    inputBinding:
      position: 102
      prefix: --java-mem
  - id: max_pep_charge
    type:
      - 'null'
      - int
    doc: Maximum precursor charge to consider if charges are not specified in 
      the spectrum file
    inputBinding:
      position: 102
      prefix: --max-pep-charge
  - id: max_pep_length
    type:
      - 'null'
      - int
    doc: Maximum peptide length to consider
    inputBinding:
      position: 102
      prefix: --max-pep-length
  - id: methionineo
    type:
      - 'null'
      - boolean
    doc: Expect Oxidised Methionine modifications as variable mod in a search
    inputBinding:
      position: 102
      prefix: --methionineo
  - id: min_pep_charge
    type:
      - 'null'
      - int
    doc: Minimum precursor charge to consider if charges are not specified in 
      the spectrum file
    inputBinding:
      position: 102
      prefix: --min-pep-charge
  - id: min_pep_length
    type:
      - 'null'
      - int
    doc: Minimum peptide length to consider
    inputBinding:
      position: 102
      prefix: --min-pep-length
  - id: num_reported_matches
    type:
      - 'null'
      - int
    doc: Number of matches per spectrum to be reported
    inputBinding:
      position: 102
      prefix: --num-reported-matches
  - id: pepxml
    type:
      - 'null'
      - boolean
    doc: Convert results to pepxml.
    inputBinding:
      position: 102
      prefix: --pepxml
  - id: precursor_ion_tol
    type:
      - 'null'
      - float
    doc: Precursor ion mass tolerance.
    inputBinding:
      position: 102
      prefix: --precursor-ion-tol
  - id: precursor_ion_tol_units
    type:
      - 'null'
      - string
    doc: Precursor ion mass tolerance units (ppm or Da).
    inputBinding:
      position: 102
      prefix: --precursor-ion-tol-units
  - id: protocol
    type:
      - 'null'
      - int
    doc: '0: NoProtocol (Default), 1: Phosphorylation, 2: iTRAQ, 3: iTRAQPhospho'
    inputBinding:
      position: 102
      prefix: --protocol
  - id: replace_output
    type:
      - 'null'
      - boolean
    doc: Dont skip analyses for which the output file already exists
    inputBinding:
      position: 102
      prefix: --replace-output
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of processing threads to use. Set to 0 to autodetect an 
      appropriate value
    inputBinding:
      position: 102
      prefix: --threads
  - id: var_mods
    type:
      - 'null'
      - string
    doc: Variable modifications. These should be provided in a comma separated 
      list
    inputBinding:
      position: 102
      prefix: --var-mods
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: An explicitly named output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
