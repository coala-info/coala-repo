# hybkit CWL Generation Report

## hybkit_hyb_check

### Tool Description
Read one or more hyb (and optional fold) format files and check for errors.

### Metadata
- **Docker Image**: quay.io/biocontainers/hybkit:0.3.6--pyhdfd78af_0
- **Homepage**: https://github.com/RenneLab/hybkit
- **Package**: https://anaconda.org/channels/bioconda/packages/hybkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hybkit/overview
- **Total Downloads**: 5.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RenneLab/hybkit
- **Stars**: N/A
### Original Help Text
```text
usage: hyb_check [-h] -i PATH_TO/MY_FILE.HYB [PATH_TO/MY_FILE.HYB ...]
                 [-f [PATH_TO/MY_FILE.VIENNA ...]] [--version] [-v | -s]
                 [--mirna_types MIRNA_TYPES [MIRNA_TYPES ...]]
                 [--custom_flags CUSTOM_FLAGS [CUSTOM_FLAGS ...]]
                 [--hyb_placeholder HYB_PLACEHOLDER]
                 [--reorder_flags {True,False}]
                 [--allow_undefined_flags [{True,False}]]
                 [--allow_unknown_seg_types [{True,False}]]
                 [--hybformat_id [{True,False}]]
                 [--hybformat_ref [{True,False}]]
                 [--allowed_mismatches ALLOWED_MISMATCHES]
                 [--fold_placeholder FOLD_PLACEHOLDER] [-y {static,dynamic}]
                 [--error_mode {raise,warn_return,return}]
                 [--error_checks {hybrecord_indel,foldrecord_nofold,max_mismatch,energy_mismatch} [{hybrecord_indel,foldrecord_nofold,max_mismatch,energy_mismatch} ...]]
                 [--iter_error_mode {raise,warn_return,warn_skip,skip,return}]
                 [--max_sequential_skips MAX_SEQUENTIAL_SKIPS]

Read one or more hyb (and optional fold) format files and check for errors.

This utility reads in one or more files in hyb-format
(see the Hybkit Hyb File Specification)
and uses hybkit's internal file error checking to check for errors. This can be useful
as an initial preparation step for further analyses.

Example system calls:

        hyb_check -i my_file_1.hyb -f my_file_1.vienna
        hyb_check -i my_file_1.hyb my_file_2.hyb -f my_file_1.vienna \\
            my_file_2.vienna -v --custom_flags myflag

options:
  -h, --help            show this help message and exit
  -i PATH_TO/MY_FILE.HYB [PATH_TO/MY_FILE.HYB ...], --in_hyb PATH_TO/MY_FILE.HYB [PATH_TO/MY_FILE.HYB ...]
                        REQUIRED path to one or more hyb-format files with a
                        ".hyb" suffix for use in the evaluation. (default:
                        None)
  -f [PATH_TO/MY_FILE.VIENNA ...], --in_fold [PATH_TO/MY_FILE.VIENNA ...]
                        REQUIRED path to one or more RNA secondary-structure
                        files with a ".vienna" or ".ct" suffix for use in the
                        evaluation. (default: None)
  --version             Print version and exit.
  -v, --verbose         Print verbose output during run. (default: False)
  -s, --silent          Print no output during run. (default: False)

Hyb Record Settings:
  --mirna_types MIRNA_TYPES [MIRNA_TYPES ...]
                        "seg_type" fields identifying a miRNA (default:
                        ['miRNA', 'microRNA'])
  --custom_flags CUSTOM_FLAGS [CUSTOM_FLAGS ...]
                        Custom flags to allow in addition to those specified
                        in the hybkit specification. (default: [])
  --hyb_placeholder HYB_PLACEHOLDER
                        placeholder character/string for missing data in hyb
                        files. (default: .)
  --reorder_flags {True,False}
                        Re-order flags to the hybkit-specification order when
                        writing hyb records. (default: True)
  --allow_undefined_flags [{True,False}]
                        Allow use of flags not defined in the hybkit-
                        specification order when reading and writing hyb
                        records. As the preferred alternative to using this
                        setting, the --custom_flags argument can be be used to
                        supply custom allowed flags. (default: False)
  --allow_unknown_seg_types [{True,False}]
                        Allow unknown segment types when assigning segment
                        types. (default: False)

Hyb File Settings:
  --hybformat_id [{True,False}]
                        The Hyb Software Package places further information in
                        the "id" field of the hybrid record that can be used
                        to infer the number of contained read counts. When set
                        to True, the identifiers will be parsed as:
                        "<read_id>_<read_count>" (default: False)
  --hybformat_ref [{True,False}]
                        The Hyb Software Package uses a reference database
                        with identifiers that contain sequence type and other
                        sequence information. When set to True, all hyb file
                        identifiers will be parsed as:
                        "<gene_id>_<transcript_id>_<gene_name>_<seg_type>"
                        (default: False)

Fold Record Settings:
  --allowed_mismatches ALLOWED_MISMATCHES
                        For DynamicFoldRecords, allowed number of mismatches
                        with a HybRecord. (default: 0)
  --fold_placeholder FOLD_PLACEHOLDER
                        Placeholder character/string for missing data for
                        reading/writing fold records. (default: .)
  -y {static,dynamic}, --seq_type {static,dynamic}
                        Type of fold record object to use. Options: "static":
                        FoldRecord, requires an exact sequence match to be
                        paired with a HybRecord; "dynamic": DynamicFoldRecord,
                        requires a sequence match to the "dynamic" annotated
                        regions of a HybRecord, and may be shorter/longer than
                        the original sequence. (default: static)
  --error_mode {raise,warn_return,return}
                        Mode for handling errors during reading of HybFiles
                        (overridden by HybFoldIter.settings['iter_error_mode']
                        when using HybFoldIter). Options: "raise": Raise an
                        error when encountered and exit program ;
                        "warn_return": Print a warning and return the
                        error_value ; "return": Return the error value with no
                        program output. record is encountered. (default:
                        raise)

Hyb-Fold Iterator Settings:
  --error_checks {hybrecord_indel,foldrecord_nofold,max_mismatch,energy_mismatch} [{hybrecord_indel,foldrecord_nofold,max_mismatch,energy_mismatch} ...]
                        Error checks for simultaneous HybFile and FoldFile
                        parsing. Options: "hybrecord_indel": Error for
                        HybRecord objects where one/both sequences have
                        insertions/deletions in alignment, which prevents
                        matching of sequences; "foldrecord_nofold": Error when
                        failure in reading a fold_record object;
                        "max_mismatch": Error when mismatch between hybrecord
                        and foldrecord sequences is greater than FoldRecord
                        "allowed_mismatches" setting; "energy_mismatch": Error
                        when a mismatch exists between HybRecord and
                        FoldRecord energy values. (default:
                        ['hybrecord_indel', 'foldrecord_nofold',
                        'max_mismatch', 'energy_mismatch'])
  --iter_error_mode {raise,warn_return,warn_skip,skip,return}
                        Mode for handling errors found during error checks.
                        Overrides HybRecord "error_mode" setting when using
                        HybFoldIter. Options: "raise": Raise an error when
                        encountered; "warn_return": Print a warning and return
                        the value; "warn_skip": Print a warning and continue
                        to the next iteration; "skip": Continue to the next
                        iteration without any output; "return": return the
                        value without any error output; (default: warn_skip)
  --max_sequential_skips MAX_SEQUENTIAL_SKIPS
                        Maximum number of record(-pairs) to skip in a row.
                        Limited as several sequential skips usually indicates
                        an issue with record formatting or a desynchronization
                        between files. (default: 100)

Output File Naming:
    Output files can be named in two fashions: via automatic name generation,
    or by providing specific out file names.

    Automatic Name Generation:
        For output name generation, the default respective naming scheme is used::

            hyb_script -i PATH_TO/MY_FILE_1.HYB [...]
                -->  OUT_DIR/MY_FILE_1_ADDSUFFIX.HYB

        This output file path can be modified with the arguments {--out_dir, --out_suffix}
        described below.

        The output directory defaults to the current working directory ``($PWD)``, and
        can be modified with the ``--out_dir <dir>`` argument.
        Note: The provided directory must exist, or an error will be raised.
        For Example::

            hyb_script -i PATH_TO/MY_FILE_1.HYB [...] --out_dir MY_OUT_DIR
                -->  MY_OUT_DIR/MY_FILE_1_ADDSUFFIX.HYB

        The suffix used for output files is based on the primary actions of the script.
        It can be specified using ``--out_suffix <suffix>``. This can optionally include
        the ".hyb" final suffix.
        for Example::

            hyb_script -i PATH_TO/MY_FILE_1.HYB [...] --out_suffix MY_SUFFIX
                -->  OUT_DIR/MY_FILE_1_MY_SUFFIX.HYB
            #OR
            hyb_script -i PATH_TO/MY_FILE_1.HYB [...] --out_suffix MY_SUFFIX.HYB
                -->  OUT_DIR/MY_FILE_1_MY_SUFFIX.HYB

    Specific Output Names:
        Alternatively, specific file names can be provided via the -o/--out_hyb argument,
        ensuring that the same number of input and output files are provided. This argument
        takes precedence over all automatic output file naming options
        (--out_dir, --out_suffix), which are ignored if -o/--out_hyb is provided.
        For Example::

            hyb_script [...] --out_hyb MY_OUT_DIR/OUT_FILE_1.HYB MY_OUT_DIR/OUT_FILE_2.HYB
                -->  MY_OUT_DIR/OUT_FILE_1.hyb
                -->  MY_OUT_DIR/OUT_FILE_2.hyb

        Note: The directory provided with output file paths (MY_OUT_DIR above) must exist,
        otherwise an error will be raised.
```


