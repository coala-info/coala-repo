cwlVersion: v1.2
class: CommandLineTool
baseCommand: tandem_search.rb
label: protk_tandem_search.rb
doc: "Run an X!Tandem msms search on a set of mzML input files.\n\nTool homepage:
  https://github.com/iracooke/protk"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: mzML input files
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
  - id: cleavage_semi
    type:
      - 'null'
      - boolean
    doc: Search for peptides with up to 1 non-enzymatic cleavage site
    default: false
    inputBinding:
      position: 102
      prefix: --cleavage-semi
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
  - id: keep_params_files
    type:
      - 'null'
      - boolean
    doc: Keep X!Tandem parameter files
    default: false
    inputBinding:
      position: 102
      prefix: --keep-params-files
  - id: methionineo
    type:
      - 'null'
      - boolean
    doc: Expect Oxidised Methionine modifications as variable mod in a search
    default: false
    inputBinding:
      position: 102
      prefix: --methionineo
  - id: multi_isotope_search
    type:
      - 'null'
      - boolean
    doc: Expand parent mass window to include windows around neighbouring 
      isotopic peaks
    default: false
    inputBinding:
      position: 102
      prefix: --multi-isotope-search
  - id: num_missed_cleavages
    type:
      - 'null'
      - int
    doc: Number of missed cleavages allowed
    default: 2
    inputBinding:
      position: 102
      prefix: --num-missed-cleavages
  - id: output_spectra
    type:
      - 'null'
      - boolean
    doc: Include spectra in the output file
    default: false
    inputBinding:
      position: 102
      prefix: --output-spectra
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
      prefix: --precursor-ion-tol-units
  - id: replace_output
    type:
      - 'null'
      - boolean
    doc: Dont skip analyses for which the output file already exists
    default: false
    inputBinding:
      position: 102
      prefix: --replace-output
  - id: tandem_params
    type:
      - 'null'
      - string
    doc: Either the full path to an xml file containing a complete set of 
      default parameters, or one of the following (isb_native,isb_kscore,gpm).
    default: isb_native
    inputBinding:
      position: 102
      prefix: --tandem-params
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of processing threads to use. Set to 0 to autodetect an 
      appropriate value
    default: 1
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
