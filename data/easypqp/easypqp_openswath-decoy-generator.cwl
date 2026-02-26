cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - easypqp
  - openswath-decoy-generator
label: easypqp_openswath-decoy-generator
doc: "Generate decoys for spectral libraries / transition files for targeted proteomics
  and metabolomics analysis.\n\nTool homepage: https://github.com/grosenberger/easypqp"
inputs:
  - id: aim_decoy_fraction
    type:
      - 'null'
      - float
    doc: Number of decoys the algorithm should generate (if unequal to 1, the 
      algorithm will randomly select N peptides for decoy generation)
    inputBinding:
      position: 101
      prefix: --aim_decoy_fraction
  - id: allowed_fragment_charges
    type:
      - 'null'
      - string
    doc: allowed fragment charge states
    inputBinding:
      position: 101
      prefix: --allowed_fragment_charges
  - id: allowed_fragment_types
    type:
      - 'null'
      - string
    doc: allowed fragment types
    inputBinding:
      position: 101
      prefix: --allowed_fragment_types
  - id: decoy_tag
    type:
      - 'null'
      - string
    doc: Decoy tag.
    default: DECOY_
    inputBinding:
      position: 101
      prefix: --decoy_tag
  - id: disable_detection_specific_losses
    type:
      - 'null'
      - boolean
    doc: set this flag if specific neutral losses for detection fragment ions 
      should be allowed
    inputBinding:
      position: 101
      prefix: --disable_detection_specific_losses
  - id: disable_detection_unspecific_losses
    type:
      - 'null'
      - boolean
    doc: set this flag if unspecific neutral losses (H2O1, H3N1, C1H2N2, 
      C1H2N1O1) for detection fragment ions should be allowed
    inputBinding:
      position: 101
      prefix: --disable_detection_unspecific_losses
  - id: enable_detection_specific_losses
    type:
      - 'null'
      - boolean
    doc: set this flag if specific neutral losses for detection fragment ions 
      should be allowed
    inputBinding:
      position: 101
      prefix: --enable_detection_specific_losses
  - id: enable_detection_unspecific_losses
    type:
      - 'null'
      - boolean
    doc: set this flag if unspecific neutral losses (H2O1, H3N1, C1H2N2, 
      C1H2N1O1) for detection fragment ions should be allowed
    inputBinding:
      position: 101
      prefix: --enable_detection_unspecific_losses
  - id: in_file
    type: File
    doc: Input file to generate decoys for.
    inputBinding:
      position: 101
      prefix: --in
  - id: in_type
    type:
      - 'null'
      - string
    doc: 'Input file type. Default: None, will be determined from input file. Valid
      formats: ["tsv", "mrm" ,"pqp", "TraML"]'
    default: None
    inputBinding:
      position: 101
      prefix: --in_type
  - id: method
    type:
      - 'null'
      - string
    doc: 'Decoy generation method. Valid methods: "shuffle", "pseudo-reverse", "reverse",
      "shift'
    default: shuffle
    inputBinding:
      position: 101
      prefix: --method
  - id: min_decoy_fraction
    type:
      - 'null'
      - float
    doc: Minimum fraction of decoy / target peptides and proteins
    inputBinding:
      position: 101
      prefix: --min_decoy_fraction
  - id: no_separate
    type:
      - 'null'
      - boolean
    doc: set this flag if decoys should not be appended to targets.
    inputBinding:
      position: 101
      prefix: --no_separate
  - id: no_switchKR
    type:
      - 'null'
      - boolean
    doc: Whether to switch terminal K and R (to achieve different precursor 
      mass)
    inputBinding:
      position: 101
      prefix: --no_switchKR
  - id: out_type
    type:
      - 'null'
      - string
    doc: 'Output file type. Default: None, will be determined from output file. Valid
      formats: ["tsv", "pqp", "TraML"]'
    default: None
    inputBinding:
      position: 101
      prefix: --out_type
  - id: product_mz_threshold
    type:
      - 'null'
      - float
    doc: MZ threshold in Thomson for fragment ion annotation
    inputBinding:
      position: 101
      prefix: --product_mz_threshold
  - id: separate
    type:
      - 'null'
      - boolean
    doc: set this flag if decoys should not be appended to targets.
    inputBinding:
      position: 101
      prefix: --separate
  - id: shift_precursor_mz_shift
    type:
      - 'null'
      - float
    doc: 'shift: precursor ion MZ shift in Thomson for shift decoy method'
    inputBinding:
      position: 101
      prefix: --shift_precursor_mz_shift
  - id: shift_product_mz_shift
    type:
      - 'null'
      - float
    doc: 'shift: fragment ion MZ shift in Thomson for shift decoy method'
    inputBinding:
      position: 101
      prefix: --shift_product_mz_shift
  - id: shuffle_max_attempts
    type:
      - 'null'
      - int
    doc: 'shuffle: maximum attempts to lower the amino acid sequence identity between
      target and decoy for the shuffle algorithm'
    inputBinding:
      position: 101
      prefix: --shuffle_max_attempts
  - id: shuffle_sequence_identity_threshold
    type:
      - 'null'
      - float
    doc: 'shuffle: target-decoy amino acid sequence identity threshold for the shuffle
      algorithm'
    inputBinding:
      position: 101
      prefix: --shuffle_sequence_identity_threshold
  - id: switchKR
    type:
      - 'null'
      - boolean
    doc: Whether to switch terminal K and R (to achieve different precursor 
      mass)
    inputBinding:
      position: 101
      prefix: --switchKR
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: Output file to be converted to.
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/easypqp:0.1.56--pyhdfd78af_0
