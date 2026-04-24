cwlVersion: v1.2
class: CommandLineTool
baseCommand: splash
label: splash
doc: "Welcome to SPLASH Version: 2.11.0\n\nTool homepage: https://github.com/refresh-bio/splash"
inputs:
  - id: input_file
    type: string
    doc: 'path to the file where input samples are defined, the format is: per each
      line {sample_name}<space>{path}, path is a fastq[.gz] file in case of non-10X
      and txt file for 10X/Visium where the content of text file is {first_file.fastq[.gz]},{second_file.fastq[.gz]}
      per line'
    inputBinding:
      position: 1
  - id: allow_strange_cbc_umi_reads
    type:
      - 'null'
      - boolean
    doc: use to prevent the application from crashing when the CBC+UMI read 
      length is outside the acceptable range (either shorter than CBC+UMI or 
      longer than CBC+UMI+soft_cbc_umi_len_limit)
    inputBinding:
      position: 102
      prefix: --allow_strange_cbc_umi_reads
  - id: anchor_count_threshold
    type:
      - 'null'
      - int
    doc: filter out all anchors for which the total count <= 
      anchor_count_threshold
    inputBinding:
      position: 102
      prefix: --anchor_count_threshold
  - id: anchor_len
    type:
      - 'null'
      - int
    doc: anchor length
    inputBinding:
      position: 102
      prefix: --anchor_len
  - id: anchor_list
    type:
      - 'null'
      - File
    doc: list of accepted anchors, this is path to plain text file with one 
      anchor per line without any header
    inputBinding:
      position: 102
      prefix: --anchor_list
  - id: anchor_sample_counts_threshold
    type:
      - 'null'
      - int
    doc: filter out anchor from sample if its count in this sample is <= 
      anchor_sample_counts_threshold
    inputBinding:
      position: 102
      prefix: --anchor_sample_counts_threshold
  - id: anchor_samples_threshold
    type:
      - 'null'
      - int
    doc: filter out all anchors for which the number of unique samples is <= 
      anchor_samples_threshold
    inputBinding:
      position: 102
      prefix: --anchor_samples_threshold
  - id: anchor_unique_targets_threshold
    type:
      - 'null'
      - int
    doc: filter out all anchors for which the number of unique targets is <= 
      anchor_unique_targets_threshold
    inputBinding:
      position: 102
      prefix: --anchor_unique_targets_threshold
  - id: artifacts
    type:
      - 'null'
      - File
    doc: path to artifacts, each anchor containing artifact will be filtered out
    inputBinding:
      position: 102
      prefix: --artifacts
  - id: bin_path
    type:
      - 'null'
      - Directory
    doc: path to a directory where satc, satc_dump, satc_merge, sig_anch, kmc, 
      kmc_tools, bkc, dsv_manip, gap_shortener, compactors binaries are
    inputBinding:
      position: 102
      prefix: --bin_path
  - id: cbc_filtering_thr
    type:
      - 'null'
      - int
    doc: how to filter cbcs, if 0 do the same as umi tools, in the opposite case
      keep cbcs with freq >= <cbc_filtering_thr>
    inputBinding:
      position: 102
      prefix: --cbc_filtering_thr
  - id: cbc_len
    type:
      - 'null'
      - int
    doc: call barcode length (in case of 10X/Visium data)
    inputBinding:
      position: 102
      prefix: --cbc_len
  - id: cell_type_samplesheet
    type:
      - 'null'
      - File
    doc: path for mapping barcode to cell type, is used Helmert-based supervised
      mode is turned on
    inputBinding:
      position: 102
      prefix: --cell_type_samplesheet
  - id: cjs_samplesheet
    type:
      - 'null'
      - File
    doc: path to file with predefined Cjs for non-10X supervised mode
    inputBinding:
      position: 102
      prefix: --Cjs_samplesheet
  - id: compactors_config
    type:
      - 'null'
      - File
    doc: 'optional json file with compactors configuration, example file content:
      { "num_threads": 4, "epsilon": 0.001 }'
    inputBinding:
      position: 102
      prefix: --compactors_config
  - id: compute_also_old_base_pvals
    type:
      - 'null'
      - boolean
    doc: if set old pvals and effect size will be computed
    inputBinding:
      position: 102
      prefix: --compute_also_old_base_pvals
  - id: dont_clean_up
    type:
      - 'null'
      - boolean
    doc: if set then intermediate files will not be removed
    inputBinding:
      position: 102
      prefix: --dont_clean_up
  - id: dont_filter_illumina_adapters
    type:
      - 'null'
      - boolean
    doc: if used anchors containing Illumina adapters will not be filtered out
    inputBinding:
      position: 102
      prefix: --dont_filter_illumina_adapters
  - id: dump_cjs
    type:
      - 'null'
      - boolean
    doc: output Cjs
    inputBinding:
      position: 102
      prefix: --dump_Cjs
  - id: dump_sample_anchor_target_count_binary
    type:
      - 'null'
      - boolean
    doc: if set contingency tables will be generated in binary (satc) format, to
      convert to text format later satc_dump program may be used, it may take 
      optionally mapping from id to sample_name (--sample_names param)
    inputBinding:
      position: 102
      prefix: --dump_sample_anchor_target_count_binary
  - id: dump_sample_anchor_target_count_txt
    type:
      - 'null'
      - boolean
    doc: if set contingency tables will be generated in text format
    inputBinding:
      position: 102
      prefix: --dump_sample_anchor_target_count_txt
  - id: exclude_postprocessing_item
    type:
      - 'null'
      - type: array
        items: string
    doc: Path to JSON defining postprocessing to exclude from the default or 
      provided postprocessing items
    inputBinding:
      position: 102
      prefix: --exclude_postprocessing_item
  - id: export_cbc_logs
    type:
      - 'null'
      - boolean
    doc: use if need cbc log files
    inputBinding:
      position: 102
      prefix: --export_cbc_logs
  - id: export_filtered_input
    type:
      - 'null'
      - boolean
    doc: use if need filtered FASTQ files
    inputBinding:
      position: 102
      prefix: --export_filtered_input
  - id: fdr_threshold
    type:
      - 'null'
      - float
    doc: keep anchors having corrected p-val below this value
    inputBinding:
      position: 102
      prefix: --fdr_threshold
  - id: gap_len
    type:
      - 'null'
      - string
    doc: gap length, if 'auto' it will be inferred from the data, in the 
      opposite case it must be an int
    inputBinding:
      position: 102
      prefix: --gap_len
  - id: keep_significant_anchors_satc
    type:
      - 'null'
      - boolean
    doc: if set there will be additional output file in SATC format with all 
      significant anchors
    inputBinding:
      position: 102
      prefix: --keep_significant_anchors_satc
  - id: keep_top_effect_size_bin_anchors_satc
    type:
      - 'null'
      - boolean
    doc: if set there will be additional output file in SATC format with top 
      effect size bin anchors
    inputBinding:
      position: 102
      prefix: --keep_top_effect_size_bin_anchors_satc
  - id: keep_top_n_effect_size_bin
    type:
      - 'null'
      - int
    doc: select keep_top_n_effect_size_bin records with highest effect size bin 
      (0 means don't select)
    inputBinding:
      position: 102
      prefix: --keep_top_n_effect_size_bin
  - id: keep_top_n_target_entropy
    type:
      - 'null'
      - int
    doc: select keep_top_n_target_entropy records with highest target entropy (0
      means don't select)
    inputBinding:
      position: 102
      prefix: --keep_top_n_target_entropy
  - id: keep_top_target_entropy_anchors_satc
    type:
      - 'null'
      - boolean
    doc: if set there will be additional output file in SATC format with top 
      target entropy significant anchors
    inputBinding:
      position: 102
      prefix: --keep_top_target_entropy_anchors_satc
  - id: kmc_max_mem_gb
    type:
      - 'null'
      - int
    doc: maximal amount of memory (in GB) KMC will try to not extend
    inputBinding:
      position: 102
      prefix: --kmc_max_mem_GB
  - id: kmc_use_ram_only_mode
    type:
      - 'null'
      - boolean
    doc: True here may increase performance but also RAM-usage
    inputBinding:
      position: 102
      prefix: --kmc_use_RAM_only_mode
  - id: logs_dir
    type:
      - 'null'
      - Directory
    doc: director where run logs of each thread will be stored
    inputBinding:
      position: 102
      prefix: --logs_dir
  - id: lookup_table_config
    type:
      - 'null'
      - File
    doc: optional json file with configuration of lookup_table, if not specified
      lookup_tables are not used
    inputBinding:
      position: 102
      prefix: --lookup_table_config
  - id: max_pval_opt_for_cjs
    type:
      - 'null'
      - float
    doc: dump only Cjs for anchors that have pval_opt <= max_pval_opt_for_Cjs
    inputBinding:
      position: 102
      prefix: --max_pval_opt_for_Cjs
  - id: min_hamming_threshold
    type:
      - 'null'
      - int
    doc: keep only anchors with a pair of targets that differ by >= 
      min_hamming_threshold
    inputBinding:
      position: 102
      prefix: --min_hamming_threshold
  - id: n_bins
    type:
      - 'null'
      - int
    doc: the data will be split in a number of bins that will be merged later
    inputBinding:
      position: 102
      prefix: --n_bins
  - id: n_most_freq_targets
    type:
      - 'null'
      - int
    doc: number of most frequent targets printed per each anchor
    inputBinding:
      position: 102
      prefix: --n_most_freq_targets
  - id: n_most_freq_targets_for_dump
    type:
      - 'null'
      - int
    doc: use when dumping satc (txt or binary), resulting file will only contain
      data for n_most_freq_targets_for_dump targets in each anchor, 0 means use 
      all
    inputBinding:
      position: 102
      prefix: --n_most_freq_targets_for_dump
  - id: n_most_freq_targets_for_stats
    type:
      - 'null'
      - int
    doc: use at most n_most_freq_targets_for_stats for each contingency table, 0
      means use all
    inputBinding:
      position: 102
      prefix: --n_most_freq_targets_for_stats
  - id: n_threads_stage_1
    type:
      - 'null'
      - int
    doc: number of threads for the first stage, too large value is not 
      recomended because of intensive disk access here, but may be profitable if
      there is a lot of small size samples in the input (0 means auto 
      adjustment)
    inputBinding:
      position: 102
      prefix: --n_threads_stage_1
  - id: n_threads_stage_1_internal
    type:
      - 'null'
      - int
    doc: number of threads per each stage 1 thread (0 means auto adjustment)
    inputBinding:
      position: 102
      prefix: --n_threads_stage_1_internal
  - id: n_threads_stage_1_internal_boost
    type:
      - 'null'
      - int
    doc: multiply the value of n_threads_stage_1_internal by this (may increase 
      performance but the total number of running threads may be high)
    inputBinding:
      position: 102
      prefix: --n_threads_stage_1_internal_boost
  - id: n_threads_stage_2
    type:
      - 'null'
      - int
    doc: number of threads for the second stage, high value is recommended if 
      possible, single thread will process single bin (0 means auto adjustment)
    inputBinding:
      position: 102
      prefix: --n_threads_stage_2
  - id: num_rand_cf
    type:
      - 'null'
      - int
    doc: the number of random c and f used for pval_base
    inputBinding:
      position: 102
      prefix: --num_rand_cf
  - id: num_splits
    type:
      - 'null'
      - int
    doc: the number of contingency table splits
    inputBinding:
      position: 102
      prefix: --num_splits
  - id: opt_num_inits
    type:
      - 'null'
      - int
    doc: the number of altMaximize random initializations
    inputBinding:
      position: 102
      prefix: --opt_num_inits
  - id: opt_num_iters
    type:
      - 'null'
      - int
    doc: the number of iteration in altMaximize
    inputBinding:
      position: 102
      prefix: --opt_num_iters
  - id: opt_train_fraction
    type:
      - 'null'
      - float
    doc: use this fraction to create train X from contingency table
    inputBinding:
      position: 102
      prefix: --opt_train_fraction
  - id: outname_prefix
    type:
      - 'null'
      - string
    doc: prefix of output file names
    inputBinding:
      position: 102
      prefix: --outname_prefix
  - id: poly_acgt_len
    type:
      - 'null'
      - int
    doc: filter out all anchors containing poly(ACGT) of length at least 
      <poly_ACGT_len> (0 means no filtering)
    inputBinding:
      position: 102
      prefix: --poly_ACGT_len
  - id: postprocessing_item
    type:
      - 'null'
      - type: array
        items: string
    doc: path to JSON defining postprocessing, may be defined multiple times, 
      will be executed in the order of provided arguments
    inputBinding:
      position: 102
      prefix: --postprocessing_item
  - id: predefined_cbc
    type:
      - 'null'
      - File
    doc: path to file with predefined CBCs
    inputBinding:
      position: 102
      prefix: --predefined_cbc
  - id: pvals_correction_col_name
    type:
      - 'null'
      - string
    doc: for which column correction should be applied
    inputBinding:
      position: 102
      prefix: --pvals_correction_col_name
  - id: sample_name_to_id
    type:
      - 'null'
      - File
    doc: file name with mapping sample name <-> sample id
    inputBinding:
      position: 102
      prefix: --sample_name_to_id
  - id: satc_merge_dump_format
    type:
      - 'null'
      - string
    doc: splash - text format like in nextflow, satc - different order of 
      elements per line
    inputBinding:
      position: 102
      prefix: --satc_merge_dump_format
  - id: soft_cbc_umi_len_limit
    type:
      - 'null'
      - int
    doc: allow additional symbols (beyond cbc_len + umi_len in _1.fastq 10X file
      UMI
    inputBinding:
      position: 102
      prefix: --soft_cbc_umi_len_limit
  - id: supervised_test_anchor_sample_fraction_cutoff
    type:
      - 'null'
      - float
    doc: the cutoff for the minimum fraction of samples for each anchor
    inputBinding:
      position: 102
      prefix: --supervised_test_anchor_sample_fraction_cutoff
  - id: supervised_test_num_anchors
    type:
      - 'null'
      - int
    doc: maximum number of anchors to be tested example
    inputBinding:
      position: 102
      prefix: --supervised_test_num_anchors
  - id: supervised_test_samplesheet
    type:
      - 'null'
      - File
    doc: if used script for finding/visualizing anchors with metadata-dependent 
      variation will be run (forces --dump_sample_anchor_target_count_binary)
    inputBinding:
      position: 102
      prefix: --supervised_test_samplesheet
  - id: target_len
    type:
      - 'null'
      - int
    doc: target length
    inputBinding:
      position: 102
      prefix: --target_len
  - id: technology
    type:
      - 'null'
      - string
    doc: Technology used to generate the input data, must be one of 'base', 
      '10x', 'visium'
    inputBinding:
      position: 102
      prefix: --technology
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: path to a directory where temporary files will be stored
    inputBinding:
      position: 102
      prefix: --tmp_dir
  - id: umi_len
    type:
      - 'null'
      - int
    doc: UMI length (in case of 10X/Visium data)
    inputBinding:
      position: 102
      prefix: --umi_len
  - id: with_effect_size_cts
    type:
      - 'null'
      - boolean
    doc: if set effect_size_cts will be computed
    inputBinding:
      position: 102
      prefix: --with_effect_size_cts
  - id: with_pval_asymp_opt
    type:
      - 'null'
      - boolean
    doc: if set pval_asymp_opt will be computed
    inputBinding:
      position: 102
      prefix: --with_pval_asymp_opt
  - id: without_alt_max
    type:
      - 'null'
      - boolean
    doc: if set int alt max and related stats will not be computed
    inputBinding:
      position: 102
      prefix: --without_alt_max
  - id: without_compactors
    type:
      - 'null'
      - boolean
    doc: if used compactors will not be run
    inputBinding:
      position: 102
      prefix: --without_compactors
  - id: without_sample_spectral_sum
    type:
      - 'null'
      - boolean
    doc: if set sample spectral sum will not be computed
    inputBinding:
      position: 102
      prefix: --without_sample_spectral_sum
  - id: without_seqence_entropy
    type:
      - 'null'
      - boolean
    doc: if set sequence entropy for anchor and most freq targets will not be 
      computed
    inputBinding:
      position: 102
      prefix: --without_seqence_entropy
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/splash:2.11.0--py313h9ee0642_0
stdout: splash.out
