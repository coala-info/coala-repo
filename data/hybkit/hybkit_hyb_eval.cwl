cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyb_eval
label: hybkit_hyb_eval
doc: "Read hyb files (and optional matched fold files) and evaluate the contained
  hybrids.\n\nThis utility reads in one or more files in hyb-format\n(see the Hybkit
  Hyb File Specification) and corresponding fold files\n(.vienna or .ct) and evaluates
  hybrid record properties.\n\nEvaluation Types:\n\n    \"type\"   Assigns types to
  each segment within hyb records\n    \"mirna\"  Assigns which segments are a miRNA
  based on segment types.\n\n\"type\" Evaluation:\n     The 'type' evaluation utilizes
  the :func:hybkit.HybRecord.eval_types method\n        to assign the record flags:
  seg1_type <seg1_type> \n        and seg2_type <seg2_type> \n\n    Example system
  calls:\n\n            $ hyb_eval -t type -i my_file_1.hyb\n\n            $ hyb_eval
  -t type -i my_file_1.hyb -f my_file_1.vienna\n\n            $ hyb_eval -t type \\\
  \n                        -i my_file_1.hyb my_file_2.hyb \\\n                  \
  \      -f my_file_1.vienna my_file_2.vienna \\\n                        --type_method
  string_match \\\n                        --type_parameters my_parameters_file.csv
  \\\n                        --allow_unknown_seg_types\n\n\"mirna\" Evaluation:\n\
  \     The 'mirna' evaluation uses the :func:hybkit.HybRecord.eval_mirna method\n\
  \        to identify properties relating to mirna within the hybrids,\n        including
  mirna presence and positions.\n        This evaluation requires the seg_type flags
  to be filled, either by a type evaluation, \n        or by parsing the read using
  the \"--hybformat_ref True\" option with a hyb-format\n        reference. The mirna_seg
  <mirna_seg> flag is then set for each record, indicating\n        the presence and
  position of any miRNA within the hybrid.\n\n    Example system calls:\n\n      \
  \      $ hyb_eval -t mirna -i my_file_1.hyb\n\n            $ hyb_eval -t mirna -i
  my_file_1.hyb -f my_file_1.vienna\n\n            $ hyb_eval -t mirna -i my_file_1.hyb
  my_vile_2.hyb \\\n                        -f my_file_1.vienna my_file_2.vienna \\\
  \n                        --mirna_types miRNA kshv-miRNA\n\n    This can also be
  combined with the type evaluation, as such:\n\n            $ hyb_eval -t type mirna
  -i my_file_1.hyb \\\n                        --type_method string_match \\\n   \
  \                     --type_parameters my_parameters_file.csv \\\n            \
  \            --allow_unknown_seg_types \\\n                        --mirna_types
  miRNA kshv-miRNA\n\nTool homepage: https://github.com/RenneLab/hybkit"
