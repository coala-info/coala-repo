cwlVersion: v1.2
class: CommandLineTool
baseCommand: megapath_nano.py
label: megapath-nano_megapath_nano.py
doc: "MegaPath-Nano: Compositional Analysis\n\nTool homepage: https://github.com/HKU-BAL/MegaPath-Nano"
inputs:
  - id: query
    type: File
    doc: Query file (fastq or fasta)
    inputBinding:
      position: 1
  - id: AMR_module_only
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --AMR_module_only
  - id: RAM_folder
    type:
      - 'null'
      - Directory
    doc: temporary folder in RAM
    inputBinding:
      position: 102
      prefix: --RAM_folder
  - id: adaptor_trimming
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --adaptor_trimming
  - id: adaptor_trimming_log
    type:
      - 'null'
      - File
    doc: Log for stdout output from adaptor trimming program
    inputBinding:
      position: 102
      prefix: --adaptor_trimming_log
  - id: aligner
    type:
      - 'null'
      - string
    doc: Aligner program
    inputBinding:
      position: 102
      prefix: --aligner
  - id: aligner_log
    type:
      - 'null'
      - File
    doc: Log for stderr output from aligner program
    inputBinding:
      position: 102
      prefix: --aligner_log
  - id: all_taxon_module_steps
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --all_taxon_module_steps
  - id: amplicon_decoy_filter_db_path
    type:
      - 'null'
      - File
    doc: Decoy database path for amplicon filter module
    inputBinding:
      position: 102
      prefix: --amplicon_decoy_filter_db_path
  - id: amplicon_filter_module
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --amplicon_filter_module
  - id: amplicon_human_filter_db_path
    type:
      - 'null'
      - File
    doc: Human database path for amplicon filter module
    inputBinding:
      position: 102
      prefix: --amplicon_human_filter_db_path
  - id: amplicon_human_filter_db_sequence_id
    type:
      - 'null'
      - string
    doc: Human database sequence id for amplicon filter module
    inputBinding:
      position: 102
      prefix: --amplicon_human_filter_db_sequence_id
  - id: amplicon_taxon_filter_db_path
    type:
      - 'null'
      - File
    doc: Taxon database path for amplicon filter module
    inputBinding:
      position: 102
      prefix: --amplicon_taxon_filter_db_path
  - id: archive_format
    type:
      - 'null'
      - string
    doc: Format used for archive file
    inputBinding:
      position: 102
      prefix: --archive_format
  - id: assembly
    type:
      - 'null'
      - File
    doc: Genome set for assembly identification
    inputBinding:
      position: 102
      prefix: --assembly
  - id: assembly_folder
    type:
      - 'null'
      - Directory
    doc: Assembly folder
    inputBinding:
      position: 102
      prefix: --assembly_folder
  - id: assembly_id_min_average_depth
    type:
      - 'null'
      - float
    doc: "Min average depth to perform assembly selection\n                      \
      \  (default skip assembly selection)"
    inputBinding:
      position: 102
      prefix: --assembly_id_min_average_depth
  - id: assembly_selection
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --assembly_selection
  - id: closing_expected_max_depth_stdev
    type:
      - 'null'
      - float
    doc: "Number of standard deviations for calculating expected\n               \
      \         max depth for closing spike filter"
    inputBinding:
      position: 102
      prefix: --closing_expected_max_depth_stdev
  - id: closing_spike_filter
    type:
      - 'null'
      - boolean
    doc: beta version
    inputBinding:
      position: 102
      prefix: --closing_spike_filter
  - id: config_folder
    type:
      - 'null'
      - Directory
    doc: Config file folder
    inputBinding:
      position: 102
      prefix: --config_folder
  - id: db_folder
    type:
      - 'null'
      - Directory
    doc: Db folder
    inputBinding:
      position: 102
      prefix: --db_folder
  - id: debug
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --debug
  - id: decoy
    type:
      - 'null'
      - File
    doc: Decoy genome set
    inputBinding:
      position: 102
      prefix: --decoy
  - id: decoy_filter
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --decoy_filter
  - id: decoy_filter_alignment_score_percent_threshold
    type:
      - 'null'
      - float
    doc: "Alignment score (normalized by read length) threshold\n                \
      \        (in percent) for flagging a read as a decoy read"
    inputBinding:
      position: 102
      prefix: --decoy_filter_alignment_score_percent_threshold
  - id: decoy_filter_alignment_score_threshold
    type:
      - 'null'
      - int
    doc: "Alignment score threshold for flagging a read as a\n                   \
      \     decoy read"
    inputBinding:
      position: 102
      prefix: --decoy_filter_alignment_score_threshold
  - id: expected_max_depth_stdev
    type:
      - 'null'
      - float
    doc: "Number of standard deviations for calculating expected\n               \
      \         max depth"
    inputBinding:
      position: 102
      prefix: --expected_max_depth_stdev
  - id: filter_fq_only
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --filter_fq_only
  - id: genus_height
    type:
      - 'null'
      - int
    doc: "Height in taxonomy to be considered as genus. Full\n                   \
      \     rank info in db_preparation/genAssemblyMetadata.py"
    inputBinding:
      position: 102
      prefix: --genus_height
  - id: good_alignment_threshold
    type:
      - 'null'
      - float
    doc: "Alignment score threshold in percentage of best\n                      \
      \  alignment score"
    inputBinding:
      position: 102
      prefix: --good_alignment_threshold
  - id: head_crop
    type:
      - 'null'
      - int
    doc: Number of nucleotides to crop at start of reads
    inputBinding:
      position: 102
      prefix: --head_crop
  - id: human
    type:
      - 'null'
      - File
    doc: Human genome set
    inputBinding:
      position: 102
      prefix: --human
  - id: human_filter
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --human_filter
  - id: human_filter_alignment_score_percent_threshold
    type:
      - 'null'
      - float
    doc: "Alignment score (normalized by read length) threshold\n                \
      \        (in percent) for flagging a read as a human read"
    inputBinding:
      position: 102
      prefix: --human_filter_alignment_score_percent_threshold
  - id: human_filter_alignment_score_threshold
    type:
      - 'null'
      - int
    doc: "Alignment score threshold for flagging a read as a\n                   \
      \     human read"
    inputBinding:
      position: 102
      prefix: --human_filter_alignment_score_threshold
  - id: human_repetitive_region_filter
    type:
      - 'null'
      - boolean
    doc: beta version
    inputBinding:
      position: 102
      prefix: --human_repetitive_region_filter
  - id: human_repetitive_region_filter_assembly_id
    type:
      - 'null'
      - string
    doc: Assembly ID for human similar region filter
    inputBinding:
      position: 102
      prefix: --human_repetitive_region_filter_assembly_id
  - id: mapping_only
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --mapping_only
  - id: max_AMR_thread
    type:
      - 'null'
      - int
    doc: Maximum number of threads used by AMR module
    inputBinding:
      position: 102
      prefix: --max_AMR_thread
  - id: max_aligner_target_GBase_per_batch
    type:
      - 'null'
      - float
    doc: "Maximum size of reference loaded in memory per batch\n                 \
      \       by aligner"
    inputBinding:
      position: 102
      prefix: --max_aligner_target_GBase_per_batch
  - id: max_aligner_thread
    type:
      - 'null'
      - int
    doc: Maximum number of threads used by aligner
    inputBinding:
      position: 102
      prefix: --max_aligner_thread
  - id: max_alignment_noise_overlap
    type:
      - 'null'
      - float
    doc: "The maximum percent for an alignment to overlap with\n                 \
      \       noise regions without being removed"
    inputBinding:
      position: 102
      prefix: --max_alignment_noise_overlap
  - id: max_porechop_thread
    type:
      - 'null'
      - int
    doc: Maximum number of threads used by porechop
    inputBinding:
      position: 102
      prefix: --max_porechop_thread
  - id: microbe_repetitive_region_filter
    type:
      - 'null'
      - boolean
    doc: beta version
    inputBinding:
      position: 102
      prefix: --microbe_repetitive_region_filter
  - id: microbe_repetitive_region_filter_abundance_threshold_80
    type:
      - 'null'
      - float
    doc: "Difference (no. of times) in apparent abundance to\n                   \
      \     trigger similar region filter with 80% similarity"
    default: 160
    inputBinding:
      position: 102
      prefix: --microbe_repetitive_region_filter_abundance_threshold_80
  - id: microbe_repetitive_region_filter_abundance_threshold_90
    type:
      - 'null'
      - float
    doc: "Difference (no. of times) in apparent abundance to\n                   \
      \     trigger similar region filter with 90% similarity"
    default: 80
    inputBinding:
      position: 102
      prefix: --microbe_repetitive_region_filter_abundance_threshold_90
  - id: microbe_repetitive_region_filter_abundance_threshold_95
    type:
      - 'null'
      - float
    doc: "Difference (no. of times) in apparent abundance to\n                   \
      \     trigger similar region filter with 95% similarity"
    default: 40
    inputBinding:
      position: 102
      prefix: --microbe_repetitive_region_filter_abundance_threshold_95
  - id: microbe_repetitive_region_filter_abundance_threshold_98
    type:
      - 'null'
      - float
    doc: "Difference (no. of times) in apparent abundance to\n                   \
      \     trigger similar region filter with 98% similarity"
    default: 16
    inputBinding:
      position: 102
      prefix: --microbe_repetitive_region_filter_abundance_threshold_98
  - id: microbe_repetitive_region_filter_abundance_threshold_99
    type:
      - 'null'
      - float
    doc: "Difference (no. of times) in apparent abundance to\n                   \
      \     trigger similar region filter with 99% similarity"
    default: 8
    inputBinding:
      position: 102
      prefix: --microbe_repetitive_region_filter_abundance_threshold_99
  - id: microbe_repetitive_region_filter_abundance_threshold_99_2
    type:
      - 'null'
      - float
    doc: "Difference (no. of times) in apparent abundance to\n                   \
      \     trigger similar region filter with 99.2% similarity"
    default: 6.4
    inputBinding:
      position: 102
      prefix: --microbe_repetitive_region_filter_abundance_threshold_99_2
  - id: microbe_repetitive_region_filter_allowed_max_span_percent
    type:
      - 'null'
      - float
    doc: "Maximum percent of regions (allowed) to be marked as\n                 \
      \       similar region"
    inputBinding:
      position: 102
      prefix: --microbe_repetitive_region_filter_allowed_max_span_percent
  - id: microbe_repetitive_region_filter_max_span_percent_overall
    type:
      - 'null'
      - float
    doc: "Maximum percent of regions to be marked as similar\n                   \
      \     region (overall)"
    inputBinding:
      position: 102
      prefix: --microbe_repetitive_region_filter_max_span_percent_overall
  - id: microbe_repetitive_region_filter_min_average_depth
    type:
      - 'null'
      - float
    doc: "Minimum average depth to be considered as source of\n                  \
      \      noise"
    inputBinding:
      position: 102
      prefix: --microbe_repetitive_region_filter_min_average_depth
  - id: microbe_repetitive_region_filter_targeted_max_span_percent
    type:
      - 'null'
      - float
    doc: "Maximum percent of regions (targeted) to be marked as\n                \
      \        similar region"
    inputBinding:
      position: 102
      prefix: --microbe_repetitive_region_filter_targeted_max_span_percent
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: Minimum alignment length to be considered as evidence
    inputBinding:
      position: 102
      prefix: --min_alignment_length
  - id: min_alignment_score
    type:
      - 'null'
      - int
    doc: Min alignment score
    inputBinding:
      position: 102
      prefix: --min_alignment_score
  - id: min_percent_abundance_to_perform_noise_projection
    type:
      - 'null'
      - float
    doc: "Minimum percent of abundance relative to the most\n                    \
      \    abundant species in a genus to perform noise\n                        projection"
    inputBinding:
      position: 102
      prefix: --min_percent_abundance_to_perform_noise_projection
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimum read length
    inputBinding:
      position: 102
      prefix: --min_read_length
  - id: min_read_quality
    type:
      - 'null'
      - int
    doc: Minimum average base quality of read
    inputBinding:
      position: 102
      prefix: --min_read_quality
  - id: no_adaptor_trimming
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-adaptor_trimming
  - id: no_assembly_selection
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-assembly_selection
  - id: no_closing_spike_filter
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-closing_spike_filter
  - id: no_decoy_filter
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-decoy_filter
  - id: no_human_filter
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-human_filter
  - id: no_human_repetitive_region_filter
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-human_repetitive_region_filter
  - id: no_mapping_only
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-mapping_only
  - id: no_microbe_repetitive_region_filter
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-microbe_repetitive_region_filter
  - id: no_noise_projection
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-noise_projection
  - id: no_output_PAF
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-output_PAF
  - id: no_output_adaptor_trimmed_query
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-output_adaptor_trimmed_query
  - id: no_output_decoy_stat
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-output_decoy_stat
  - id: no_output_genome_set
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-output_genome_set
  - id: no_output_human_and_decoy_filtered_query
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-output_human_and_decoy_filtered_query
  - id: no_output_human_stat
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-output_human_stat
  - id: no_output_id_signal
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-output_id_signal
  - id: no_output_noise_stat
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-output_noise_stat
  - id: no_output_per_read_data
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-output_per_read_data
  - id: no_output_quality_score_histogram
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-output_quality_score_histogram
  - id: no_output_raw_signal
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-output_raw_signal
  - id: no_output_read_length_histogram
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-output_read_length_histogram
  - id: no_output_separate_noise_bed
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-output_separate_noise_bed
  - id: no_output_trimmed_and_filtered_query
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-output_trimmed_and_filtered_query
  - id: no_read_filter
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-read_filter
  - id: no_read_trimming
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-read_trimming
  - id: no_reassign_read_id
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-reassign_read_id
  - id: no_reassignment
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-reassignment
  - id: no_short_alignment_filter
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-short_alignment_filter
  - id: no_similar_species_marker
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-similar_species_marker
  - id: no_spike_filter
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-spike_filter
  - id: no_unique_alignment
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-unique_alignment
  - id: no_variable_region_adjustment
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-variable_region_adjustment
  - id: noise_projection
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --noise_projection
  - id: noise_projection_num_read_to_simulate
    type:
      - 'null'
      - int
    doc: Number of simulated reads to generate
    inputBinding:
      position: 102
      prefix: --noise_projection_num_read_to_simulate
  - id: noise_projection_simulated_read_error_profile
    type:
      - 'null'
      - string
    doc: Error profile for generating simulated reads
    inputBinding:
      position: 102
      prefix: --noise_projection_simulated_read_error_profile
  - id: noise_projection_simulated_read_length_bin_size
    type:
      - 'null'
      - int
    doc: Read length bin size for generating simulated reads
    inputBinding:
      position: 102
      prefix: --noise_projection_simulated_read_length_bin_size
  - id: noise_projection_simulated_read_length_multiplier
    type:
      - 'null'
      - float
    doc: "Multiplier over average read length to obtain maximum\n                \
      \        read length"
    inputBinding:
      position: 102
      prefix: --noise_projection_simulated_read_length_multiplier
  - id: number_of_genus_to_perform_noise_projection
    type:
      - 'null'
      - int
    doc: Number of genus to perform noise projection
    inputBinding:
      position: 102
      prefix: --number_of_genus_to_perform_noise_projection
  - id: output_PAF
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --output_PAF
  - id: output_adaptor_trimmed_query
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --output_adaptor_trimmed_query
  - id: output_decoy_stat
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --output_decoy_stat
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output folder
    inputBinding:
      position: 102
      prefix: --output_folder
  - id: output_genome_set
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --output_genome_set
  - id: output_human_and_decoy_filtered_query
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --output_human_and_decoy_filtered_query
  - id: output_human_stat
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --output_human_stat
  - id: output_id_signal
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --output_id_signal
  - id: output_noise_stat
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --output_noise_stat
  - id: output_per_read_data
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --output_per_read_data
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 102
      prefix: --output_prefix
  - id: output_quality_score_histogram
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --output_quality_score_histogram
  - id: output_raw_signal
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --output_raw_signal
  - id: output_read_length_histogram
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --output_read_length_histogram
  - id: output_separate_noise_bed
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --output_separate_noise_bed
  - id: output_trimmed_and_filtered_query
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --output_trimmed_and_filtered_query
  - id: python
    type:
      - 'null'
      - string
    doc: Python entry point
    inputBinding:
      position: 102
      prefix: --python
  - id: quality_score_bin_size
    type:
      - 'null'
      - int
    doc: Bin size for quality score histogram
    inputBinding:
      position: 102
      prefix: --quality_score_bin_size
  - id: read_filter
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --read_filter
  - id: read_length_bin_size
    type:
      - 'null'
      - int
    doc: Bin size for read length histogram
    inputBinding:
      position: 102
      prefix: --read_length_bin_size
  - id: read_sim_log
    type:
      - 'null'
      - File
    doc: Log for stderr output from read simulator
    inputBinding:
      position: 102
      prefix: --read_sim_log
  - id: read_simulation_profiles
    type:
      - 'null'
      - File
    doc: Read simulation profiles
    inputBinding:
      position: 102
      prefix: --read_simulation_profiles
  - id: read_simulator
    type:
      - 'null'
      - string
    doc: Read simulation program
    inputBinding:
      position: 102
      prefix: --read_simulator
  - id: read_trimming
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --read_trimming
  - id: reassign_read_id
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --reassign_read_id
  - id: reassignment
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --reassignment
  - id: short_alignment_filter
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --short_alignment_filter
  - id: similar_species_marker
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --similar_species_marker
  - id: similar_species_marker_aligned_region_threshold_1
    type:
      - 'null'
      - float
    doc: "Percentage of aligned region (1) to be considered as\n                 \
      \       highly similar"
    inputBinding:
      position: 102
      prefix: --similar_species_marker_aligned_region_threshold_1
  - id: similar_species_marker_aligned_region_threshold_2
    type:
      - 'null'
      - float
    doc: "Percentage of aligned region (2) to be considered as\n                 \
      \       highly similar"
    inputBinding:
      position: 102
      prefix: --similar_species_marker_aligned_region_threshold_2
  - id: similar_species_marker_alignment_similarity_1
    type:
      - 'null'
      - string
    doc: Similarity cutoff (1) used for alignment
    inputBinding:
      position: 102
      prefix: --similar_species_marker_alignment_similarity_1
  - id: similar_species_marker_alignment_similarity_2
    type:
      - 'null'
      - string
    doc: Similarity cutoff (2) used for alignment
    inputBinding:
      position: 102
      prefix: --similar_species_marker_alignment_similarity_2
  - id: similar_species_marker_num_genus
    type:
      - 'null'
      - int
    doc: "Number of top most abundant species (1 per genus) to\n                 \
      \       be considered as possible source of noise"
    inputBinding:
      position: 102
      prefix: --similar_species_marker_num_genus
  - id: similar_species_marker_similarity_combine_logic
    type:
      - 'null'
      - string
    doc: Logic for combining criteria 1 and 2 (and / or)
    inputBinding:
      position: 102
      prefix: --similar_species_marker_similarity_combine_logic
  - id: species
    type:
      - 'null'
      - File
    doc: Genome set for species identification
    inputBinding:
      position: 102
      prefix: --species
  - id: species_id_min_aligned_bp
    type:
      - 'null'
      - int
    doc: "Min aligned base pairs to include a species for\n                      \
      \  analysis"
    inputBinding:
      position: 102
      prefix: --species_id_min_aligned_bp
  - id: species_level
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --species_level
  - id: spike_filter
    type:
      - 'null'
      - boolean
    doc: beta version
    inputBinding:
      position: 102
      prefix: --spike_filter
  - id: strain_level
    type:
      - 'null'
      - boolean
    doc: beta version
    inputBinding:
      position: 102
      prefix: --strain_level
  - id: tail_crop
    type:
      - 'null'
      - int
    doc: Number of nucleotides to crop at end of reads
    inputBinding:
      position: 102
      prefix: --tail_crop
  - id: taxon_and_AMR_module
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --taxon_and_AMR_module
  - id: taxon_module_only
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --taxon_module_only
  - id: taxonomy_db
    type:
      - 'null'
      - File
    doc: taxonomy database
    inputBinding:
      position: 102
      prefix: --taxonomy_db
  - id: temp_folder
    type:
      - 'null'
      - Directory
    doc: temporary folder
    inputBinding:
      position: 102
      prefix: --temp_folder
  - id: tool_folder
    type:
      - 'null'
      - Directory
    doc: Tool folder
    inputBinding:
      position: 102
      prefix: --tool_folder
  - id: unique_alignment
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --unique_alignment
  - id: unique_alignment_threshold
    type:
      - 'null'
      - float
    doc: "Unique alignments shall have no alignments with\n                      \
      \  alignment score within this percent"
    inputBinding:
      position: 102
      prefix: --unique_alignment_threshold
  - id: variable_region_adjustment
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --variable_region_adjustment
  - id: variable_region_percent
    type:
      - 'null'
      - float
    doc: "Maximum percentage of strands aligned for a region to\n                \
      \        be labeled as variable"
    inputBinding:
      position: 102
      prefix: --variable_region_percent
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megapath-nano:2--hee3b9ab_0
stdout: megapath-nano_megapath_nano.py.out
