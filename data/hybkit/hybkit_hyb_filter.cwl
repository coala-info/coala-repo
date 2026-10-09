cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyb_filter
label: hybkit_hyb_filter
doc: "Filter hyb (and corresponding fold) files to meet (or exclude) specific criteria.\n\nTool homepage: https://github.com/RenneLab/hybkit"
inputs:
  - id: in_hyb
    type:
      type: array
      items: File
    doc: "Path to one or more hyb-format files with a \".hyb\" suffix."
    inputBinding:
      position: 1
      prefix: -i
  - id: in_fold
    type:
      - 'null'
      - type: array
        items: File
    doc: "Path to one or more RNA secondary-structure files with a \".vienna\" or \".ct\" suffix."
    inputBinding:
      position: 2
      prefix: -f
  - id: out_hyb
    type:
      - 'null'
      - type: array
        items: string
    doc: "Names of one or more hyb-format output files (should include a \".hyb\" suffix); one per input file."
    inputBinding:
      position: 3
      prefix: -o
  - id: out_fold
    type:
      - 'null'
      - type: array
        items: string
    doc: "Names of one or more \".vienna\"/\".ct\" output files; one per fold input file."
    inputBinding:
      position: 3
      prefix: -l
  - id: out_dir
    type:
      - 'null'
      - string
    doc: "Name of a directory for output files (created before the run). Defaults to the current working directory."
    inputBinding:
      position: 3
      prefix: -d
  - id: out_suffix
    type:
      - 'null'
      - string
    doc: "Suffix to add to the name of output files, before any file-type suffix (default: _filtered)."
    inputBinding:
      position: 3
      prefix: -u
  - id: filter_mode
    type:
      - 'null'
      - {type: enum, symbols: ["any", "all"]}
    doc: "Mode for evaluating multiple filters: \"all\" requires all filters to be true; \"any\" requires one (default: all)."
    inputBinding:
      position: 3
      prefix: --filter_mode
  - id: skip_dup_id_before
    type:
      - 'null'
      - boolean
    doc: "Skip sequential duplicate read IDs before filtering."
    inputBinding:
      position: 3
      prefix: --skip_dup_id_before
  - id: skip_dup_id_after
    type:
      - 'null'
      - boolean
    doc: "Skip sequential duplicate read IDs after filtering."
    inputBinding:
      position: 3
      prefix: --skip_dup_id_after
  - id: filter
    type:
      - 'null'
      - type: array
        items: string
    doc: "Filter criteria #1. Records matching the criteria are included in the output. A filter type, for example seg_name_contains, then an argument, for example ENST00000340384."
    inputBinding:
      position: 3
      prefix: --filter
  - id: filter_2
    type:
      - 'null'
      - type: array
        items: string
    doc: "Filter criteria #2. Records matching the criteria are included in the output. A filter type, for example seg_name_contains, then an argument, for example ENST00000340384."
    inputBinding:
      position: 3
      prefix: --filter_2
  - id: filter_3
    type:
      - 'null'
      - type: array
        items: string
    doc: "Filter criteria #3. Records matching the criteria are included in the output. A filter type, for example seg_name_contains, then an argument, for example ENST00000340384."
    inputBinding:
      position: 3
      prefix: --filter_3
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: "Exclusion criteria #1. Records matching the criteria are excluded from the output. A filter type, then an argument."
    inputBinding:
      position: 3
      prefix: --exclude
  - id: exclude_2
    type:
      - 'null'
      - type: array
        items: string
    doc: "Exclusion criteria #2. Records matching the criteria are excluded from the output. A filter type, then an argument."
    inputBinding:
      position: 3
      prefix: --exclude_2
  - id: exclude_3
    type:
      - 'null'
      - type: array
        items: string
    doc: "Exclusion criteria #3. Records matching the criteria are excluded from the output. A filter type, then an argument."
    inputBinding:
      position: 3
      prefix: --exclude_3
  - id: set_dataset
    type:
      - 'null'
      - boolean
    doc: "Set \"dataset\" flag to value of the input file name."
    inputBinding:
      position: 3
      prefix: --set_dataset
  - id: mirna_types
    type:
      - 'null'
      - type: array
        items: string
    doc: "\"seg_type\" fields identifying a miRNA (default: miRNA, microRNA)"
    inputBinding:
      position: 103
      prefix: --mirna_types
  - id: custom_flags
    type:
      - 'null'
      - type: array
        items: string
    doc: "Custom flags to allow in addition to those specified in the hybkit specification."
    inputBinding:
      position: 103
      prefix: --custom_flags
  - id: hyb_placeholder
    type:
      - 'null'
      - string
    doc: "Placeholder character/string for missing data in hyb files (default: .)."
    inputBinding:
      position: 103
      prefix: --hyb_placeholder
  - id: reorder_flags
    type:
      - 'null'
      - {type: enum, symbols: ["True", "False"]}
    doc: "Re-order flags to the hybkit-specification order when writing hyb records: True or False (default: True)."
    inputBinding:
      position: 103
      prefix: --reorder_flags
  - id: allow_undefined_flags
    type:
      - 'null'
      - {type: enum, symbols: ["True", "False"]}
    doc: "Allow use of flags not defined in the hybkit-specification order when reading and writing hyb records: True or False (default: False)."
    inputBinding:
      position: 103
      prefix: --allow_undefined_flags
  - id: allow_unknown_seg_types
    type:
      - 'null'
      - {type: enum, symbols: ["True", "False"]}
    doc: "Allow unknown segment types when assigning segment types: True or False (default: False)."
    inputBinding:
      position: 103
      prefix: --allow_unknown_seg_types
  - id: hybformat_id
    type:
      - 'null'
      - {type: enum, symbols: ["True", "False"]}
    doc: "Parse hyb record identifiers as \"<read_id>_<read_count>\": True or False (default: False)."
    inputBinding:
      position: 103
      prefix: --hybformat_id
  - id: hybformat_ref
    type:
      - 'null'
      - {type: enum, symbols: ["True", "False"]}
    doc: "Parse hyb file identifiers as \"<gene_id>_<transcript_id>_<gene_name>_<seg_type>\": True or False (default: False)."
    inputBinding:
      position: 103
      prefix: --hybformat_ref
  - id: allowed_mismatches
    type:
      - 'null'
      - int
    doc: "For DynamicFoldRecords, allowed number of mismatches with a HybRecord (default: 0)."
    inputBinding:
      position: 103
      prefix: --allowed_mismatches
  - id: fold_placeholder
    type:
      - 'null'
      - string
    doc: "Placeholder character/string for missing data for reading/writing fold records (default: .)."
    inputBinding:
      position: 103
      prefix: --fold_placeholder
  - id: seq_type
    type:
      - 'null'
      - {type: enum, symbols: ["static", "dynamic"]}
    doc: "Type of fold record object to use: \"static\" (exact sequence match) or \"dynamic\" (default: static)."
    inputBinding:
      position: 103
      prefix: --seq_type
  - id: error_mode
    type:
      - 'null'
      - {type: enum, symbols: ["raise", "warn_return", "return"]}
    doc: "Mode for handling errors during reading of HybFiles (default: raise)."
    inputBinding:
      position: 103
      prefix: --error_mode
  - id: error_checks
    type:
      - 'null'
      - type: array
        items: string
    doc: "Error checks for simultaneous HybFile and FoldFile parsing: hybrecord_indel, foldrecord_nofold, max_mismatch, energy_mismatch."
    inputBinding:
      position: 103
      prefix: --error_checks
  - id: iter_error_mode
    type:
      - 'null'
      - {type: enum, symbols: ["raise", "warn_return", "warn_skip", "skip", "return"]}
    doc: "Mode for handling errors found during error checks (default: warn_skip)."
    inputBinding:
      position: 103
      prefix: --iter_error_mode
  - id: max_sequential_skips
    type:
      - 'null'
      - int
    doc: "Maximum number of record(-pairs) to skip in a row (default: 100)."
    inputBinding:
      position: 103
      prefix: --max_sequential_skips
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print verbose output during run."
    inputBinding:
      position: 103
      prefix: --verbose
  - id: silent
    type:
      - 'null'
      - boolean
    doc: "Print no output during run."
    inputBinding:
      position: 103
      prefix: --silent
outputs:
  - id: out_hyb_files
    type:
      type: array
      items: File
    doc: Output hyb-format files written to the working directory.
    outputBinding:
      glob: '*.hyb'
  - id: out_fold_files
    type:
      type: array
      items: File
    doc: Output fold files (vienna or ct) written to the working directory.
    outputBinding:
      glob:
        - '*.vienna'
        - '*.ct'
  - id: out_directory
    type:
      - 'null'
      - Directory
    doc: The directory given with out_dir, with all output files.
    outputBinding:
      glob: $(inputs.out_dir)
  - id: log
    type: stdout
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$(inputs.out_dir ? {'class': 'Directory', 'basename': inputs.out_dir, 'listing': []} : null)"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybkit:0.3.6--pyhdfd78af_0
