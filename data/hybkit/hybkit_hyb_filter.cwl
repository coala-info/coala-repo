cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyb_filter
label: hybkit_hyb_filter
doc: "Filter hyb (and corresponding fold) files to meet (or exclude) specific criteria.\n\
  \nTool homepage: https://github.com/RenneLab/hybkit"
inputs:
  - id: in_fold
    type:
      - 'null'
      - type: array
        items: File
    doc: REQUIRED path to one or more RNA secondary-structure files with a 
      ".vienna" or ".ct" suffix for use in the evaluation.
    inputBinding:
      position: 1
  - id: in_hyb
    type:
      type: array
      items: File
    doc: REQUIRED path to one or more hyb-format files with a ".hyb" suffix for 
      use in the evaluation.
    inputBinding:
      position: 2
  - id: allow_undefined_flags
    type:
      - 'null'
      - boolean
    doc: Allow use of flags not defined in the hybkit- specification order when 
      reading and writing hyb records. As the preferred alternative to using 
      this setting, the --custom_flags argument can be be used to supply custom 
      allowed flags.
    default: false
    inputBinding:
      position: 103
      prefix: --allow_undefined_flags
  - id: allow_unknown_seg_types
    type:
      - 'null'
      - boolean
    doc: Allow unknown segment types when assigning segment types.
    default: false
    inputBinding:
      position: 103
      prefix: --allow_unknown_seg_types
  - id: allowed_mismatches
    type:
      - 'null'
      - int
    doc: For DynamicFoldRecords, allowed number of mismatches with a HybRecord.
    default: 0
    inputBinding:
      position: 103
      prefix: --allowed_mismatches
  - id: custom_flags
    type:
      - 'null'
      - type: array
        items: string
    doc: Custom flags to allow in addition to those specified in the hybkit 
      specification.
    default: []
    inputBinding:
      position: 103
      prefix: --custom_flags
  - id: error_checks
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Error checks for simultaneous HybFile and FoldFile parsing. Options: "hybrecord_indel":
      Error for HybRecord objects where one/both sequences have insertions/deletions
      in alignment, which prevents matching of sequences; "foldrecord_nofold": Error
      when failure in reading a fold_record object; "max_mismatch": Error when mismatch
      between hybrecord and foldrecord sequences is greater than FoldRecord "allowed_mismatches"
      setting; "energy_mismatch": Error when a mismatch exists between HybRecord and
      FoldRecord energy values.'
    default:
      - hybrecord_indel
      - foldrecord_nofold
      - max_mismatch
      - energy_mismatch
    inputBinding:
      position: 103
      prefix: --error_checks
  - id: error_mode
    type:
      - 'null'
      - string
    doc: "Mode for handling errors during reading of HybFiles (overridden by HybFoldIter.settings['iter_error_mode']
      when using HybFoldIter). Options: \"raise\": Raise an error when encountered
      and exit program ; \"warn_return\": Print a warning and return the error_value
      ; \"return\": Return the error value with no program output. record is encountered."
    default: raise
    inputBinding:
      position: 103
      prefix: --error_mode
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Exclusion filter criteria #1. Records matching the criteria will be excluded
      from output. Includes a filter type, Ex: "seg_name_contains", and an argument,
      Ex: "ENST00000340384". (Note: not all filter types require a second argument,
      for Example: "has_mirna_seg")'
    default: None
    inputBinding:
      position: 103
      prefix: --exclude
  - id: exclude_2
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Exclusion filter criteria #2. Records matching the criteria will be excluded
      from output. Includes a filter type, Ex: "seg_name_contains", and an argument,
      Ex: "ENST00000340384". (Note: not all filter types require a second argument,
      for Example: "has_mirna_seg")'
    default: None
    inputBinding:
      position: 103
      prefix: --exclude_2
  - id: exclude_3
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Exclusion filter criteria #3. Records matching the criteria will be excluded
      from output. Includes a filter type, Ex: "seg_name_contains", and an argument,
      Ex: "ENST00000340384". (Note: not all filter types require a second argument,
      for Example: "has_mirna_seg")'
    default: None
    inputBinding:
      position: 103
      prefix: --exclude_3
  - id: filter
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Filter criteria #1. Records matching the criteria will be included in output.
      Includes a filter type, Ex: "seg_name_contains", and an argument, Ex: "ENST00000340384".
      (Note: not all filter types require a second argument, for Example: "has_mirna_seg")'
    default: None
    inputBinding:
      position: 103
      prefix: --filter
  - id: filter_2
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Filter criteria #2. Records matching the criteria will be included in output.
      Includes a filter type, Ex: "seg_name_contains", and an argument, Ex: "ENST00000340384".
      (Note: not all filter types require a second argument, for Example: "has_mirna_seg")'
    default: None
    inputBinding:
      position: 103
      prefix: --filter_2
  - id: filter_3
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Filter criteria #3. Records matching the criteria will be included in output.
      Includes a filter type, Ex: "seg_name_contains", and an argument, Ex: "ENST00000340384".
      (Note: not all filter types require a second argument, for Example: "has_mirna_seg")'
    default: None
    inputBinding:
      position: 103
      prefix: --filter_3
  - id: filter_mode
    type:
      - 'null'
      - string
    doc: 'Modes for evaluating multiple filters. The "all" mode requires all provided
      filters to be true for inclusion. The "any" mode requires only one provided
      filter to be true for inclusion. (Note: matching any exclusion filter is grounds
      for exclusion of record.)'
    default: all
    inputBinding:
      position: 103
      prefix: --filter_mode
  - id: fold_placeholder
    type:
      - 'null'
      - string
    doc: Placeholder character/string for missing data for reading/writing fold 
      records.
    default: .
    inputBinding:
      position: 103
      prefix: --fold_placeholder
  - id: hyb_placeholder
    type:
      - 'null'
      - string
    doc: placeholder character/string for missing data in hyb files.
    default: .
    inputBinding:
      position: 103
      prefix: --hyb_placeholder
  - id: hybformat_id
    type:
      - 'null'
      - boolean
    doc: 'The Hyb Software Package places further information in the "id" field of
      the hybrid record that can be used to infer the number of contained read counts.
      When set to True, the identifiers will be parsed as: "<read_id>_<read_count>"'
    default: false
    inputBinding:
      position: 103
      prefix: --hybformat_id
  - id: hybformat_ref
    type:
      - 'null'
      - boolean
    doc: 'The Hyb Software Package uses a reference database with identifiers that
      contain sequence type and other sequence information. When set to True, all
      hyb file identifiers will be parsed as: "<gene_id>_<transcript_id>_<gene_name>_<seg_type>"'
    default: false
    inputBinding:
      position: 103
      prefix: --hybformat_ref
  - id: iter_error_mode
    type:
      - 'null'
      - string
    doc: 'Mode for handling errors found during error checks. Overrides HybRecord
      "error_mode" setting when using HybFoldIter. Options: "raise": Raise an error
      when encountered; "warn_return": Print a warning and return the value; "warn_skip":
      Print a warning and continue to the next iteration; "skip": Continue to the
      next iteration without any output; "return": return the value without any error
      output;'
    default: warn_skip
    inputBinding:
      position: 103
      prefix: --iter_error_mode
  - id: max_sequential_skips
    type:
      - 'null'
      - int
    doc: Maximum number of record(-pairs) to skip in a row. Limited as several 
      sequential skips usually indicates an issue with record formatting or a 
      desynchronization between files.
    default: 100
    inputBinding:
      position: 103
      prefix: --max_sequential_skips
  - id: mirna_types
    type:
      - 'null'
      - type: array
        items: string
    doc: '"seg_type" fields identifying a miRNA'
    default:
      - miRNA
      - microRNA
    inputBinding:
      position: 103
      prefix: --mirna_types
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Path to directory for output of files. Defaults to the current working 
      directory.
    default: $PWD
    inputBinding:
      position: 103
      prefix: --out_dir
  - id: out_suffix
    type:
      - 'null'
      - string
    doc: Suffix to add to the name of output files, before any file- or 
      analysis-specific suffixes. The file-type appropriate suffix will be added
      automatically.
    default: _filtered
    inputBinding:
      position: 103
      prefix: --out_suffix
  - id: reorder_flags
    type:
      - 'null'
      - boolean
    doc: Re-order flags to the hybkit-specification order when writing hyb 
      records.
    default: true
    inputBinding:
      position: 103
      prefix: --reorder_flags
  - id: seq_type
    type:
      - 'null'
      - string
    doc: 'Type of fold record object to use. Options: "static": FoldRecord, requires
      an exact sequence match to be paired with a HybRecord; "dynamic": DynamicFoldRecord,
      requires a sequence match to the "dynamic" annotated regions of a HybRecord,
      and may be shorter/longer than the original sequence.'
    default: static
    inputBinding:
      position: 103
      prefix: --seq_type
  - id: set_dataset
    type:
      - 'null'
      - boolean
    doc: Set "dataset" flag to value of the input file name.
    default: false
    inputBinding:
      position: 103
      prefix: --set_dataset
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Print no output during run.
    default: false
    inputBinding:
      position: 103
      prefix: --silent
  - id: skip_dup_id_after
    type:
      - 'null'
      - boolean
    doc: Skip sequential duplicate read IDs after filtering.
    default: false
    inputBinding:
      position: 103
      prefix: --skip_dup_id_after
  - id: skip_dup_id_before
    type:
      - 'null'
      - boolean
    doc: Skip sequential duplicate read IDs before filtering.
    default: false
    inputBinding:
      position: 103
      prefix: --skip_dup_id_before
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose output during run.
    default: false
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: out_hyb
    type:
      - 'null'
      - File
    doc: Optional path to one or more hyb-format file for output (should include
      a ".hyb" suffix). If not provided, the output for input file 
      "PATH_TO/MY_FILE.HYB" will be used as a template for the output 
      "OUT_DIR/MY_FILE_OUT.HYB".
    outputBinding:
      glob: '*.out'
  - id: out_fold
    type:
      - 'null'
      - File
    doc: Optional path to one or more ".vienna" or ".ct"-format files for output
      (should include appropriate ".vienna"/".ct" suffix). If not provided, the 
      output for input file "PATH_TO/MY_FILE.VIENNA" will be used as a template 
      for the output "OUT_DIR/MY_FILE_OUT.VIENNA".
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybkit:0.3.6--pyhdfd78af_0
