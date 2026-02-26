cwlVersion: v1.2
class: CommandLineTool
baseCommand: mascot_search.rb
label: protk_mascot_search.rb
doc: "Run a Mascot msms search on a set of mgf input files.\n\nTool homepage: https://github.com/iracooke/protk"
inputs:
  - id: msms_file
    type: File
    doc: Input MGF file
    inputBinding:
      position: 1
  - id: acetyl_nterm
    type:
      - 'null'
      - boolean
    doc: Expect N-terminal acetylation as a variable mod in a search or as a 
      parameter when building statistical models
    default: false
    inputBinding:
      position: 102
      prefix: --acetyl-nterm
  - id: allowed_charges
    type:
      - 'null'
      - string
    doc: Allowed precursor ion charges.
    default: 1+,2+,3+
    inputBinding:
      position: 102
      prefix: --allowed-charges
  - id: carbamidomethyl
    type:
      - 'null'
      - boolean
    doc: Expect Carbamidomethyl C modifications as fixed mod in a search
    default: false
    inputBinding:
      position: 102
      prefix: --carbamidomethyl
  - id: database
    type:
      - 'null'
      - string
    doc: Specify the database to use for this search. Can be a named protk 
      database or the path to a fasta file
    default: sphuman
    inputBinding:
      position: 102
      prefix: --database
  - id: download_only
    type:
      - 'null'
      - string
    doc: Specify a relative path to an existing results file on the server for 
      download eg(20131113/F227185.dat)
    inputBinding:
      position: 102
      prefix: --download-only
  - id: email
    type:
      - 'null'
      - string
    doc: User email.
    inputBinding:
      position: 102
      prefix: --email
  - id: enzyme
    type:
      - 'null'
      - string
    doc: Enzyme
    default: Trypsin
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
  - id: fragment_ion_tol
    type:
      - 'null'
      - float
    doc: Fragment ion mass tolerance (unit dependent).
    default: 0.65
    inputBinding:
      position: 102
      prefix: --fragment-ion-tol
  - id: fragment_ion_tol_units
    type:
      - 'null'
      - string
    doc: Fragment ion mass tolerance units (Da or mmu).
    default: Da
    inputBinding:
      position: 102
      prefix: --fragment-ion-tol-units
  - id: glyco
    type:
      - 'null'
      - boolean
    doc: Expect N-Glycosylation modifications as variable mod in a search or as 
      a parameter when building statistical models
    default: false
    inputBinding:
      position: 102
      prefix: --glyco
  - id: instrument
    type:
      - 'null'
      - string
    doc: Instrument
    default: ESI-QUAD-TOF
    inputBinding:
      position: 102
      prefix: --instrument
  - id: methionineo
    type:
      - 'null'
      - boolean
    doc: Expect Oxidised Methionine modifications as variable mod in a search
    default: false
    inputBinding:
      position: 102
      prefix: --methionineo
  - id: num_missed_cleavages
    type:
      - 'null'
      - int
    doc: Number of missed cleavages allowed
    default: 2
    inputBinding:
      position: 102
      prefix: --num-missed-cleavages
  - id: password
    type:
      - 'null'
      - string
    doc: Password to use when Mascot security is enabled
    inputBinding:
      position: 102
      prefix: --password
  - id: precursor_ion_tol
    type:
      - 'null'
      - float
    doc: Precursor ion mass tolerance.
    default: 200
    inputBinding:
      position: 102
      prefix: --precursor-ion-tol
  - id: precursor_ion_tol_units
    type:
      - 'null'
      - string
    doc: Precursor ion mass tolerance units (ppm or Da).
    default: ppm
    inputBinding:
      position: 102
      prefix: --precursor_ion_tol-units
  - id: proxy
    type:
      - 'null'
      - string
    doc: The url to a proxy server
    inputBinding:
      position: 102
      prefix: --proxy
  - id: quantitation
    type:
      - 'null'
      - string
    doc: Mascot quant method
    inputBinding:
      position: 102
      prefix: --quantitation
  - id: replace_output
    type:
      - 'null'
      - boolean
    doc: Dont skip analyses for which the output file already exists
    default: false
    inputBinding:
      position: 102
      prefix: --replace-output
  - id: search_type
    type:
      - 'null'
      - string
    doc: Use monoisotopic or average precursor masses. (monoisotopic or average)
    default: monoisotopic
    inputBinding:
      position: 102
      prefix: --search-type
  - id: server
    type:
      - 'null'
      - string
    doc: The url to the cgi directory of the mascot server
    default: www.matrixscience.com/mascot/cgi
    inputBinding:
      position: 102
      prefix: --server
  - id: timeout
    type:
      - 'null'
      - int
    doc: Timeout for sending data file to mascot in seconds
    default: 200
    inputBinding:
      position: 102
      prefix: --timeout
  - id: use_security
    type:
      - 'null'
      - boolean
    doc: When Mascot security is enabled this is required
    default: false
    inputBinding:
      position: 102
      prefix: --use-security
  - id: username
    type:
      - 'null'
      - string
    doc: Username.
    inputBinding:
      position: 102
      prefix: --username
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