## hybkit_hyb_eval

### Tool Description
Read hyb files (and optional matched fold files) and evaluate the contained hybrids.

This utility reads in one or more files in hyb-format
(see the Hybkit Hyb File Specification) and corresponding fold files
(.vienna or .ct) and evaluates hybrid record properties.

Evaluation Types:

    "type"   Assigns types to each segment within hyb records
    "mirna"  Assigns which segments are a miRNA based on segment types.

"type" Evaluation:
     The 'type' evaluation utilizes the :func:hybkit.HybRecord.eval_types method
        to assign the record flags: seg1_type <seg1_type> 
        and seg2_type <seg2_type> 

    Example system calls:

            $ hyb_eval -t type -i my_file_1.hyb

            $ hyb_eval -t type -i my_file_1.hyb -f my_file_1.vienna

            $ hyb_eval -t type \
                        -i my_file_1.hyb my_file_2.hyb \
                        -f my_file_1.vienna my_file_2.vienna \
                        --type_method string_match \
                        --type_parameters my_parameters_file.csv \
                        --allow_unknown_seg_types

"mirna" Evaluation:
     The 'mirna' evaluation uses the :func:hybkit.HybRecord.eval_mirna method
        to identify properties relating to mirna within the hybrids,
        including mirna presence and positions.
        This evaluation requires the seg_type flags to be filled, either by a type evaluation, 
        or by parsing the read using the "--hybformat_ref True" option with a hyb-format
        reference. The mirna_seg <mirna_seg> flag is then set for each record, indicating
        the presence and position of any miRNA within the hybrid.

    Example system calls:

            $ hyb_eval -t mirna -i my_file_1.hyb

            $ hyb_eval -t mirna -i my_file_1.hyb -f my_file_1.vienna

            $ hyb_eval -t mirna -i my_file_1.hyb my_vile_2.hyb \
                        -f my_file_1.vienna my_file_2.vienna \
                        --mirna_types miRNA kshv-miRNA

    This can also be combined with the type evaluation, as such:

            $ hyb_eval -t type mirna -i my_file_1.hyb \
                        --type_method string_match \
                        --type_parameters my_parameters_file.csv \
                        --allow_unknown_seg_types \
                        --mirna_types miRNA kshv-miRNA

### Metadata
- **Docker Image**: quay.io/biocontainers/hybkit:0.3.6--pyhdfd78af_0
- **Homepage**: https://github.com/RenneLab/hybkit
- **Package**: https://anaconda.org/channels/bioconda/packages/hybkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hyb_eval [-h] -i PATH_TO/MY_FILE.HYB [PATH_TO/MY_FILE.HYB ...]
                [-f [PATH_TO/MY_FILE.VIENNA ...]]
                [-o PATH_TO/OUT_FILE.HYB [PATH_TO/OUT_FILE.HYB ...]]
                [-l PATH_TO/OUT_FILE.VIENNA [PATH_TO/OUT_FILE.VIENNA ...]]
                [-d OUT_DIR] [-u OUT_SUFFIX]
                [-t {type,mirna} [{type,mirna} ...]]
                [--type_method {hybformat,string_match,id_map}]
                [--type_params_file PATH_TO/PARAMETERS_FILE] [--set_dataset]
                [--version] [-v | -s]
                [--mirna_types MIRNA_TYPES [MIRNA_TYPES ...]]
                [--custom_flags CUSTOM_FLAGS [CUSTOM_FLAGS ...]]
                [--hyb_placeholder HYB_PLACEHOLDER]
                [--reorder_flags {True,False}]
                [--allow_undefined_flags [{True,False}]]
                [--allow_unknown_seg_types [{True,False}]]
                [--hybformat_id [{True,False}]]
                [--hybformat_ref [{True,False}]]
                [--allowed_mismatches ALLOWED_MISMATCHES]
                [--fold_placeholder FOLD_PLACEHOLDER] [-y {static,dynamic}]
                [--error_mode {raise,warn_return,return}]
                [--error_checks {hybrecord_indel,foldrecord_nofold,max_mismatch,energy_mismatch} [{hybrecord_indel,foldrecord_nofold,max_mismatch,energy_mismatch} ...]]
                [--iter_error_mode {raise,warn_return,warn_skip,skip,return}]
                [--max_sequential_skips MAX_SEQUENTIAL_SKIPS]

