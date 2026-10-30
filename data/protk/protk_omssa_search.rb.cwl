cwlVersion: v1.2
class: CommandLineTool
baseCommand: omssa_search.rb
label: protk_omssa_search.rb
doc: 'Run an OMSSA msms search on a set of mgf input files.


  Tool homepage: https://github.com/iracooke/protk'
inputs:
  - id: mgf_files
    type:
      type: array
      items: File
    doc: Input mgf files
    inputBinding:
      position: 1
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
    doc: Number of processing threads to use. Set to 0 to autodetect an appropriate value [1]
    inputBinding:
      position: 102
      prefix: --threads
  - id: database
    type:
      - 'null'
      - string
      - File
    doc: Specify the database to use for this search. Can be a named protk database or the path to a fasta
      file [sphuman]
    inputBinding:
      position: 102
      prefix: --database
  - id: enzyme
    type:
      - 'null'
      - string
    doc: Enzyme [Trypsin]
    inputBinding:
      position: 102
      prefix: --enzyme
  - id: var_mods
    type:
      - 'null'
      - string
    doc: Variable modifications. These should be provided in a comma separated list
    inputBinding:
      position: 102
      prefix: --var-mods
  - id: fix_mods
    type:
      - 'null'
      - string
    doc: Fixed modifications. These should be provided in a comma separated list
    inputBinding:
      position: 102
      prefix: --fix-mods
  - id: instrument
    type:
      - 'null'
      - string
    doc: Instrument [ESI-QUAD-TOF]
    inputBinding:
      position: 102
      prefix: --instrument
  - id: fragment_ion_tol_units
    type:
      - 'null'
      - string
    doc: Fragment ion mass tolerance units (Da or mmu). [Da]
    inputBinding:
      position: 102
      prefix: --fragment-ion-tol-units
  - id: precursor_ion_tol_units
    type:
      - 'null'
      - string
    doc: Precursor ion mass tolerance units (ppm or Da). [ppm]
    inputBinding:
      position: 102
      prefix: --precursor-ion-tol-units
  - id: fragment_ion_tol
    type:
      - 'null'
      - float
    doc: Fragment ion mass tolerance (unit dependent). [0.65]
    inputBinding:
      position: 102
      prefix: --fragment-ion-tol
  - id: precursor_ion_tol
    type:
      - 'null'
      - float
    doc: Precursor ion mass tolerance. [200]
    inputBinding:
      position: 102
      prefix: --precursor-ion-tol
  - id: search_type
    type:
      - 'null'
      - string
    doc: Use monoisotopic or average precursor masses. (monoisotopic or average) [monoisotopic]
    inputBinding:
      position: 102
      prefix: --search-type
  - id: num_missed_cleavages
    type:
      - 'null'
      - int
    doc: Number of missed cleavages allowed [2]
    inputBinding:
      position: 102
      prefix: --num-missed-cleavages
  - id: respect_charges
    type:
      - 'null'
      - boolean
    doc: Dont respect charges in the input file. Instead impute them by trying various options [false]
    inputBinding:
      position: 102
      prefix: --respect-charges
  - id: searched_ions
    type:
      - 'null'
      - string
    doc: Ion series to search
    inputBinding:
      position: 102
      prefix: --searched-ions
  - id: num_peaks_for_multi_isotope_search
    type:
      - 'null'
      - int
    doc: Number of peaks to include in multi-isotope search [0]
    inputBinding:
      position: 102
      prefix: --num-peaks-for-multi-isotope-search
  - id: glyco
    type:
      - 'null'
      - boolean
    doc: Expect N-Glycosylation modifications as variable mod in a search or as a parameter when building
      statistical models [false]
    inputBinding:
      position: 102
      prefix: --glyco
  - id: methionineo
    type:
      - 'null'
      - boolean
    doc: Expect Oxidised Methionine modifications as variable mod in a search [false]
    inputBinding:
      position: 102
      prefix: --methionineo
  - id: carbamidomethyl
    type:
      - 'null'
      - boolean
    doc: Expect Carbamidomethyl C modifications as fixed mod in a search [false]
    inputBinding:
      position: 102
      prefix: --carbamidomethyl
  - id: no_add_retention_times
    type:
      - 'null'
      - boolean
    doc: Don't post process the output to add retention times [true]
    inputBinding:
      position: 102
      prefix: --no-add-retention-times
  - id: max_hit_expect
    type:
      - 'null'
      - float
    doc: Expect values less than this are considered to be hits [1]
    inputBinding:
      position: 102
      prefix: --max-hit-expect
  - id: intensity_cut_off
    type:
      - 'null'
      - float
    doc: Peak intensity cut-off as a fraction of maximum peak intensity [0.0005]
    inputBinding:
      position: 102
      prefix: --intensity-cut-off
  - id: galaxy_index_dir
    type:
      - 'null'
      - Directory
    doc: Specify galaxy index directory, will search for mods file there.
    inputBinding:
      position: 102
      prefix: --galaxy-index-dir
  - id: omx_output
    type:
      - 'null'
      - string
    doc: Specify path for additional OMX output (optional).
    inputBinding:
      position: 102
      prefix: --omx-output
  - id: logfile
    type:
      - 'null'
      - string
    doc: Send OMSSA stdout to a logfile
    inputBinding:
      position: 102
      prefix: --logfile
  - id: output_path
    type: string
    doc: An explicitly named output file.
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: An explicitly named output file.
    outputBinding:
      glob: $(inputs.output_path)
  - id: omx_result
    type:
      - 'null'
      - File
    doc: Additional OMX output
    outputBinding:
      glob: $(inputs.omx_output)
  - id: log_result
    type:
      - 'null'
      - File
    doc: OMSSA stdout log
    outputBinding:
      glob: $(inputs.logfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
