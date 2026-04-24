cwlVersion: v1.2
class: CommandLineTool
baseCommand: easypqp openswath-assay-generator
label: easypqp_openswath-assay-generator
doc: "Generates filtered and optimized assays for OpenSwathWorflow\n\nTool homepage:
  https://github.com/grosenberger/easypqp"
inputs:
  - id: allowed_fragment_charges
    type:
      - 'null'
      - string
    doc: Allowed fragment charge states
    inputBinding:
      position: 101
      prefix: --allowed_fragment_charges
  - id: allowed_fragment_types
    type:
      - 'null'
      - string
    doc: Allowed fragment types
    inputBinding:
      position: 101
      prefix: --allowed_fragment_types
  - id: disable_identification_ms2_precursors
    type:
      - 'null'
      - boolean
    doc: 'IPF: set this flag if MS2-level precursor ions for identification should
      not be allowed for extraction of the precursor signal from the fragment ion
      data (MS2-level).'
    inputBinding:
      position: 101
      prefix: --disable_identification_ms2_precursors
  - id: disable_identification_specific_losses
    type:
      - 'null'
      - boolean
    doc: 'IPF: set this flag if specific neutral losses for identification fragment
      ions should not be allowed'
    inputBinding:
      position: 101
      prefix: --disable_identification_specific_losses
  - id: enable_detection_specific_losses
    type:
      - 'null'
      - boolean
    doc: Set this flag if specific neutral losses for detection fragment ions 
      should be allowed
    inputBinding:
      position: 101
      prefix: --enable_detection_specific_losses
  - id: enable_detection_unspecific_losses
    type:
      - 'null'
      - boolean
    doc: Set this flag if unspecific neutral losses (H2O1, H3N1, C1H2N2, 
      C1H2N1O1) for detection fragment ions should be allowed
    inputBinding:
      position: 101
      prefix: --enable_detection_unspecific_losses
  - id: enable_identification_unspecific_losses
    type:
      - 'null'
      - boolean
    doc: 'IPF: set this flag if unspecific neutral losses (H2O1, H3N1, C1H2N2, C1H2N1O1)
      for identification fragment ions should be allowed'
    inputBinding:
      position: 101
      prefix: --enable_identification_unspecific_losses
  - id: enable_ipf
    type:
      - 'null'
      - boolean
    doc: "IPF: set this flag if identification transitions should be generated for
      IPF. Note: Requires setting 'unimod_file'"
    inputBinding:
      position: 101
      prefix: --enable_ipf
  - id: enable_swath_specifity
    type:
      - 'null'
      - boolean
    doc: 'IPF: set this flag if identification transitions without precursor specificity
      (i.e. across whole precursor isolation window instead of precursor MZ) should
      be generated.'
    inputBinding:
      position: 101
      prefix: --enable_swath_specifity
  - id: in
    type: File
    doc: "Input file (valid formats: 'tsv', 'mrm', 'pqp', 'TraML')"
    inputBinding:
      position: 101
      prefix: --in
  - id: in_type
    type:
      - 'null'
      - string
    doc: 'Input file type. Default: None, will be determined from file extension or
      content. Valid formats: ["tsv", "mrm" ,"pqp", "TraML"]'
    inputBinding:
      position: 101
      prefix: --in_type
  - id: max_num_alternative_localizations
    type:
      - 'null'
      - int
    doc: 'IPF: maximum number of site-localization permutations'
    inputBinding:
      position: 101
      prefix: --max_num_alternative_localizations
  - id: max_transitions
    type:
      - 'null'
      - int
    doc: Maximal number of transitions
    inputBinding:
      position: 101
      prefix: --max_transitions
  - id: min_transitions
    type:
      - 'null'
      - int
    doc: Minimal number of transitions
    inputBinding:
      position: 101
      prefix: --min_transitions
  - id: out_type
    type:
      - 'null'
      - string
    doc: 'Output file type. Default: None, will be determined from file extension
      or content. Valid formats: ["tsv", "mrm" ,"pqp", "TraML"]'
    inputBinding:
      position: 101
      prefix: --out_type
  - id: precursor_lower_mz_limit
    type:
      - 'null'
      - float
    doc: Lower MZ limit for precursor ions
    inputBinding:
      position: 101
      prefix: --precursor_lower_mz_limit
  - id: precursor_mz_threshold
    type:
      - 'null'
      - float
    doc: MZ threshold in Thomson for precursor ion selection
    inputBinding:
      position: 101
      prefix: --precursor_mz_threshold
  - id: precursor_upper_mz_limit
    type:
      - 'null'
      - float
    doc: Upper MZ limit for precursor ions
    inputBinding:
      position: 101
      prefix: --precursor_upper_mz_limit
  - id: product_lower_mz_limit
    type:
      - 'null'
      - float
    doc: Lower MZ limit for fragment ions
    inputBinding:
      position: 101
      prefix: --product_lower_mz_limit
  - id: product_mz_threshold
    type:
      - 'null'
      - float
    doc: MZ threshold in Thomson for fragment ion annotation
    inputBinding:
      position: 101
      prefix: --product_mz_threshold
  - id: product_upper_mz_limit
    type:
      - 'null'
      - float
    doc: Upper MZ limit for fragment ions
    inputBinding:
      position: 101
      prefix: --product_upper_mz_limit
  - id: swath_windows_file
    type:
      - 'null'
      - File
    doc: "Tab separated file containing the SWATH windows for exclusion of fragment
      ions falling into the precursor isolation window: lower_offset upper_offset
      ewline400 425 ewline ... Note that the first line is a header and will be skipped.
      (valid formats: 'txt')"
    inputBinding:
      position: 101
      prefix: --swath_windows_file
  - id: unimod_file
    type:
      - 'null'
      - File
    doc: "(Modified) Unimod XML file (http://www.unimod.org/xml/unimod.xml) describing
      residue modifiability (valid formats: 'xml')"
    inputBinding:
      position: 101
      prefix: --unimod_file
outputs:
  - id: out
    type: File
    doc: "Output file (valid formats: 'tsv', 'pqp', 'TraML')"
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/easypqp:0.1.56--pyhdfd78af_0
