cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyb_check
label: hybkit_hyb_check
doc: "Read one or more hyb (and optional fold) format files and check for errors.\n\
  \nTool homepage: https://github.com/RenneLab/hybkit"
inputs:
  - id: input_hyb
    type:
      type: array
      items: File
    doc: path to one or more hyb-format files with a ".hyb" suffix for use in 
      the evaluation.
    inputBinding:
      position: 1
  - id: input_fold
    type:
      - 'null'
      - type: array
        items: File
    doc: path to one or more RNA secondary-structure files with a ".vienna" or 
      ".ct" suffix for use in the evaluation.
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
    inputBinding:
      position: 103
      prefix: --allow_undefined_flags
  - id: allow_unknown_seg_types
    type:
      - 'null'
      - boolean
    doc: Allow unknown segment types when assigning segment types.
    inputBinding:
      position: 103
      prefix: --allow_unknown_seg_types
  - id: allowed_mismatches
    type:
      - 'null'
      - int
    doc: For DynamicFoldRecords, allowed number of mismatches with a HybRecord.
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
    inputBinding:
      position: 103
      prefix: --error_mode
  - id: fold_placeholder
    type:
      - 'null'
      - string
    doc: Placeholder character/string for missing data for reading/writing fold 
      records.
    inputBinding:
      position: 103
      prefix: --fold_placeholder
  - id: hyb_placeholder
    type:
      - 'null'
      - string
    doc: placeholder character/string for missing data in hyb files.
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
    inputBinding:
      position: 103
      prefix: --max_sequential_skips
  - id: mirna_types
    type:
      - 'null'
      - type: array
        items: string
    doc: '"seg_type" fields identifying a miRNA'
      - miRNA
      - microRNA
    inputBinding:
      position: 103
      prefix: --mirna_types
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: 'The output directory defaults to the current working directory ($PWD), and
      can be modified with the --out_dir <dir> argument. Note: The provided directory
      must exist, or an error will be raised.'
    inputBinding:
      position: 103
      prefix: --out_dir
  - id: out_suffix
    type:
      - 'null'
      - string
    doc: The suffix used for output files is based on the primary actions of the
      script. It can be specified using --out_suffix <suffix>. This can 
      optionally include the ".hyb" final suffix.
    inputBinding:
      position: 103
      prefix: --out_suffix
  - id: reorder_flags
    type:
      - 'null'
      - boolean
    doc: Re-order flags to the hybkit-specification order when writing hyb 
      records.
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
    inputBinding:
      position: 103
      prefix: --seq_type
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Print no output during run.
    inputBinding:
      position: 103
      prefix: --silent
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose output during run.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: out_hyb
    type:
      - 'null'
      - File
    doc: Alternatively, specific file names can be provided via the -o/--out_hyb
      argument, ensuring that the same number of input and output files are 
      provided. This argument takes precedence over all automatic output file 
      naming options (--out_dir, --out_suffix), which are ignored if 
      -o/--out_hyb is provided.
    outputBinding:
      glob: $(inputs.out_hyb)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybkit:0.3.6--pyhdfd78af_0
