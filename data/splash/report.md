# splash CWL Generation Report

## splash

### Tool Description
Welcome to SPLASH Version: 2.11.0

### Metadata
- **Docker Image**: quay.io/biocontainers/splash:2.11.0--py313h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/splash
- **Package**: https://anaconda.org/channels/bioconda/packages/splash/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/splash/overview
- **Total Downloads**: 825
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/refresh-bio/splash
- **Stars**: N/A
### Original Help Text
```text
usage: splash [-h] [--outname_prefix OUTNAME_PREFIX] [--anchor_len ANCHOR_LEN]
              [--gap_len GAP_LEN] [--target_len TARGET_LEN]
              [--anchor_list ANCHOR_LIST]
              [--pvals_correction_col_name PVALS_CORRECTION_COL_NAME]
              [--technology TECHNOLOGY] [--without_compactors]
              [--compactors_config COMPACTORS_CONFIG]
              [--lookup_table_config LOOKUP_TABLE_CONFIG]
              [--poly_ACGT_len POLY_ACGT_LEN] [--artifacts ARTIFACTS]
              [--dont_filter_illumina_adapters]
              [--anchor_unique_targets_threshold ANCHOR_UNIQUE_TARGETS_THRESHOLD]
              [--anchor_count_threshold ANCHOR_COUNT_THRESHOLD]
              [--anchor_samples_threshold ANCHOR_SAMPLES_THRESHOLD]
              [--anchor_sample_counts_threshold ANCHOR_SAMPLE_COUNTS_THRESHOLD]
              [--n_most_freq_targets_for_stats N_MOST_FREQ_TARGETS_FOR_STATS]
              [--n_most_freq_targets_for_dump N_MOST_FREQ_TARGETS_FOR_DUMP]
              [--fdr_threshold FDR_THRESHOLD]
              [--min_hamming_threshold MIN_HAMMING_THRESHOLD]
              [--keep_top_n_target_entropy KEEP_TOP_N_TARGET_ENTROPY]
              [--keep_top_n_effect_size_bin KEEP_TOP_N_EFFECT_SIZE_BIN]
              [--keep_significant_anchors_satc]
              [--keep_top_target_entropy_anchors_satc]
              [--keep_top_effect_size_bin_anchors_satc] [--dump_Cjs]
              [--max_pval_opt_for_Cjs MAX_PVAL_OPT_FOR_CJS]
              [--n_most_freq_targets N_MOST_FREQ_TARGETS]
              [--with_effect_size_cts] [--with_pval_asymp_opt]
              [--without_seqence_entropy]
              [--sample_name_to_id SAMPLE_NAME_TO_ID]
              [--dump_sample_anchor_target_count_txt]
              [--dump_sample_anchor_target_count_binary]
              [--satc_merge_dump_format {splash,satc}]
              [--supervised_test_samplesheet SUPERVISED_TEST_SAMPLESHEET]
              [--supervised_test_anchor_sample_fraction_cutoff SUPERVISED_TEST_ANCHOR_SAMPLE_FRACTION_CUTOFF]
              [--supervised_test_num_anchors SUPERVISED_TEST_NUM_ANCHORS]
              [--opt_num_inits OPT_NUM_INITS] [--opt_num_iters OPT_NUM_ITERS]
              [--num_rand_cf NUM_RAND_CF] [--num_splits NUM_SPLITS]
              [--opt_train_fraction OPT_TRAIN_FRACTION] [--without_alt_max]
              [--without_sample_spectral_sum] [--compute_also_old_base_pvals]
              [--Cjs_samplesheet CJS_SAMPLESHEET] [--bin_path BIN_PATH]
              [--tmp_dir TMP_DIR] [--n_threads_stage_1 N_THREADS_STAGE_1]
              [--n_threads_stage_1_internal N_THREADS_STAGE_1_INTERNAL]
              [--n_threads_stage_1_internal_boost N_THREADS_STAGE_1_INTERNAL_BOOST]
              [--n_threads_stage_2 N_THREADS_STAGE_2] [--n_bins N_BINS]
              [--kmc_use_RAM_only_mode] [--kmc_max_mem_GB KMC_MAX_MEM_GB]
              [--dont_clean_up] [--logs_dir LOGS_DIR] [--cbc_len CBC_LEN]
              [--umi_len UMI_LEN]
              [--soft_cbc_umi_len_limit SOFT_CBC_UMI_LEN_LIMIT]
              [--cbc_filtering_thr CBC_FILTERING_THR]
              [--cell_type_samplesheet CELL_TYPE_SAMPLESHEET]
              [--export_cbc_logs] [--predefined_cbc PREDEFINED_CBC]
              [--export_filtered_input] [--allow_strange_cbc_umi_reads]
              [--postprocessing_item POSTPROCESSING_ITEM]
              [--exclude_postprocessing_item EXCLUDE_POSTPROCESSING_ITEM]
              input_file

Welcome to SPLASH Version: 2.11.0

positional arguments:
  input_file            path to the file where input samples are defined, the
                        format is: per each line {sample_name}<space>{path},
                        path is a fastq[.gz] file in case of non-10X and txt
                        file for 10X/Visium where the content of text file is
                        {first_file.fastq[.gz]},{second_file.fastq[.gz]} per
                        line

options:
  -h, --help            show this help message and exit

Base configuration:
  --outname_prefix OUTNAME_PREFIX
                        prefix of output file names (default: result)
  --anchor_len ANCHOR_LEN
                        anchor length (default: 31)
  --gap_len GAP_LEN     gap length, if 'auto' it will be inferred from the
                        data, in the opposite case it must be an int (default:
                        0)
  --target_len TARGET_LEN
                        target length (default: 31)
  --anchor_list ANCHOR_LIST
                        list of accepted anchors, this is path to plain text
                        file with one anchor per line without any header
                        (default: )
  --pvals_correction_col_name PVALS_CORRECTION_COL_NAME
                        for which column correction should be applied
                        (default: pval_opt)
  --technology TECHNOLOGY
                        Technology used to generate the input data, must be
                        one of 'base', '10x', 'visium' (default: base)
  --without_compactors  if used compactors will not be run (default: False)
  --compactors_config COMPACTORS_CONFIG
                        optional json file with compactors configuration,
                        example file content: { "num_threads": 4, "epsilon":
                        0.001 } (default: )
  --lookup_table_config LOOKUP_TABLE_CONFIG
                        optional json file with configuration of lookup_table,
                        if not specified lookup_tables are not used (default:
                        )

Filters and thresholds:
  --poly_ACGT_len POLY_ACGT_LEN
                        filter out all anchors containing poly(ACGT) of length
                        at least <poly_ACGT_len> (0 means no filtering)
                        (default: 8)
  --artifacts ARTIFACTS
                        path to artifacts, each anchor containing artifact
                        will be filtered out (default: )
  --dont_filter_illumina_adapters
                        if used anchors containing Illumina adapters will not
                        be filtered out (default: False)
  --anchor_unique_targets_threshold ANCHOR_UNIQUE_TARGETS_THRESHOLD
                        filter out all anchors for which the number of unique
                        targets is <= anchor_unique_targets_threshold
                        (default: 1)
  --anchor_count_threshold ANCHOR_COUNT_THRESHOLD
                        filter out all anchors for which the total count <=
                        anchor_count_threshold (default: 50)
  --anchor_samples_threshold ANCHOR_SAMPLES_THRESHOLD
                        filter out all anchors for which the number of unique
                        samples is <= anchor_samples_threshold (default: 1)
  --anchor_sample_counts_threshold ANCHOR_SAMPLE_COUNTS_THRESHOLD
                        filter out anchor from sample if its count in this
                        sample is <= anchor_sample_counts_threshold (default:
                        5)
  --n_most_freq_targets_for_stats N_MOST_FREQ_TARGETS_FOR_STATS
                        use at most n_most_freq_targets_for_stats for each
                        contingency table, 0 means use all (default: 0)
  --n_most_freq_targets_for_dump N_MOST_FREQ_TARGETS_FOR_DUMP
                        use when dumping satc (txt or binary), resulting file
                        will only contain data for
                        n_most_freq_targets_for_dump targets in each anchor, 0
                        means use all (default: 0)
  --fdr_threshold FDR_THRESHOLD
                        keep anchors having corrected p-val below this value
                        (default: 0.05)
  --min_hamming_threshold MIN_HAMMING_THRESHOLD
                        keep only anchors with a pair of targets that differ
                        by >= min_hamming_threshold (default: 0)
  --keep_top_n_target_entropy KEEP_TOP_N_TARGET_ENTROPY
                        select keep_top_n_target_entropy records with highest
                        target entropy (0 means don't select) (default: 10000)
  --keep_top_n_effect_size_bin KEEP_TOP_N_EFFECT_SIZE_BIN
                        select keep_top_n_effect_size_bin records with highest
                        effect size bin (0 means don't select) (default:
                        20000)
  --keep_significant_anchors_satc
                        if set there will be additional output file in SATC
                        format with all significant anchors (default: False)
  --keep_top_target_entropy_anchors_satc
                        if set there will be additional output file in SATC
                        format with top target entropy significant anchors
                        (default: False)
  --keep_top_effect_size_bin_anchors_satc
                        if set there will be additional output file in SATC
                        format with top effect size bin anchors (default:
                        False)

Additional output configuration:
  --dump_Cjs            output Cjs (default: False)
  --max_pval_opt_for_Cjs MAX_PVAL_OPT_FOR_CJS
                        dump only Cjs for anchors that have pval_opt <=
                        max_pval_opt_for_Cjs (default: 0.1)
  --n_most_freq_targets N_MOST_FREQ_TARGETS
                        number of most frequent targets printed per each
                        anchor (default: 10)
  --with_effect_size_cts
                        if set effect_size_cts will be computed (default:
                        False)
  --with_pval_asymp_opt
                        if set pval_asymp_opt will be computed (default:
                        False)
  --without_seqence_entropy
                        if set sequence entropy for anchor and most freq
                        targets will not be computed (default: False)
  --sample_name_to_id SAMPLE_NAME_TO_ID
                        file name with mapping sample name <-> sample id
                        (default: sample_name_to_id.mapping.txt)
  --dump_sample_anchor_target_count_txt
                        if set contingency tables will be generated in text
                        format (default: False)
  --dump_sample_anchor_target_count_binary
                        if set contingency tables will be generated in binary
                        (satc) format, to convert to text format later
                        satc_dump program may be used, it may take optionally
                        mapping from id to sample_name (--sample_names param)
                        (default: False)
  --satc_merge_dump_format {splash,satc}
                        splash - text format like in nextflow, satc -
                        different order of elements per line (default: splash)
  --supervised_test_samplesheet SUPERVISED_TEST_SAMPLESHEET
                        if used script for finding/visualizing anchors with
                        metadata-dependent variation will be run (forces
                        --dump_sample_anchor_target_count_binary) (default: )
  --supervised_test_anchor_sample_fraction_cutoff SUPERVISED_TEST_ANCHOR_SAMPLE_FRACTION_CUTOFF
                        the cutoff for the minimum fraction of samples for
                        each anchor (default: 0.4)
  --supervised_test_num_anchors SUPERVISED_TEST_NUM_ANCHORS
                        maximum number of anchors to be tested example
                        (default: 20000)

Tuning statistics computation:
  --opt_num_inits OPT_NUM_INITS
                        the number of altMaximize random initializations
                        (default: 10)
  --opt_num_iters OPT_NUM_ITERS
                        the number of iteration in altMaximize (default: 50)
  --num_rand_cf NUM_RAND_CF
                        the number of random c and f used for pval_base
                        (default: 50)
  --num_splits NUM_SPLITS
                        the number of contingency table splits (default: 1)
  --opt_train_fraction OPT_TRAIN_FRACTION
                        use this fraction to create train X from contingency
                        table (default: 0.25)
  --without_alt_max     if set int alt max and related stats will not be
                        computed (default: False)
  --without_sample_spectral_sum
                        if set sample spectral sum will not be computed
                        (default: False)
  --compute_also_old_base_pvals
                        if set old pvals and effect size will be computed
                        (default: False)
  --Cjs_samplesheet CJS_SAMPLESHEET
                        path to file with predefined Cjs for non-10X
                        supervised mode (default: )

Technical and performance-related:
  --bin_path BIN_PATH   path to a directory where satc, satc_dump, satc_merge,
                        sig_anch, kmc, kmc_tools, bkc, dsv_manip,
                        gap_shortener, compactors binaries are (default: bin)
  --tmp_dir TMP_DIR     path to a directory where temporary files will be
                        stored (default: )
  --n_threads_stage_1 N_THREADS_STAGE_1
                        number of threads for the first stage, too large value
                        is not recomended because of intensive disk access
                        here, but may be profitable if there is a lot of small
                        size samples in the input (0 means auto adjustment)
                        (default: 0)
  --n_threads_stage_1_internal N_THREADS_STAGE_1_INTERNAL
                        number of threads per each stage 1 thread (0 means
                        auto adjustment) (default: 0)
  --n_threads_stage_1_internal_boost N_THREADS_STAGE_1_INTERNAL_BOOST
                        multiply the value of n_threads_stage_1_internal by
                        this (may increase performance but the total number of
                        running threads may be high) (default: 1)
  --n_threads_stage_2 N_THREADS_STAGE_2
                        number of threads for the second stage, high value is
                        recommended if possible, single thread will process
                        single bin (0 means auto adjustment) (default: 0)
  --n_bins N_BINS       the data will be split in a number of bins that will
                        be merged later (default: 128)
  --kmc_use_RAM_only_mode
                        True here may increase performance but also RAM-usage
                        (default: False)
  --kmc_max_mem_GB KMC_MAX_MEM_GB
                        maximal amount of memory (in GB) KMC will try to not
                        extend (default: 12)
  --dont_clean_up       if set then intermediate files will not be removed
                        (default: False)
  --logs_dir LOGS_DIR   director where run logs of each thread will be stored
                        (default: logs)

10x/visium processing:
  --cbc_len CBC_LEN     call barcode length (in case of 10X/Visium data)
                        (default: 16)
  --umi_len UMI_LEN     UMI length (in case of 10X/Visium data) (default: 12)
  --soft_cbc_umi_len_limit SOFT_CBC_UMI_LEN_LIMIT
                        allow additional symbols (beyond cbc_len + umi_len in
                        _1.fastq 10X file UMI (default: 0)
  --cbc_filtering_thr CBC_FILTERING_THR
                        how to filter cbcs, if 0 do the same as umi tools, in
                        the opposite case keep cbcs with freq >=
                        <cbc_filtering_thr> (default: 0)
  --cell_type_samplesheet CELL_TYPE_SAMPLESHEET
                        path for mapping barcode to cell type, is used
                        Helmert-based supervised mode is turned on (default: )
  --export_cbc_logs     use if need cbc log files (default: False)
  --predefined_cbc PREDEFINED_CBC
                        path to file with predefined CBCs (default: )
  --export_filtered_input
                        use if need filtered FASTQ files (default: False)
  --allow_strange_cbc_umi_reads
                        use to prevent the application from crashing when the
                        CBC+UMI read length is outside the acceptable range
                        (either shorter than CBC+UMI or longer than
                        CBC+UMI+soft_cbc_umi_len_limit) (default: False)

Postprocessing:
  --postprocessing_item POSTPROCESSING_ITEM
                        path to JSON defining postprocessing, may be defined
                        multiple times, will be executed in the order of
                        provided arguments (default: [])
  --exclude_postprocessing_item EXCLUDE_POSTPROCESSING_ITEM
                        Path to JSON defining postprocessing to exclude from
                        the default or provided postprocessing items (default:
                        None)
```