Read hyb files (and optional matched fold files) and evaluate the contained hybrids.

This utility reads in one or more files in hyb-format
(see the Hybkit Hyb File Specification) and corresponding fold files
(.vienna or .ct) and evaluates hybrid record properties.

Evaluation Types:

    "type"   Assigns types to each segment within hyb records
    "mirna"  Assigns which segments are a miRNA based on segment types.

"type" Evaluation:
     The 'type' evaluation utilizes the :func:hybkit.HybRecord.eval_types method
        to assign the record flags: seg1_type <seg1_type>
        and seg2_type <seg2_type>

    Example system calls:

            $ hyb_eval -t type -i my_file_1.hyb

            $ hyb_eval -t type -i my_file_1.hyb -f my_file_1.vienna

            $ hyb_eval -t type \\
                        -i my_file_1.hyb my_file_2.hyb \\
                        -f my_file_1.vienna my_file_2.vienna \\
                        --type_method string_match \\
                        --type_parameters my_parameters_file.csv \\
                        --allow_unknown_seg_types

"mirna" Evaluation:
     The 'mirna' evaluation uses the :func:hybkit.HybRecord.eval_mirna method
        to identify properties relating to mirna within the hybrids,
        including mirna presence and positions.
        This evaluation requires the seg_type flags to be filled, either by a type evaluation,
        or by parsing the read using the "--hybformat_ref True" option with a hyb-format
        reference. The mirna_seg <mirna_seg> flag is then set for each record, indicating
        the presence and position of any miRNA within the hybrid.

    Example system calls:

            $ hyb_eval -t mirna -i my_file_1.hyb

            $ hyb_eval -t mirna -i my_file_1.hyb -f my_file_1.vienna

            $ hyb_eval -t mirna -i my_file_1.hyb my_vile_2.hyb \\
                        -f my_file_1.vienna my_file_2.vienna \\
                        --mirna_types miRNA kshv-miRNA

    This can also be combined with the type evaluation, as such:

            $ hyb_eval -t type mirna -i my_file_1.hyb \\
                        --type_method string_match \\
                        --type_parameters my_parameters_file.csv \\
                        --allow_unknown_seg_types \\
                        --mirna_types miRNA kshv-miRNA

