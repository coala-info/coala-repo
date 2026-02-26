cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyb_analyze
label: hybkit_hyb_analyze
doc: "Read hyb / vienna files and analyze the fold information in the contained hybrid
  sequences.\n\nTool homepage: https://github.com/RenneLab/hybkit"
inputs:
  - id: in_hyb
    type:
      type: array
      items: File
    doc: path to one or more hyb-format files with a ".hyb" suffix for use in 
      the evaluation.
    inputBinding:
      position: 1
  - id: in_fold
    type:
      type: array
      items: File
    doc: path to one or more RNA secondary-structure files with a ".vienna" or 
      ".ct" suffix for use in the evaluation.
    inputBinding:
      position: 2
  - id: out_basename
    type:
      - 'null'
      - type: array
        items: string
    doc: Optional path to one or more basename prefixes to use for output. The 
      appropriate suffix will be added based on the specific name. If not 
      provided, the output for input file "PATH_TO/MY_FILE.HYB" will be used as 
      a template for the basename "OUT_DIR/MY_FILE".
    inputBinding:
      position: 3
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
      position: 104
      prefix: --allow_undefined_flags
  - id: allow_unknown_seg_types
    type:
      - 'null'
      - boolean
    doc: Allow unknown segment types when assigning segment types.
    default: false
    inputBinding:
      position: 104
      prefix: --allow_unknown_seg_types
  - id: allowed_mismatches
    type:
      - 'null'
      - int
    doc: For DynamicFoldRecords, allowed number of mismatches with a HybRecord.
    default: 0
    inputBinding:
      position: 104
      prefix: --allowed_mismatches
  - id: analysis_name
    type:
      - 'null'
      - string
    doc: Name / title of analysis data.
    inputBinding:
      position: 104
      prefix: --analysis_name
  - id: analysis_types
    type:
      - 'null'
      - type: array
        items: string
    doc: Analysis to perform on input hyb and fold files.
    default:
      - fold
    inputBinding:
      position: 104
      prefix: --analysis_types
  - id: custom_flags
    type:
      - 'null'
      - type: array
        items: string
    doc: Custom flags to allow in addition to those specified in the hybkit 
      specification.
    default: []
    inputBinding:
      position: 104
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
      position: 104
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
      position: 104
      prefix: --error_mode
  - id: fold_placeholder
    type:
      - 'null'
      - string
    doc: Placeholder character/string for missing data for reading/writing fold 
      records.
    default: .
    inputBinding:
      position: 104
      prefix: --fold_placeholder
  - id: hyb_placeholder
    type:
      - 'null'
      - string
    doc: placeholder character/string for missing data in hyb files.
    default: .
    inputBinding:
      position: 104
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
      position: 104
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
      position: 104
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
      position: 104
      prefix: --iter_error_mode
  - id: make_plots
    type:
      - 'null'
      - boolean
    doc: Create plots of analysis output.
    default: true
    inputBinding:
      position: 104
      prefix: --make_plots
  - id: max_sequential_skips
    type:
      - 'null'
      - int
    doc: Maximum number of record(-pairs) to skip in a row. Limited as several 
      sequential skips usually indicates an issue with record formatting or a 
      desynchronization between files.
    default: 100
    inputBinding:
      position: 104
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
      position: 104
      prefix: --mirna_types
  - id: out_delim
    type:
      - 'null'
      - string
    doc: Delimiter-string to place between fields in analysis output.
    default: ','
    inputBinding:
      position: 104
      prefix: --out_delim
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Path to directory for output of files. Defaults to the current working 
      directory.
    default: $PWD
    inputBinding:
      position: 104
      prefix: --out_dir
  - id: out_suffix
    type:
      - 'null'
      - string
    doc: Suffix to add to the name of output files, before any file- or 
      analysis-specific suffixes. The file-type appropriate suffix will be added
      automatically.
    inputBinding:
      position: 104
      prefix: --out_suffix
  - id: quant_mode
    type:
      - 'null'
      - string
    doc: 'Method for counting records. Options: "single": Count each record as a single
      entry; "reads": Use the number of reads per hyb record as the count (may contain
      PCR duplicates); "records": Count the number of records represented by each
      hyb record entry (1 for "unmerged" records, >= 1 for "merged" records)'
    default: single
    inputBinding:
      position: 104
      prefix: --quant_mode
  - id: reorder_flags
    type:
      - 'null'
      - boolean
    doc: Re-order flags to the hybkit-specification order when writing hyb 
      records.
    default: true
    inputBinding:
      position: 104
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
      position: 104
      prefix: --seq_type
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Print no output during run.
    default: false
    inputBinding:
      position: 104
      prefix: --silent
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose output during run.
    default: false
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybkit:0.3.6--pyhdfd78af_0
stdout: hybkit_hyb_analyze.out