inputs:
  - id: in_hyb
    type:
      type: array
      items: File
    doc: "REQUIRED path to one or more hyb-format files with a\n                 \
      \       \".hyb\" suffix for use in the evaluation."
    inputBinding:
      position: 1
  - id: in_fold
    type:
      - 'null'
      - type: array
        items: File
    doc: "REQUIRED path to one or more RNA secondary-structure\n                 \
      \       files with a \".vienna\" or \".ct\" suffix for use in the\n        \
      \                evaluation."
    inputBinding:
      position: 2
  - id: allow_undefined_flags
    type:
      - 'null'
      - boolean
    doc: "Allow use of flags not defined in the hybkit-\n                        specification
      order when reading and writing hyb\n                        records. As the
      preferred alternative to using this\n                        setting, the --custom_flags
      argument can be be used to\n                        supply custom allowed flags."
    inputBinding:
      position: 103
      prefix: --allow_undefined_flags
  - id: allow_unknown_seg_types
    type:
      - 'null'
      - boolean
    doc: "Allow unknown segment types when assigning segment\n                   \
      \     types."
    inputBinding:
      position: 103
      prefix: --allow_unknown_seg_types
  - id: allowed_mismatches
    type:
      - 'null'
      - int
    doc: "For DynamicFoldRecords, allowed number of mismatches\n                 \
      \       with a HybRecord."
    inputBinding:
      position: 103
      prefix: --allowed_mismatches
  - id: custom_flags
    type:
      - 'null'
      - type: array
        items: string
    doc: "Custom flags to allow in addition to those specified\n                 \
      \       in the hybkit specification."
    inputBinding:
      position: 103
      prefix: --custom_flags
  - id: error_checks
    type:
      - 'null'
      - type: array
        items: string
    doc: "Error checks for simultaneous HybFile and FoldFile\n                   \
      \     parsing. Options: \"hybrecord_indel\": Error for\n                   \
      \     HybRecord objects where one/both sequences have\n                    \
      \    insertions/deletions in alignment, which prevents\n                   \
      \     matching of sequences; \"foldrecord_nofold\": Error when\n           \
      \             failure in reading a fold_record object;\n                   \
      \     \"max_mismatch\": Error when mismatch between hybrecord\n            \
      \            and foldrecord sequences is greater than FoldRecord\n         \
      \               \"allowed_mismatches\" setting; \"energy_mismatch\": Error\n\
      \                        when a mismatch exists between HybRecord and\n    \
      \                    FoldRecord energy values."
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
    doc: "Mode for handling errors during reading of HybFiles\n                  \
      \      (overridden by HybFoldIter.settings['iter_error_mode']\n            \
      \            when using HybFoldIter). Options: \"raise\": Raise an\n       \
      \                 error when encountered and exit program ;\n              \
      \          \"warn_return\": Print a warning and return the\n               \
      \         error_value ; \"return\": Return the error value with no\n       \
      \                 program output. record is encountered."
    inputBinding:
      position: 103
      prefix: --error_mode
  - id: eval_types
    type:
      - 'null'
      - type: array
        items: string
    doc: "Types of evaluations to perform on input hyb file.\n                   \
      \     (Note: evaluations can be combined, such as \"--\n                   \
      \     eval_types type mirna\")"
      - type
    inputBinding:
      position: 103
      prefix: --eval_types
  - id: fold_placeholder
    type:
      - 'null'
      - string
    doc: "Placeholder character/string for missing data for\n                    \
      \    reading/writing fold records."
    inputBinding:
      position: 103
      prefix: --fold_placeholder
  - id: hyb_placeholder
    type:
      - 'null'
      - string
    doc: "placeholder character/string for missing data in hyb\n                 \
      \       files."
    inputBinding:
      position: 103
      prefix: --hyb_placeholder
  - id: hybformat_id
    type:
      - 'null'
      - boolean
    doc: "The Hyb Software Package places further information in\n               \
      \         the \"id\" field of the hybrid record that can be used\n         \
      \               to infer the number of contained read counts. When set\n   \
      \                     to True, the identifiers will be parsed as:\n        \
      \                \"<read_id>_<read_count>\""
    inputBinding:
      position: 103
      prefix: --hybformat_id
  - id: hybformat_ref
    type:
      - 'null'
      - boolean
    doc: "The Hyb Software Package uses a reference database\n                   \
      \     with identifiers that contain sequence type and other\n              \
      \          sequence information. When set to True, all hyb file\n          \
      \              identifiers will be parsed as:\n                        \"<gene_id>_<transcript_id>_<gene_name>_<seg_type>\""
    inputBinding:
      position: 103
      prefix: --hybformat_ref
  - id: iter_error_mode
    type:
      - 'null'
      - string
    doc: "Mode for handling errors found during error checks.\n                  \
      \      Overrides HybRecord \"error_mode\" setting when using\n             \
      \           HybFoldIter. Options: \"raise\": Raise an error when\n         \
      \               encountered; \"warn_return\": Print a warning and return\n \
      \                       the value; \"warn_skip\": Print a warning and continue\n\
      \                        to the next iteration; \"skip\": Continue to the next\n\
      \                        iteration without any output; \"return\": return the\n\
      \                        value without any error output;"
    inputBinding:
      position: 103
      prefix: --iter_error_mode
  - id: max_sequential_skips
    type:
      - 'null'
      - int
    doc: "Maximum number of record(-pairs) to skip in a row.\n                   \
      \     Limited as several sequential skips usually indicates\n              \
      \          an issue with record formatting or a desynchronization\n        \
      \                between files."
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
    doc: "Path to directory for output of files. Defaults to the\n               \
      \         current working directory."
    inputBinding:
      position: 103
      prefix: --out_dir
  - id: out_suffix
    type:
      - 'null'
      - string
    doc: "Suffix to add to the name of output files, before any\n                \
      \        file- or analysis-specific suffixes. The file-type\n              \
      \          appropriate suffix will be added automatically."
    inputBinding:
      position: 103
      prefix: --out_suffix
  - id: reorder_flags
    type:
      - 'null'
      - boolean
    doc: "Re-order flags to the hybkit-specification order when\n                \
      \        writing hyb records."
    inputBinding:
      position: 103
      prefix: --reorder_flags
  - id: seq_type
    type:
      - 'null'
      - string
    doc: "Type of fold record object to use. Options: \"static\":\n              \
      \          FoldRecord, requires an exact sequence match to be\n            \
      \            paired with a HybRecord; \"dynamic\": DynamicFoldRecord,\n    \
      \                    requires a sequence match to the \"dynamic\" annotated\n\
      \                        regions of a HybRecord, and may be shorter/longer than\n\
      \                        the original sequence."
    inputBinding:
      position: 103
      prefix: --seq_type
  - id: set_dataset
    type:
      - 'null'
      - boolean
    doc: Set "dataset" flag to value of the input file name.
    inputBinding:
      position: 103
      prefix: --set_dataset
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Print no output during run.
    inputBinding:
      position: 103
      prefix: --silent
  - id: type_method
    type:
      - 'null'
      - string
    doc: "Segment-type finding method to use for type\n                        evaluation.
      For a description of the different\n                        methods, see the
      HybRecord documentation for the\n                        eval_types method."
    inputBinding:
      position: 103
      prefix: --type_method
  - id: type_params_file
    type:
      - 'null'
      - File
    doc: "Segment-type finding parameters file to use for type\n                 \
      \       evaluation with some type finding methods:\n                       \
      \ {string_match, id_map}. For a description of the\n                       \
      \ different methods, see the HybRecord documentation for\n                 \
      \       the find_seg_types method."
    inputBinding:
      position: 103
      prefix: --type_params_file
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
    doc: "Optional path to one or more hyb-format file for\n                     \
      \   output (should include a \".hyb\" suffix). If not\n                    \
      \    provided, the output for input file\n                        \"PATH_TO/MY_FILE.HYB\"\
      \ will be used as a template for\n                        the output \"OUT_DIR/MY_FILE_OUT.HYB\"\
      ."
    outputBinding:
      glob: $(inputs.out_hyb)
  - id: out_fold
    type:
      - 'null'
      - File
    doc: "Optional path to one or more \".vienna\" or \".ct\"-format\n           \
      \             files for output (should include appropriate\n               \
      \         \".vienna\"/\".ct\" suffix). If not provided, the output\n       \
      \                 for input file \"PATH_TO/MY_FILE.VIENNA\" will be used\n \
      \                       as a template for the output\n                     \
      \   \"OUT_DIR/MY_FILE_OUT.VIENNA\"."
    outputBinding:
      glob: $(inputs.out_fold)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybkit:0.3.6--pyhdfd78af_0