options:
  -h, --help            show this help message and exit
  -i PATH_TO/MY_FILE.HYB [PATH_TO/MY_FILE.HYB ...], --in_hyb PATH_TO/MY_FILE.HYB [PATH_TO/MY_FILE.HYB ...]
                        REQUIRED path to one or more hyb-format files with a
                        ".hyb" suffix for use in the evaluation. (default:
                        None)
  -f [PATH_TO/MY_FILE.VIENNA ...], --in_fold [PATH_TO/MY_FILE.VIENNA ...]
                        REQUIRED path to one or more RNA secondary-structure
                        files with a ".vienna" or ".ct" suffix for use in the
                        evaluation. (default: None)
  -o PATH_TO/OUT_FILE.HYB [PATH_TO/OUT_FILE.HYB ...], --out_hyb PATH_TO/OUT_FILE.HYB [PATH_TO/OUT_FILE.HYB ...]
                        Optional path to one or more hyb-format file for
                        output (should include a ".hyb" suffix). If not
                        provided, the output for input file
                        "PATH_TO/MY_FILE.HYB" will be used as a template for
                        the output "OUT_DIR/MY_FILE_OUT.HYB". (default: None)
  -l PATH_TO/OUT_FILE.VIENNA [PATH_TO/OUT_FILE.VIENNA ...], --out_fold PATH_TO/OUT_FILE.VIENNA [PATH_TO/OUT_FILE.VIENNA ...]
                        Optional path to one or more ".vienna" or ".ct"-format
                        files for output (should include appropriate
                        ".vienna"/".ct" suffix). If not provided, the output
                        for input file "PATH_TO/MY_FILE.VIENNA" will be used
                        as a template for the output
                        "OUT_DIR/MY_FILE_OUT.VIENNA". (default: None)
  -d OUT_DIR, --out_dir OUT_DIR
                        Path to directory for output of files. Defaults to the
                        current working directory. (default: $PWD)
  -u OUT_SUFFIX, --out_suffix OUT_SUFFIX
                        Suffix to add to the name of output files, before any
                        file- or analysis-specific suffixes. The file-type
                        appropriate suffix will be added automatically.
                        (default: _evaluated)
  -t {type,mirna} [{type,mirna} ...], --eval_types {type,mirna} [{type,mirna} ...]
                        Types of evaluations to perform on input hyb file.
                        (Note: evaluations can be combined, such as "--
                        eval_types type mirna") (default: ['type'])
  --set_dataset         Set "dataset" flag to value of the input file name.
                        (default: False)
  --version             Print version and exit.
  -v, --verbose         Print verbose output during run. (default: False)
  -s, --silent          Print no output during run. (default: False)

type Analysis Options:
  --type_method {hybformat,string_match,id_map}
                        Segment-type finding method to use for type
                        evaluation. For a description of the different
                        methods, see the HybRecord documentation for the
                        eval_types method. (default: hybformat)
  --type_params_file PATH_TO/PARAMETERS_FILE
                        Segment-type finding parameters file to use for type
                        evaluation with some type finding methods:
                        {string_match, id_map}. For a description of the
                        different methods, see the HybRecord documentation for
                        the find_seg_types method. (default: None)

Hyb Record Settings:
  --mirna_types MIRNA_TYPES [MIRNA_TYPES ...]
                        "seg_type" fields identifying a miRNA (default:
                        ['miRNA', 'microRNA'])
  --custom_flags CUSTOM_FLAGS [CUSTOM_FLAGS ...]
                        Custom flags to allow in addition to those specified
                        in the hybkit specification. (default: [])
  --hyb_placeholder HYB_PLACEHOLDER
                        placeholder character/string for missing data in hyb
                        files. (default: .)
  --reorder_flags {True,False}
                        Re-order flags to the hybkit-specification order when
                        writing hyb records. (default: True)
  --allow_undefined_flags [{True,False}]
                        Allow use of flags not defined in the hybkit-
                        specification order when reading and writing hyb
                        records. As the preferred alternative to using this
                        setting, the --custom_flags argument can be be used to
                        supply custom allowed flags. (default: False)
  --allow_unknown_seg_types [{True,False}]
                        Allow unknown segment types when assigning segment
                        types. (default: False)

Hyb File Settings:
  --hybformat_id [{True,False}]
                        The Hyb Software Package places further information in
                        the "id" field of the hybrid record that can be used
                        to infer the number of contained read counts. When set
                        to True, the identifiers will be parsed as:
                        "<read_id>_<read_count>" (default: False)
  --hybformat_ref [{True,False}]
                        The Hyb Software Package uses a reference database
                        with identifiers that contain sequence type and other
                        sequence information. When set to True, all hyb file
                        identifiers will be parsed as:
                        "<gene_id>_<transcript_id>_<gene_name>_<seg_type>"
                        (default: False)

Fold Record Settings:
  --allowed_mismatches ALLOWED_MISMATCHES
                        For DynamicFoldRecords, allowed number of mismatches
                        with a HybRecord. (default: 0)
  --fold_placeholder FOLD_PLACEHOLDER
                        Placeholder character/string for missing data for
                        reading/writing fold records. (default: .)
  -y {static,dynamic}, --seq_type {static,dynamic}
                        Type of fold record object to use. Options: "static":
                        FoldRecord, requires an exact sequence match to be
                        paired with a HybRecord; "dynamic": DynamicFoldRecord,
                        requires a sequence match to the "dynamic" annotated
                        regions of a HybRecord, and may be shorter/longer than
                        the original sequence. (default: static)
  --error_mode {raise,warn_return,return}
                        Mode for handling errors during reading of HybFiles
                        (overridden by HybFoldIter.settings['iter_error_mode']
                        when using HybFoldIter). Options: "raise": Raise an
                        error when encountered and exit program ;
                        "warn_return": Print a warning and return the
                        error_value ; "return": Return the error value with no
                        program output. record is encountered. (default:
                        raise)

Hyb-Fold Iterator Settings:
  --error_checks {hybrecord_indel,foldrecord_nofold,max_mismatch,energy_mismatch} [{hybrecord_indel,foldrecord_nofold,max_mismatch,energy_mismatch} ...]
                        Error checks for simultaneous HybFile and FoldFile
                        parsing. Options: "hybrecord_indel": Error for
                        HybRecord objects where one/both sequences have
                        insertions/deletions in alignment, which prevents
                        matching of sequences; "foldrecord_nofold": Error when
                        failure in reading a fold_record object;
                        "max_mismatch": Error when mismatch between hybrecord
                        and foldrecord sequences is greater than FoldRecord
                        "allowed_mismatches" setting; "energy_mismatch": Error
                        when a mismatch exists between HybRecord and
                        FoldRecord energy values. (default:
                        ['hybrecord_indel', 'foldrecord_nofold',
                        'max_mismatch', 'energy_mismatch'])
  --iter_error_mode {raise,warn_return,warn_skip,skip,return}
                        Mode for handling errors found during error checks.
                        Overrides HybRecord "error_mode" setting when using
                        HybFoldIter. Options: "raise": Raise an error when
                        encountered; "warn_return": Print a warning and return
                        the value; "warn_skip": Print a warning and continue
                        to the next iteration; "skip": Continue to the next
                        iteration without any output; "return": return the
                        value without any error output; (default: warn_skip)
  --max_sequential_skips MAX_SEQUENTIAL_SKIPS
                        Maximum number of record(-pairs) to skip in a row.
                        Limited as several sequential skips usually indicates
                        an issue with record formatting or a desynchronization
                        between files. (default: 100)

Output File Naming:
    Output files can be named in two fashions: via automatic name generation,
    or by providing specific out file names.

    Automatic Name Generation:
        For output name generation, the default respective naming scheme is used::

            hyb_script -i PATH_TO/MY_FILE_1.HYB [...]
                -->  OUT_DIR/MY_FILE_1_ADDSUFFIX.HYB

        This output file path can be modified with the arguments {--out_dir, --out_suffix}
        described below.

        The output directory defaults to the current working directory ``($PWD)``, and
        can be modified with the ``--out_dir <dir>`` argument.
        Note: The provided directory must exist, or an error will be raised.
        For Example::

            hyb_script -i PATH_TO/MY_FILE_1.HYB [...] --out_dir MY_OUT_DIR
                -->  MY_OUT_DIR/MY_FILE_1_ADDSUFFIX.HYB

        The suffix used for output files is based on the primary actions of the script.
        It can be specified using ``--out_suffix <suffix>``. This can optionally include
        the ".hyb" final suffix.
        for Example::

            hyb_script -i PATH_TO/MY_FILE_1.HYB [...] --out_suffix MY_SUFFIX
                -->  OUT_DIR/MY_FILE_1_MY_SUFFIX.HYB
            #OR
            hyb_script -i PATH_TO/MY_FILE_1.HYB [...] --out_suffix MY_SUFFIX.HYB
                -->  OUT_DIR/MY_FILE_1_MY_SUFFIX.HYB

    Specific Output Names:
        Alternatively, specific file names can be provided via the -o/--out_hyb argument,
        ensuring that the same number of input and output files are provided. This argument
        takes precedence over all automatic output file naming options
        (--out_dir, --out_suffix), which are ignored if -o/--out_hyb is provided.
        For Example::

            hyb_script [...] --out_hyb MY_OUT_DIR/OUT_FILE_1.HYB MY_OUT_DIR/OUT_FILE_2.HYB
                -->  MY_OUT_DIR/OUT_FILE_1.hyb
                -->  MY_OUT_DIR/OUT_FILE_2.hyb

        Note: The directory provided with output file paths (MY_OUT_DIR above) must exist,
        otherwise an error will be raised.
```


## hybkit_hyb_filter

### Tool Description
Filter hyb (and corresponding fold) files to meet (or exclude) specific criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/hybkit:0.3.6--pyhdfd78af_0
- **Homepage**: https://github.com/RenneLab/hybkit
- **Package**: https://anaconda.org/channels/bioconda/packages/hybkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hyb_filter [-h] -i PATH_TO/MY_FILE.HYB [PATH_TO/MY_FILE.HYB ...]
                  [-f [PATH_TO/MY_FILE.VIENNA ...]]
                  [-o PATH_TO/OUT_FILE.HYB [PATH_TO/OUT_FILE.HYB ...]]
                  [-l PATH_TO/OUT_FILE.VIENNA [PATH_TO/OUT_FILE.VIENNA ...]]
                  [-d OUT_DIR] [-u OUT_SUFFIX] [-m {all,any}]
                  [--skip_dup_id_before] [--skip_dup_id_after]
                  [--filter FILTER [FILTER ...]]
                  [--filter_2 FILTER_2 [FILTER_2 ...]]
                  [--filter_3 FILTER_3 [FILTER_3 ...]]
                  [--exclude EXCLUDE [EXCLUDE ...]]
                  [--exclude_2 EXCLUDE_2 [EXCLUDE_2 ...]]
                  [--exclude_3 EXCLUDE_3 [EXCLUDE_3 ...]] [--set_dataset]
                  [--version] [-v | -s]
                  [--mirna_types MIRNA_TYPES [MIRNA_TYPES ...]]
                  [--custom_flags CUSTOM_FLAGS [CUSTOM_FLAGS ...]]
                  [--hyb_placeholder HYB_PLACEHOLDER]
                  [--reorder_flags {True,False}]
                  [--allow_undefined_flags [{True,False}]]
                  [--allow_unknown_seg_types [{True,False}]]
                  [--hybformat_id [{True,False}]]
                  [--hybformat_ref [{True,False}]]
                  [--allowed_mismatches ALLOWED_MISMATCHES]
                  [--fold_placeholder FOLD_PLACEHOLDER] [-y {static,dynamic}]
                  [--error_mode {raise,warn_return,return}]
                  [--error_checks {hybrecord_indel,foldrecord_nofold,max_mismatch,energy_mismatch} [{hybrecord_indel,foldrecord_nofold,max_mismatch,energy_mismatch} ...]]
                  [--iter_error_mode {raise,warn_return,warn_skip,skip,return}]
                  [--max_sequential_skips MAX_SEQUENTIAL_SKIPS]

Filter hyb (and corresponding fold) files to meet (or exclude) specific criteria.

This script takes one or more filter and/or exclusion criteria
and outputs only those records matching (/excluding) those criteria.

The filter criteria and options are based on the options provided by the
:func:hybkit.HybRecord.prop method of the Hybkit API. For more information see
the full documentation for the :class:~hybkit.HybRecord class.

Example System Calls:

        hyb_filter -i my_file_1.hyb --filter has_seg_types
        # Outputs records that have completed a segtype analysis

        hyb_filter -i my_file_1.hyb -f my_file_1.vienna \\
            --include seg_type mRNA
        # Outputs hyb and fold records where hyb record has either segtype of mRNA

        hyb_filter -i my_file_1.hyb --exclude seg_type mRNA
        # Outputs records without either segtype of mRNA

        hyb_filter -i my_file_1.hyb --include seg1_type mRNA
        # Outputs records with only the first / 5p segtype of mRNA

        hyb_filter -i my_file_1.hyb my_file_2.hyb -f my_file_1.vienna my_file_2.vienna \\
            --include seg_type_contains RNA
        # Outputs all records with a segtype that includes
        #   the string "RNA" (case-sensitive)

        hyb_filter -i my_file_1.hyb --filter seg_contains kshv
        # Outputs records where either segment identifier contains the
        #   the string: "kshv" (case-sensitive)

Multiple filtering options can be used together.
The "-m" / "--filter_mode" argument determines whether
"any" (DEFAULT) or "all" filters are required to be true for inclusion.
Note: Matching any exclusion criteria results in exclusion of the record.

Example System Calls (match ALL criteria):

        hyb_filter -i my_file_1.hyb -f my_file_1.vienna \\
                    --filter seg_contains kshv \\
                    --filter_2 seg_type miRNA
        # Outputs records with either reference sequence identifier containing "kshv"
        #   and with either segment having an assigned segtype of miRNA

Example System Calls (match ANY criteria):

        hyb_filter -i my_file_1.hyb --filter_mode any \\
                    --filter seg_type miRNA \\
                    --filter_2 seg_type lncRNA
        # Outputs records containing either segment type matching
        #   either "miRNA" or "lncRNA" (case-sensitive)

options:
  -h, --help            show this help message and exit
  -i PATH_TO/MY_FILE.HYB [PATH_TO/MY_FILE.HYB ...], --in_hyb PATH_TO/MY_FILE.HYB [PATH_TO/MY_FILE.HYB ...]
                        REQUIRED path to one or more hyb-format files with a
                        ".hyb" suffix for use in the evaluation. (default:
                        None)
  -f [PATH_TO/MY_FILE.VIENNA ...], --in_fold [PATH_TO/MY_FILE.VIENNA ...]
                        REQUIRED path to one or more RNA secondary-structure
                        files with a ".vienna" or ".ct" suffix for use in the
                        evaluation. (default: None)
  -o PATH_TO/OUT_FILE.HYB [PATH_TO/OUT_FILE.HYB ...], --out_hyb PATH_TO/OUT_FILE.HYB [PATH_TO/OUT_FILE.HYB ...]
                        Optional path to one or more hyb-format file for
                        output (should include a ".hyb" suffix). If not
                        provided, the output for input file
                        "PATH_TO/MY_FILE.HYB" will be used as a template for
                        the output "OUT_DIR/MY_FILE_OUT.HYB". (default: None)
  -l PATH_TO/OUT_FILE.VIENNA [PATH_TO/OUT_FILE.VIENNA ...], --out_fold PATH_TO/OUT_FILE.VIENNA [PATH_TO/OUT_FILE.VIENNA ...]
                        Optional path to one or more ".vienna" or ".ct"-format
                        files for output (should include appropriate
                        ".vienna"/".ct" suffix). If not provided, the output
                        for input file "PATH_TO/MY_FILE.VIENNA" will be used
                        as a template for the output
                        "OUT_DIR/MY_FILE_OUT.VIENNA". (default: None)
  -d OUT_DIR, --out_dir OUT_DIR
                        Path to directory for output of files. Defaults to the
                        current working directory. (default: $PWD)
  -u OUT_SUFFIX, --out_suffix OUT_SUFFIX
                        Suffix to add to the name of output files, before any
                        file- or analysis-specific suffixes. The file-type
                        appropriate suffix will be added automatically.
                        (default: _filtered)
  -m {all,any}, --filter_mode {all,any}
                        Modes for evaluating multiple filters. The "all" mode
                        requires all provided filters to be true for
                        inclusion. The "any" mode requires only one provided
                        filter to be true for inclusion. (Note: matching any
                        exclusion filter is grounds for exclusion of record.)
                        (default: all)
  --skip_dup_id_before  Skip sequential duplicate read IDs before filtering.
                        (default: False)
  --skip_dup_id_after   Skip sequential duplicate read IDs after filtering.
                        (default: False)
  --filter FILTER [FILTER ...]
                        Filter criteria #1. Records matching the criteria will
                        be included in output. Includes a filter type, Ex:
                        "seg_name_contains", and an argument, Ex:
                        "ENST00000340384". (Note: not all filter types require
                        a second argument, for Example: "has_mirna_seg")
                        (default: None)
  --filter_2 FILTER_2 [FILTER_2 ...]
                        Filter criteria #2. Records matching the criteria will
                        be included in output. Includes a filter type, Ex:
                        "seg_name_contains", and an argument, Ex:
                        "ENST00000340384". (Note: not all filter types require
                        a second argument, for Example: "has_mirna_seg")
                        (default: None)
  --filter_3 FILTER_3 [FILTER_3 ...]
                        Filter criteria #3. Records matching the criteria will
                        be included in output. Includes a filter type, Ex:
                        "seg_name_contains", and an argument, Ex:
                        "ENST00000340384". (Note: not all filter types require
                        a second argument, for Example: "has_mirna_seg")
                        (default: None)
  --exclude EXCLUDE [EXCLUDE ...]
                        Exclusion filter criteria #1. Records matching the
                        criteria will be excluded from output. Includes a
                        filter type, Ex: "seg_name_contains", and an argument,
                        Ex: "ENST00000340384". (Note: not all filter types
                        require a second argument, for Example:
                        "has_mirna_seg") (default: None)
  --exclude_2 EXCLUDE_2 [EXCLUDE_2 ...]
                        Exclusion filter criteria #2. Records matching the
                        criteria will be excluded from output. Includes a
                        filter type, Ex: "seg_name_contains", and an argument,
                        Ex: "ENST00000340384". (Note: not all filter types
                        require a second argument, for Example:
                        "has_mirna_seg") (default: None)
  --exclude_3 EXCLUDE_3 [EXCLUDE_3 ...]
                        Exclusion filter criteria #3. Records matching the
                        criteria will be excluded from output. Includes a
                        filter type, Ex: "seg_name_contains", and an argument,
                        Ex: "ENST00000340384". (Note: not all filter types
                        require a second argument, for Example:
                        "has_mirna_seg") (default: None)
  --set_dataset         Set "dataset" flag to value of the input file name.
                        (default: False)
  --version             Print version and exit.
  -v, --verbose         Print verbose output during run. (default: False)
  -s, --silent          Print no output during run. (default: False)

Hyb Record Settings:
  --mirna_types MIRNA_TYPES [MIRNA_TYPES ...]
                        "seg_type" fields identifying a miRNA (default:
                        ['miRNA', 'microRNA'])
  --custom_flags CUSTOM_FLAGS [CUSTOM_FLAGS ...]
                        Custom flags to allow in addition to those specified
                        in the hybkit specification. (default: [])
  --hyb_placeholder HYB_PLACEHOLDER
                        placeholder character/string for missing data in hyb
                        files. (default: .)
  --reorder_flags {True,False}
                        Re-order flags to the hybkit-specification order when
                        writing hyb records. (default: True)
  --allow_undefined_flags [{True,False}]
                        Allow use of flags not defined in the hybkit-
                        specification order when reading and writing hyb
                        records. As the preferred alternative to using this
                        setting, the --custom_flags argument can be be used to
                        supply custom allowed flags. (default: False)
  --allow_unknown_seg_types [{True,False}]
                        Allow unknown segment types when assigning segment
                        types. (default: False)

Hyb File Settings:
  --hybformat_id [{True,False}]
                        The Hyb Software Package places further information in
                        the "id" field of the hybrid record that can be used
                        to infer the number of contained read counts. When set
                        to True, the identifiers will be parsed as:
                        "<read_id>_<read_count>" (default: False)
  --hybformat_ref [{True,False}]
                        The Hyb Software Package uses a reference database
                        with identifiers that contain sequence type and other
                        sequence information. When set to True, all hyb file
                        identifiers will be parsed as:
                        "<gene_id>_<transcript_id>_<gene_name>_<seg_type>"
                        (default: False)

Fold Record Settings:
  --allowed_mismatches ALLOWED_MISMATCHES
                        For DynamicFoldRecords, allowed number of mismatches
                        with a HybRecord. (default: 0)
  --fold_placeholder FOLD_PLACEHOLDER
                        Placeholder character/string for missing data for
                        reading/writing fold records. (default: .)
  -y {static,dynamic}, --seq_type {static,dynamic}
                        Type of fold record object to use. Options: "static":
                        FoldRecord, requires an exact sequence match to be
                        paired with a HybRecord; "dynamic": DynamicFoldRecord,
                        requires a sequence match to the "dynamic" annotated
                        regions of a HybRecord, and may be shorter/longer than
                        the original sequence. (default: static)
  --error_mode {raise,warn_return,return}
                        Mode for handling errors during reading of HybFiles
                        (overridden by HybFoldIter.settings['iter_error_mode']
                        when using HybFoldIter). Options: "raise": Raise an
                        error when encountered and exit program ;
                        "warn_return": Print a warning and return the
                        error_value ; "return": Return the error value with no
                        program output. record is encountered. (default:
                        raise)

Hyb-Fold Iterator Settings:
  --error_checks {hybrecord_indel,foldrecord_nofold,max_mismatch,energy_mismatch} [{hybrecord_indel,foldrecord_nofold,max_mismatch,energy_mismatch} ...]
                        Error checks for simultaneous HybFile and FoldFile
                        parsing. Options: "hybrecord_indel": Error for
                        HybRecord objects where one/both sequences have
                        insertions/deletions in alignment, which prevents
                        matching of sequences; "foldrecord_nofold": Error when
                        failure in reading a fold_record object;
                        "max_mismatch": Error when mismatch between hybrecord
                        and foldrecord sequences is greater than FoldRecord
                        "allowed_mismatches" setting; "energy_mismatch": Error
                        when a mismatch exists between HybRecord and
                        FoldRecord energy values. (default:
                        ['hybrecord_indel', 'foldrecord_nofold',
                        'max_mismatch', 'energy_mismatch'])
  --iter_error_mode {raise,warn_return,warn_skip,skip,return}
                        Mode for handling errors found during error checks.
                        Overrides HybRecord "error_mode" setting when using
                        HybFoldIter. Options: "raise": Raise an error when
                        encountered; "warn_return": Print a warning and return
                        the value; "warn_skip": Print a warning and continue
                        to the next iteration; "skip": Continue to the next
                        iteration without any output; "return": return the
                        value without any error output; (default: warn_skip)
  --max_sequential_skips MAX_SEQUENTIAL_SKIPS
                        Maximum number of record(-pairs) to skip in a row.
                        Limited as several sequential skips usually indicates
                        an issue with record formatting or a desynchronization
                        between files. (default: 100)

Output File Naming:
    Output files can be named in two fashions: via automatic name generation,
    or by providing specific out file names.

    Automatic Name Generation:
        For output name generation, the default respective naming scheme is used::

            hyb_script -i PATH_TO/MY_FILE_1.HYB [...]
                -->  OUT_DIR/MY_FILE_1_ADDSUFFIX.HYB

        This output file path can be modified with the arguments {--out_dir, --out_suffix}
        described below.

        The output directory defaults to the current working directory ``($PWD)``, and
        can be modified with the ``--out_dir <dir>`` argument.
        Note: The provided directory must exist, or an error will be raised.
        For Example::

            hyb_script -i PATH_TO/MY_FILE_1.HYB [...] --out_dir MY_OUT_DIR
                -->  MY_OUT_DIR/MY_FILE_1_ADDSUFFIX.HYB

        The suffix used for output files is based on the primary actions of the script.
        It can be specified using ``--out_suffix <suffix>``. This can optionally include
        the ".hyb" final suffix.
        for Example::

            hyb_script -i PATH_TO/MY_FILE_1.HYB [...] --out_suffix MY_SUFFIX
                -->  OUT_DIR/MY_FILE_1_MY_SUFFIX.HYB
            #OR
            hyb_script -i PATH_TO/MY_FILE_1.HYB [...] --out_suffix MY_SUFFIX.HYB
                -->  OUT_DIR/MY_FILE_1_MY_SUFFIX.HYB

    Specific Output Names:
        Alternatively, specific file names can be provided via the -o/--out_hyb argument,
        ensuring that the same number of input and output files are provided. This argument
        takes precedence over all automatic output file naming options
        (--out_dir, --out_suffix), which are ignored if -o/--out_hyb is provided.
        For Example::

            hyb_script [...] --out_hyb MY_OUT_DIR/OUT_FILE_1.HYB MY_OUT_DIR/OUT_FILE_2.HYB
                -->  MY_OUT_DIR/OUT_FILE_1.hyb
                -->  MY_OUT_DIR/OUT_FILE_2.hyb

        Note: The directory provided with output file paths (MY_OUT_DIR above) must exist,
        otherwise an error will be raised.
```


## hybkit_hyb_analyze

### Tool Description
Read hyb / vienna files and analyze the fold information in the contained hybrid sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/hybkit:0.3.6--pyhdfd78af_0
- **Homepage**: https://github.com/RenneLab/hybkit
- **Package**: https://anaconda.org/channels/bioconda/packages/hybkit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hyb_analyze [-h] -i PATH_TO/MY_FILE.HYB [PATH_TO/MY_FILE.HYB ...]
                   [-f [PATH_TO/MY_FILE.VIENNA ...]]
                   [-o PATH_TO/OUT_BASENAME [PATH_TO/OUT_BASENAME ...]]
                   [-d OUT_DIR] [-u OUT_SUFFIX]
                   [-a {energy,type,mirna,target,fold} [{energy,type,mirna,target,fold} ...]]
                   [-n ANALYSIS_NAME] [-p {True,False}] [--version] [-v | -s]
                   [--mirna_types MIRNA_TYPES [MIRNA_TYPES ...]]
                   [--custom_flags CUSTOM_FLAGS [CUSTOM_FLAGS ...]]
                   [--hyb_placeholder HYB_PLACEHOLDER]
                   [--reorder_flags {True,False}]
                   [--allow_undefined_flags [{True,False}]]
                   [--allow_unknown_seg_types [{True,False}]]
                   [--hybformat_id [{True,False}]]
                   [--hybformat_ref [{True,False}]]
                   [--allowed_mismatches ALLOWED_MISMATCHES]
                   [--fold_placeholder FOLD_PLACEHOLDER] [-y {static,dynamic}]
                   [--error_mode {raise,warn_return,return}]
                   [--error_checks {hybrecord_indel,foldrecord_nofold,max_mismatch,energy_mismatch} [{hybrecord_indel,foldrecord_nofold,max_mismatch,energy_mismatch} ...]]
                   [--iter_error_mode {raise,warn_return,warn_skip,skip,return}]
                   [--max_sequential_skips MAX_SEQUENTIAL_SKIPS]
                   [--quant_mode {single,reads,records}]
                   [--out_delim OUT_DELIM]

Read hyb / vienna files and analyze the fold information in the contained hybrid sequences.

Analysis Types:

    =
    Energy <EnergyAnalysis>  Analysis of values of predicted intra-hybrid folding energy
    Type <TypeAnalysis>      Analysis of segment types
    miRNA <MirnaAnalysis>    Analysis of miRNA segments distributions
    Target <TargetAnalysis>  Analysis of mirna target segment names and types
    Fold <FoldAnalysis>      Analysis of folding data included in the analyzed hyb_records
    =

This utility reads in one or more files in hyb-format
(see the Hybkit Hyb File Specification)
along with a corresponding predicted RNA secondary structure file in the
"Vienna" (Vienna Format <vienna_file_format>) or
"CT" (CT_Format <ct_file_format>) formats,
and analyzes hybrid secondary structure properties.

For full information on the different analysis types, see the Analyses <Analyses>
section of the hybkit documentation.

Example system calls:

        $ hyb_analyze -a fold -i my_file_1.hyb -f my_file_1.vienna

        $ hyb_analyze -a fold -i my_file_2.hyb -f my_file_2.ct \\
                    --make_plots False

options:
  -h, --help            show this help message and exit
  -i PATH_TO/MY_FILE.HYB [PATH_TO/MY_FILE.HYB ...], --in_hyb PATH_TO/MY_FILE.HYB [PATH_TO/MY_FILE.HYB ...]
                        REQUIRED path to one or more hyb-format files with a
                        ".hyb" suffix for use in the evaluation. (default:
                        None)
  -f [PATH_TO/MY_FILE.VIENNA ...], --in_fold [PATH_TO/MY_FILE.VIENNA ...]
                        REQUIRED path to one or more RNA secondary-structure
                        files with a ".vienna" or ".ct" suffix for use in the
                        evaluation. (default: None)
  -o PATH_TO/OUT_BASENAME [PATH_TO/OUT_BASENAME ...], --out_basename PATH_TO/OUT_BASENAME [PATH_TO/OUT_BASENAME ...]
                        Optional path to one or more basename prefixes to use
                        for output. The appropriate suffix will be added based
                        on the specific name. If not provided, the output for
                        input file "PATH_TO/MY_FILE.HYB" will be used as a
                        template for the basename "OUT_DIR/MY_FILE". (default:
                        None)
  -d OUT_DIR, --out_dir OUT_DIR
                        Path to directory for output of files. Defaults to the
                        current working directory. (default: $PWD)
  -u OUT_SUFFIX, --out_suffix OUT_SUFFIX
                        Suffix to add to the name of output files, before any
                        file- or analysis-specific suffixes. The file-type
                        appropriate suffix will be added automatically.
                        (default: None)
  -a {energy,type,mirna,target,fold} [{energy,type,mirna,target,fold} ...], --analysis_types {energy,type,mirna,target,fold} [{energy,type,mirna,target,fold} ...]
                        Analysis to perform on input hyb and fold files.
                        (default: ['fold'])
  -n ANALYSIS_NAME, --analysis_name ANALYSIS_NAME
                        Name / title of analysis data. (default: None)
  -p {True,False}, --make_plots {True,False}
                        Create plots of analysis output. (default: True)
  --version             Print version and exit.
  -v, --verbose         Print verbose output during run. (default: False)
  -s, --silent          Print no output during run. (default: False)

Hyb Record Settings:
  --mirna_types MIRNA_TYPES [MIRNA_TYPES ...]
                        "seg_type" fields identifying a miRNA (default:
                        ['miRNA', 'microRNA'])
  --custom_flags CUSTOM_FLAGS [CUSTOM_FLAGS ...]
                        Custom flags to allow in addition to those specified
                        in the hybkit specification. (default: [])
  --hyb_placeholder HYB_PLACEHOLDER
                        placeholder character/string for missing data in hyb
                        files. (default: .)
  --reorder_flags {True,False}
                        Re-order flags to the hybkit-specification order when
                        writing hyb records. (default: True)
  --allow_undefined_flags [{True,False}]
                        Allow use of flags not defined in the hybkit-
                        specification order when reading and writing hyb
                        records. As the preferred alternative to using this
                        setting, the --custom_flags argument can be be used to
                        supply custom allowed flags. (default: False)
  --allow_unknown_seg_types [{True,False}]
                        Allow unknown segment types when assigning segment
                        types. (default: False)

Hyb File Settings:
  --hybformat_id [{True,False}]
                        The Hyb Software Package places further information in
                        the "id" field of the hybrid record that can be used
                        to infer the number of contained read counts. When set
                        to True, the identifiers will be parsed as:
                        "<read_id>_<read_count>" (default: False)
  --hybformat_ref [{True,False}]
                        The Hyb Software Package uses a reference database
                        with identifiers that contain sequence type and other
                        sequence information. When set to True, all hyb file
                        identifiers will be parsed as:
                        "<gene_id>_<transcript_id>_<gene_name>_<seg_type>"
                        (default: False)

Fold Record Settings:
  --allowed_mismatches ALLOWED_MISMATCHES
                        For DynamicFoldRecords, allowed number of mismatches
                        with a HybRecord. (default: 0)
  --fold_placeholder FOLD_PLACEHOLDER
                        Placeholder character/string for missing data for
                        reading/writing fold records. (default: .)
  -y {static,dynamic}, --seq_type {static,dynamic}
                        Type of fold record object to use. Options: "static":
                        FoldRecord, requires an exact sequence match to be
                        paired with a HybRecord; "dynamic": DynamicFoldRecord,
                        requires a sequence match to the "dynamic" annotated
                        regions of a HybRecord, and may be shorter/longer than
                        the original sequence. (default: static)
  --error_mode {raise,warn_return,return}
                        Mode for handling errors during reading of HybFiles
                        (overridden by HybFoldIter.settings['iter_error_mode']
                        when using HybFoldIter). Options: "raise": Raise an
                        error when encountered and exit program ;
                        "warn_return": Print a warning and return the
                        error_value ; "return": Return the error value with no
                        program output. record is encountered. (default:
                        raise)

Hyb-Fold Iterator Settings:
  --error_checks {hybrecord_indel,foldrecord_nofold,max_mismatch,energy_mismatch} [{hybrecord_indel,foldrecord_nofold,max_mismatch,energy_mismatch} ...]
                        Error checks for simultaneous HybFile and FoldFile
                        parsing. Options: "hybrecord_indel": Error for
                        HybRecord objects where one/both sequences have
                        insertions/deletions in alignment, which prevents
                        matching of sequences; "foldrecord_nofold": Error when
                        failure in reading a fold_record object;
                        "max_mismatch": Error when mismatch between hybrecord
                        and foldrecord sequences is greater than FoldRecord
                        "allowed_mismatches" setting; "energy_mismatch": Error
                        when a mismatch exists between HybRecord and
                        FoldRecord energy values. (default:
                        ['hybrecord_indel', 'foldrecord_nofold',
                        'max_mismatch', 'energy_mismatch'])
  --iter_error_mode {raise,warn_return,warn_skip,skip,return}
                        Mode for handling errors found during error checks.
                        Overrides HybRecord "error_mode" setting when using
                        HybFoldIter. Options: "raise": Raise an error when
                        encountered; "warn_return": Print a warning and return
                        the value; "warn_skip": Print a warning and continue
                        to the next iteration; "skip": Continue to the next
                        iteration without any output; "return": return the
                        value without any error output; (default: warn_skip)
  --max_sequential_skips MAX_SEQUENTIAL_SKIPS
                        Maximum number of record(-pairs) to skip in a row.
                        Limited as several sequential skips usually indicates
                        an issue with record formatting or a desynchronization
                        between files. (default: 100)

Analysis Settings:
  --quant_mode {single,reads,records}
                        Method for counting records. Options: "single": Count
                        each record as a single entry; "reads": Use the number
                        of reads per hyb record as the count (may contain PCR
                        duplicates); "records": Count the number of records
                        represented by each hyb record entry (1 for "unmerged"
                        records, >= 1 for "merged" records) (default: single)
  --out_delim OUT_DELIM
                        Delimiter-string to place between fields in analysis
                        output. (default: ,)

Output File Naming:
    Output files can be named in two fashions: via automatic name generation,
    or by providing specific out file names.

    Automatic Name Generation:
        For output name generation, the default respective naming scheme is used::

            hyb_script -i PATH_TO/MY_FILE_1.HYB [...]
                -->  OUT_DIR/MY_FILE_1_ADDSUFFIX.HYB

        This output file path can be modified with the arguments {--out_dir, --out_suffix}
        described below.

        The output directory defaults to the current working directory ``($PWD)``, and
        can be modified with the ``--out_dir <dir>`` argument.
        Note: The provided directory must exist, or an error will be raised.
        For Example::

            hyb_script -i PATH_TO/MY_FILE_1.HYB [...] --out_dir MY_OUT_DIR
                -->  MY_OUT_DIR/MY_FILE_1_ADDSUFFIX.HYB

        The suffix used for output files is based on the primary actions of the script.
        It can be specified using ``--out_suffix <suffix>``. This can optionally include
        the ".hyb" final suffix.
        for Example::

            hyb_script -i PATH_TO/MY_FILE_1.HYB [...] --out_suffix MY_SUFFIX
                -->  OUT_DIR/MY_FILE_1_MY_SUFFIX.HYB
            #OR
            hyb_script -i PATH_TO/MY_FILE_1.HYB [...] --out_suffix MY_SUFFIX.HYB
                -->  OUT_DIR/MY_FILE_1_MY_SUFFIX.HYB

    Specific Output Names:
        Alternatively, specific file names can be provided via the -o/--out_hyb argument,
        ensuring that the same number of input and output files are provided. This argument
        takes precedence over all automatic output file naming options
        (--out_dir, --out_suffix), which are ignored if -o/--out_hyb is provided.
        For Example::

            hyb_script [...] --out_hyb MY_OUT_DIR/OUT_FILE_1.HYB MY_OUT_DIR/OUT_FILE_2.HYB
                -->  MY_OUT_DIR/OUT_FILE_1.hyb
                -->  MY_OUT_DIR/OUT_FILE_2.hyb

        Note: The directory provided with output file paths (MY_OUT_DIR above) must exist,
        otherwise an error will be raised.
```

