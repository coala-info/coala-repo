cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - onsite
  - lucxor
label: pyonsite_lucxor
doc: "Modification site localization using pyLuciPHOr2 algorithm.\n\nTool homepage: https://www.github.com/bigbio/onsite"
inputs:
  - id: input_spectrum
    type: File
    doc: Input spectrum file (mzML)
    inputBinding:
      position: 1
      prefix: -in
  - id: input_id
    type: File
    doc: Input identification file (idXML)
    inputBinding:
      position: 2
      prefix: -id
  - id: output
    type: string
    doc: Output file (idXML)
    inputBinding:
      position: 3
      prefix: -out
  - id: fragment_method
    type:
      - 'null'
      - type: enum
        symbols: [cid, hcd]
    doc: 'Fragmentation method (default: CID)'
    inputBinding:
      position: 4
      prefix: --fragment-method
  - id: fragment_mass_tolerance
    type: ['null', float]
    doc: 'Tolerance of the peaks in the fragment spectrum (default: 0.5)'
    inputBinding:
      position: 5
      prefix: --fragment-mass-tolerance
  - id: fragment_error_units
    type:
      - 'null'
      - type: enum
        symbols: [da, ppm]
    doc: 'Unit of fragment mass tolerance (default: Da)'
    inputBinding:
      position: 6
      prefix: --fragment-error-units
  - id: min_mz
    type: ['null', float]
    doc: 'Do not consider peaks below this value (default: 150.0)'
    inputBinding:
      position: 7
      prefix: --min-mz
  - id: target_modifications
    type: ['null', string]
    doc: 'List of target modifications (default: Phospho (S), Phospho (T), Phospho (Y))'
    inputBinding:
      position: 8
      prefix: --target-modifications
  - id: neutral_losses
    type: ['null', string]
    doc: 'List of neutral losses (default: sty -H3PO4 -97.97690)'
    inputBinding:
      position: 9
      prefix: --neutral-losses
  - id: decoy_mass
    type: ['null', float]
    doc: 'Mass to add for decoy generation (default: 79.966331)'
    inputBinding:
      position: 10
      prefix: --decoy-mass
  - id: decoy_neutral_losses
    type: ['null', string]
    doc: 'List of decoy neutral losses (default: X -H3PO4 -97.97690)'
    inputBinding:
      position: 11
      prefix: --decoy-neutral-losses
  - id: max_charge_state
    type: ['null', int]
    doc: 'Maximum charge state to consider (default: 5)'
    inputBinding:
      position: 12
      prefix: --max-charge-state
  - id: max_peptide_length
    type: ['null', int]
    doc: 'Maximum peptide length (default: 40)'
    inputBinding:
      position: 13
      prefix: --max-peptide-length
  - id: max_num_perm
    type: ['null', int]
    doc: 'Maximum number of permutations (default: 16384)'
    inputBinding:
      position: 14
      prefix: --max-num-perm
  - id: modeling_score_threshold
    type: ['null', float]
    doc: 'Minimum score for modeling (default: 0.95)'
    inputBinding:
      position: 15
      prefix: --modeling-score-threshold
  - id: scoring_threshold
    type: ['null', float]
    doc: 'Minimum score threshold (default: 0.0)'
    inputBinding:
      position: 16
      prefix: --scoring-threshold
  - id: min_num_psms_model
    type: ['null', int]
    doc: 'Minimum number of PSMs for modeling (default: 50)'
    inputBinding:
      position: 17
      prefix: --min-num-psms-model
  - id: threads
    type: ['null', int]
    doc: 'Number of threads to use (default: 1)'
    inputBinding:
      position: 18
      prefix: --threads
  - id: rt_tolerance
    type: ['null', float]
    doc: 'Retention time tolerance (default: 0.01)'
    inputBinding:
      position: 19
      prefix: --rt-tolerance
  - id: debug
    type: ['null', boolean]
    doc: Enable debug mode
    inputBinding:
      position: 20
      prefix: --debug
  - id: log_file
    type: ['null', string]
    doc: 'Log file path (only used in debug mode, default: {output_base}_debug.log)'
    inputBinding:
      position: 21
      prefix: --log-file
  - id: disable_split_by_charge
    type: ['null', boolean]
    doc: Disable splitting PSMs by charge state for model training (train a single global model)
    inputBinding:
      position: 22
      prefix: --disable-split-by-charge
  - id: compute_all_scores
    type: ['null', boolean]
    doc: Run all three algorithms (AScore, PhosphoRS, LucXor) and merge results
    inputBinding:
      position: 23
      prefix: --compute-all-scores
outputs:
  - id: output_file
    type: File
    doc: Output idXML file with localization scores
    outputBinding:
      glob: $(inputs.output)
  - id: debug_log
    type: ['null', 'File[]']
    doc: Debug log files written when --debug is set
    outputBinding:
      glob: '*.log'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyonsite:0.0.2--pyhdfd78af_0
