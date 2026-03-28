# megapath-nano CWL Generation Report

## megapath-nano_megapath_nano.py

### Tool Description
MegaPath-Nano: Compositional Analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/megapath-nano:2--hee3b9ab_0
- **Homepage**: https://github.com/HKU-BAL/MegaPath-Nano
- **Package**: https://anaconda.org/channels/bioconda/packages/megapath-nano/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/megapath-nano/overview
- **Total Downloads**: 5.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/HKU-BAL/MegaPath-Nano
- **Stars**: N/A
### Original Help Text
```text
usage: megapath_nano.py [-h] [--debug]
                        [--adaptor_trimming | --no-adaptor_trimming]
                        [--read_trimming | --no-read_trimming]
                        [--read_filter | --no-read_filter]
                        [--human_filter | --no-human_filter]
                        [--decoy_filter | --no-decoy_filter]
                        [--variable_region_adjustment | --no-variable_region_adjustment]
                        [--spike_filter | --no-spike_filter]
                        [--closing_spike_filter | --no-closing_spike_filter]
                        [--human_repetitive_region_filter | --no-human_repetitive_region_filter]
                        [--microbe_repetitive_region_filter | --no-microbe_repetitive_region_filter]
                        [--short_alignment_filter | --no-short_alignment_filter]
                        [--unique_alignment | --no-unique_alignment]
                        [--noise_projection | --no-noise_projection]
                        [--similar_species_marker | --no-similar_species_marker]
                        [--mapping_only | --no-mapping_only]
                        [--reassign_read_id | --no-reassign_read_id]
                        [--all_taxon_module_steps | --filter_fq_only]
                        [--taxon_and_AMR_module | --taxon_module_only | --AMR_module_only | --amplicon_filter_module]
                        [--reassignment | --no-reassignment]
                        [--assembly_selection | --no-assembly_selection]
                        [--species_level | --strain_level]
                        [--output_adaptor_trimmed_query | --no-output_adaptor_trimmed_query]
                        [--output_trimmed_and_filtered_query | --no-output_trimmed_and_filtered_query]
                        [--output_human_and_decoy_filtered_query | --no-output_human_and_decoy_filtered_query]
                        [--output_PAF | --no-output_PAF]
                        [--output_noise_stat | --no-output_noise_stat]
                        [--output_separate_noise_bed | --no-output_separate_noise_bed]
                        [--output_raw_signal | --no-output_raw_signal]
                        [--output_id_signal | --no-output_id_signal]
                        [--output_per_read_data | --no-output_per_read_data]
                        [--output_quality_score_histogram | --no-output_quality_score_histogram]
                        [--output_read_length_histogram | --no-output_read_length_histogram]
                        [--output_human_stat | --no-output_human_stat]
                        [--output_decoy_stat | --no-output_decoy_stat]
                        [--output_genome_set | --no-output_genome_set]
                        [--temp_folder TEMP_FOLDER] [--RAM_folder RAM_FOLDER]
                        [--taxonomy_db TAXONOMY_DB]
                        [--tool_folder TOOL_FOLDER]
                        [--config_folder CONFIG_FOLDER]
                        [--assembly_folder ASSEMBLY_FOLDER]
                        [--db_folder DB_FOLDER] [--aligner ALIGNER]
                        [--read_simulator READ_SIMULATOR]
                        [--read_simulation_profiles READ_SIMULATION_PROFILES]
                        [--aligner_log ALIGNER_LOG]
                        [--read_sim_log READ_SIM_LOG]
                        [--adaptor_trimming_log ADAPTOR_TRIMMING_LOG]
                        [--python PYTHON]
                        [--human_repetitive_region_filter_assembly_id HUMAN_REPETITIVE_REGION_FILTER_ASSEMBLY_ID]
                        [--max_aligner_thread MAX_ALIGNER_THREAD]
                        [--max_aligner_target_GBase_per_batch MAX_ALIGNER_TARGET_GBASE_PER_BATCH]
                        [--max_porechop_thread MAX_PORECHOP_THREAD]
                        [--max_AMR_thread MAX_AMR_THREAD]
                        [--amplicon_human_filter_db_path AMPLICON_HUMAN_FILTER_DB_PATH]
                        [--amplicon_human_filter_db_sequence_id AMPLICON_HUMAN_FILTER_DB_SEQUENCE_ID]
                        [--amplicon_decoy_filter_db_path AMPLICON_DECOY_FILTER_DB_PATH]
                        [--amplicon_taxon_filter_db_path AMPLICON_TAXON_FILTER_DB_PATH]
                        [--genus_height GENUS_HEIGHT]
                        [--min_alignment_score MIN_ALIGNMENT_SCORE]
                        [--head_crop HEAD_CROP] [--tail_crop TAIL_CROP]
                        [--min_read_length MIN_READ_LENGTH]
                        [--min_read_quality MIN_READ_QUALITY]
                        [--human_filter_alignment_score_threshold HUMAN_FILTER_ALIGNMENT_SCORE_THRESHOLD]
                        [--human_filter_alignment_score_percent_threshold HUMAN_FILTER_ALIGNMENT_SCORE_PERCENT_THRESHOLD]
                        [--decoy_filter_alignment_score_threshold DECOY_FILTER_ALIGNMENT_SCORE_THRESHOLD]
                        [--decoy_filter_alignment_score_percent_threshold DECOY_FILTER_ALIGNMENT_SCORE_PERCENT_THRESHOLD]
                        [--species_id_min_aligned_bp SPECIES_ID_MIN_ALIGNED_BP]
                        [--good_alignment_threshold GOOD_ALIGNMENT_THRESHOLD]
                        [--assembly_id_min_average_depth ASSEMBLY_ID_MIN_AVERAGE_DEPTH]
                        [--variable_region_percent VARIABLE_REGION_PERCENT]
                        [--expected_max_depth_stdev EXPECTED_MAX_DEPTH_STDEV]
                        [--microbe_repetitive_region_filter_abundance_threshold_80 MICROBE_REPETITIVE_REGION_FILTER_ABUNDANCE_THRESHOLD_80]
                        [--microbe_repetitive_region_filter_abundance_threshold_90 MICROBE_REPETITIVE_REGION_FILTER_ABUNDANCE_THRESHOLD_90]
                        [--microbe_repetitive_region_filter_abundance_threshold_95 MICROBE_REPETITIVE_REGION_FILTER_ABUNDANCE_THRESHOLD_95]
                        [--microbe_repetitive_region_filter_abundance_threshold_98 MICROBE_REPETITIVE_REGION_FILTER_ABUNDANCE_THRESHOLD_98]
                        [--microbe_repetitive_region_filter_abundance_threshold_99 MICROBE_REPETITIVE_REGION_FILTER_ABUNDANCE_THRESHOLD_99]
                        [--microbe_repetitive_region_filter_abundance_threshold_99_2 MICROBE_REPETITIVE_REGION_FILTER_ABUNDANCE_THRESHOLD_99_2]
                        [--microbe_repetitive_region_filter_targeted_max_span_percent MICROBE_REPETITIVE_REGION_FILTER_TARGETED_MAX_SPAN_PERCENT]
                        [--microbe_repetitive_region_filter_allowed_max_span_percent MICROBE_REPETITIVE_REGION_FILTER_ALLOWED_MAX_SPAN_PERCENT]
                        [--microbe_repetitive_region_filter_min_average_depth MICROBE_REPETITIVE_REGION_FILTER_MIN_AVERAGE_DEPTH]
                        [--microbe_repetitive_region_filter_max_span_percent_overall MICROBE_REPETITIVE_REGION_FILTER_MAX_SPAN_PERCENT_OVERALL]
                        [--max_alignment_noise_overlap MAX_ALIGNMENT_NOISE_OVERLAP]
                        [--min_alignment_length MIN_ALIGNMENT_LENGTH]
                        [--closing_expected_max_depth_stdev CLOSING_EXPECTED_MAX_DEPTH_STDEV]
                        [--unique_alignment_threshold UNIQUE_ALIGNMENT_THRESHOLD]
                        [--number_of_genus_to_perform_noise_projection NUMBER_OF_GENUS_TO_PERFORM_NOISE_PROJECTION]
                        [--min_percent_abundance_to_perform_noise_projection MIN_PERCENT_ABUNDANCE_TO_PERFORM_NOISE_PROJECTION]
                        [--noise_projection_simulated_read_length_bin_size NOISE_PROJECTION_SIMULATED_READ_LENGTH_BIN_SIZE]
                        [--noise_projection_simulated_read_length_multiplier NOISE_PROJECTION_SIMULATED_READ_LENGTH_MULTIPLIER]
                        [--noise_projection_simulated_read_error_profile NOISE_PROJECTION_SIMULATED_READ_ERROR_PROFILE]
                        [--noise_projection_num_read_to_simulate NOISE_PROJECTION_NUM_READ_TO_SIMULATE]
                        [--similar_species_marker_num_genus SIMILAR_SPECIES_MARKER_NUM_GENUS]
                        [--similar_species_marker_alignment_similarity_1 {99,98,95,90,80}]
                        [--similar_species_marker_aligned_region_threshold_1 SIMILAR_SPECIES_MARKER_ALIGNED_REGION_THRESHOLD_1]
                        [--similar_species_marker_alignment_similarity_2 {99,98,95,90,80}]
                        [--similar_species_marker_aligned_region_threshold_2 SIMILAR_SPECIES_MARKER_ALIGNED_REGION_THRESHOLD_2]
                        [--similar_species_marker_similarity_combine_logic {and,or}]
                        [--quality_score_bin_size QUALITY_SCORE_BIN_SIZE]
                        [--read_length_bin_size READ_LENGTH_BIN_SIZE]
                        [--human HUMAN] [--decoy DECOY] [--species SPECIES]
                        [--assembly ASSEMBLY] --query QUERY
                        [--output_prefix OUTPUT_PREFIX]
                        [--output_folder OUTPUT_FOLDER]
                        [--archive_format {zip,tar,gztar,bztar}]

MegaPath-Nano: Compositional Analysis

optional arguments:
  -h, --help            show this help message and exit
  --debug
  --adaptor_trimming
  --no-adaptor_trimming
  --read_trimming
  --no-read_trimming
  --read_filter
  --no-read_filter
  --human_filter
  --no-human_filter
  --decoy_filter
  --no-decoy_filter
  --variable_region_adjustment
  --no-variable_region_adjustment
  --spike_filter        beta version
  --no-spike_filter
  --closing_spike_filter
                        beta version
  --no-closing_spike_filter
  --human_repetitive_region_filter
                        beta version
  --no-human_repetitive_region_filter
  --microbe_repetitive_region_filter
                        beta version
  --no-microbe_repetitive_region_filter
  --short_alignment_filter
  --no-short_alignment_filter
  --unique_alignment
  --no-unique_alignment
  --noise_projection
  --no-noise_projection
  --similar_species_marker
  --no-similar_species_marker
  --mapping_only
  --no-mapping_only
  --reassign_read_id
  --no-reassign_read_id
  --all_taxon_module_steps
  --filter_fq_only
  --taxon_and_AMR_module
  --taxon_module_only
  --AMR_module_only
  --amplicon_filter_module
  --reassignment
  --no-reassignment
  --assembly_selection
  --no-assembly_selection
  --species_level
  --strain_level        beta version
  --output_adaptor_trimmed_query
  --no-output_adaptor_trimmed_query
  --output_trimmed_and_filtered_query
  --no-output_trimmed_and_filtered_query
  --output_human_and_decoy_filtered_query
  --no-output_human_and_decoy_filtered_query
  --output_PAF
  --no-output_PAF
  --output_noise_stat
  --no-output_noise_stat
  --output_separate_noise_bed
  --no-output_separate_noise_bed
  --output_raw_signal
  --no-output_raw_signal
  --output_id_signal
  --no-output_id_signal
  --output_per_read_data
  --no-output_per_read_data
  --output_quality_score_histogram
  --no-output_quality_score_histogram
  --output_read_length_histogram
  --no-output_read_length_histogram
  --output_human_stat
  --no-output_human_stat
  --output_decoy_stat
  --no-output_decoy_stat
  --output_genome_set
  --no-output_genome_set
  --temp_folder TEMP_FOLDER
                        temporary folder
  --RAM_folder RAM_FOLDER
                        temporary folder in RAM
  --taxonomy_db TAXONOMY_DB
                        taxonomy database
  --tool_folder TOOL_FOLDER
                        Tool folder
  --config_folder CONFIG_FOLDER
                        Config file folder
  --assembly_folder ASSEMBLY_FOLDER
                        Assembly folder
  --db_folder DB_FOLDER
                        Db folder
  --aligner ALIGNER     Aligner program
  --read_simulator READ_SIMULATOR
                        Read simulation program
  --read_simulation_profiles READ_SIMULATION_PROFILES
                        Read simulation profiles
  --aligner_log ALIGNER_LOG
                        Log for stderr output from aligner program
  --read_sim_log READ_SIM_LOG
                        Log for stderr output from read simulator
  --adaptor_trimming_log ADAPTOR_TRIMMING_LOG
                        Log for stdout output from adaptor trimming program
  --python PYTHON       Python entry point
  --human_repetitive_region_filter_assembly_id HUMAN_REPETITIVE_REGION_FILTER_ASSEMBLY_ID
                        Assembly ID for human similar region filter
  --max_aligner_thread MAX_ALIGNER_THREAD
                        Maximum number of threads used by aligner
  --max_aligner_target_GBase_per_batch MAX_ALIGNER_TARGET_GBASE_PER_BATCH
                        Maximum size of reference loaded in memory per batch
                        by aligner
  --max_porechop_thread MAX_PORECHOP_THREAD
                        Maximum number of threads used by porechop
  --max_AMR_thread MAX_AMR_THREAD
                        Maximum number of threads used by AMR module
  --amplicon_human_filter_db_path AMPLICON_HUMAN_FILTER_DB_PATH
                        Human database path for amplicon filter module
  --amplicon_human_filter_db_sequence_id AMPLICON_HUMAN_FILTER_DB_SEQUENCE_ID
                        Human database sequence id for amplicon filter module
  --amplicon_decoy_filter_db_path AMPLICON_DECOY_FILTER_DB_PATH
                        Decoy database path for amplicon filter module
  --amplicon_taxon_filter_db_path AMPLICON_TAXON_FILTER_DB_PATH
                        Taxon database path for amplicon filter module
  --genus_height GENUS_HEIGHT
                        Height in taxonomy to be considered as genus. Full
                        rank info in db_preparation/genAssemblyMetadata.py
  --min_alignment_score MIN_ALIGNMENT_SCORE
                        Min alignment score
  --head_crop HEAD_CROP
                        Number of nucleotides to crop at start of reads
  --tail_crop TAIL_CROP
                        Number of nucleotides to crop at end of reads
  --min_read_length MIN_READ_LENGTH
                        Minimum read length
  --min_read_quality MIN_READ_QUALITY
                        Minimum average base quality of read
  --human_filter_alignment_score_threshold HUMAN_FILTER_ALIGNMENT_SCORE_THRESHOLD
                        Alignment score threshold for flagging a read as a
                        human read
  --human_filter_alignment_score_percent_threshold HUMAN_FILTER_ALIGNMENT_SCORE_PERCENT_THRESHOLD
                        Alignment score (normalized by read length) threshold
                        (in percent) for flagging a read as a human read
  --decoy_filter_alignment_score_threshold DECOY_FILTER_ALIGNMENT_SCORE_THRESHOLD
                        Alignment score threshold for flagging a read as a
                        decoy read
  --decoy_filter_alignment_score_percent_threshold DECOY_FILTER_ALIGNMENT_SCORE_PERCENT_THRESHOLD
                        Alignment score (normalized by read length) threshold
                        (in percent) for flagging a read as a decoy read
  --species_id_min_aligned_bp SPECIES_ID_MIN_ALIGNED_BP
                        Min aligned base pairs to include a species for
                        analysis
  --good_alignment_threshold GOOD_ALIGNMENT_THRESHOLD
                        Alignment score threshold in percentage of best
                        alignment score
  --assembly_id_min_average_depth ASSEMBLY_ID_MIN_AVERAGE_DEPTH
                        Min average depth to perform assembly selection
                        (default skip assembly selection)
  --variable_region_percent VARIABLE_REGION_PERCENT
                        Maximum percentage of strands aligned for a region to
                        be labeled as variable
  --expected_max_depth_stdev EXPECTED_MAX_DEPTH_STDEV
                        Number of standard deviations for calculating expected
                        max depth
  --microbe_repetitive_region_filter_abundance_threshold_80 MICROBE_REPETITIVE_REGION_FILTER_ABUNDANCE_THRESHOLD_80
                        Difference (no. of times) in apparent abundance to
                        trigger similar region filter with
                        80{'option_strings': ['--microbe_repetitive_region_fil
                        ter_abundance_threshold_80'], 'dest': 'microbe_repetit
                        ive_region_filter_abundance_threshold_80', 'nargs':
                        None, 'const': None, 'default': 160, 'type': 'float',
                        'choices': None, 'required': False, 'help':
                        'Difference (no. of times) in apparent abundance to
                        trigger similar region filter with 80% similarity',
                        'metavar': None, 'container': <argparse._ArgumentGroup
                        object at 0x7942787dbdd8>, 'prog':
                        'megapath_nano.py'}imilarity
  --microbe_repetitive_region_filter_abundance_threshold_90 MICROBE_REPETITIVE_REGION_FILTER_ABUNDANCE_THRESHOLD_90
                        Difference (no. of times) in apparent abundance to
                        trigger similar region filter with
                        90{'option_strings': ['--microbe_repetitive_region_fil
                        ter_abundance_threshold_90'], 'dest': 'microbe_repetit
                        ive_region_filter_abundance_threshold_90', 'nargs':
                        None, 'const': None, 'default': 80, 'type': 'float',
                        'choices': None, 'required': False, 'help':
                        'Difference (no. of times) in apparent abundance to
                        trigger similar region filter with 90% similarity',
                        'metavar': None, 'container': <argparse._ArgumentGroup
                        object at 0x7942787dbdd8>, 'prog':
                        'megapath_nano.py'}imilarity
  --microbe_repetitive_region_filter_abundance_threshold_95 MICROBE_REPETITIVE_REGION_FILTER_ABUNDANCE_THRESHOLD_95
                        Difference (no. of times) in apparent abundance to
                        trigger similar region filter with
                        95{'option_strings': ['--microbe_repetitive_region_fil
                        ter_abundance_threshold_95'], 'dest': 'microbe_repetit
                        ive_region_filter_abundance_threshold_95', 'nargs':
                        None, 'const': None, 'default': 40, 'type': 'float',
                        'choices': None, 'required': False, 'help':
                        'Difference (no. of times) in apparent abundance to
                        trigger similar region filter with 95% similarity',
                        'metavar': None, 'container': <argparse._ArgumentGroup
                        object at 0x7942787dbdd8>, 'prog':
                        'megapath_nano.py'}imilarity
  --microbe_repetitive_region_filter_abundance_threshold_98 MICROBE_REPETITIVE_REGION_FILTER_ABUNDANCE_THRESHOLD_98
                        Difference (no. of times) in apparent abundance to
                        trigger similar region filter with
                        98{'option_strings': ['--microbe_repetitive_region_fil
                        ter_abundance_threshold_98'], 'dest': 'microbe_repetit
                        ive_region_filter_abundance_threshold_98', 'nargs':
                        None, 'const': None, 'default': 16, 'type': 'float',
                        'choices': None, 'required': False, 'help':
                        'Difference (no. of times) in apparent abundance to
                        trigger similar region filter with 98% similarity',
                        'metavar': None, 'container': <argparse._ArgumentGroup
                        object at 0x7942787dbdd8>, 'prog':
                        'megapath_nano.py'}imilarity
  --microbe_repetitive_region_filter_abundance_threshold_99 MICROBE_REPETITIVE_REGION_FILTER_ABUNDANCE_THRESHOLD_99
                        Difference (no. of times) in apparent abundance to
                        trigger similar region filter with
                        99{'option_strings': ['--microbe_repetitive_region_fil
                        ter_abundance_threshold_99'], 'dest': 'microbe_repetit
                        ive_region_filter_abundance_threshold_99', 'nargs':
                        None, 'const': None, 'default': 8, 'type': 'float',
                        'choices': None, 'required': False, 'help':
                        'Difference (no. of times) in apparent abundance to
                        trigger similar region filter with 99% similarity',
                        'metavar': None, 'container': <argparse._ArgumentGroup
                        object at 0x7942787dbdd8>, 'prog':
                        'megapath_nano.py'}imilarity
  --microbe_repetitive_region_filter_abundance_threshold_99_2 MICROBE_REPETITIVE_REGION_FILTER_ABUNDANCE_THRESHOLD_99_2
                        Difference (no. of times) in apparent abundance to
                        trigger similar region filter with
                        99.2{'option_strings': ['--microbe_repetitive_region_f
                        ilter_abundance_threshold_99_2'], 'dest': 'microbe_rep
                        etitive_region_filter_abundance_threshold_99_2',
                        'nargs': None, 'const': None, 'default': 6.4, 'type':
                        'float', 'choices': None, 'required': False, 'help':
                        'Difference (no. of times) in apparent abundance to
                        trigger similar region filter with 99.2% similarity',
                        'metavar': None, 'container': <argparse._ArgumentGroup
                        object at 0x7942787dbdd8>, 'prog':
                        'megapath_nano.py'}imilarity
  --microbe_repetitive_region_filter_targeted_max_span_percent MICROBE_REPETITIVE_REGION_FILTER_TARGETED_MAX_SPAN_PERCENT
                        Maximum percent of regions (targeted) to be marked as
                        similar region
  --microbe_repetitive_region_filter_allowed_max_span_percent MICROBE_REPETITIVE_REGION_FILTER_ALLOWED_MAX_SPAN_PERCENT
                        Maximum percent of regions (allowed) to be marked as
                        similar region
  --microbe_repetitive_region_filter_min_average_depth MICROBE_REPETITIVE_REGION_FILTER_MIN_AVERAGE_DEPTH
                        Minimum average depth to be considered as source of
                        noise
  --microbe_repetitive_region_filter_max_span_percent_overall MICROBE_REPETITIVE_REGION_FILTER_MAX_SPAN_PERCENT_OVERALL
                        Maximum percent of regions to be marked as similar
                        region (overall)
  --max_alignment_noise_overlap MAX_ALIGNMENT_NOISE_OVERLAP
                        The maximum percent for an alignment to overlap with
                        noise regions without being removed
  --min_alignment_length MIN_ALIGNMENT_LENGTH
                        Minimum alignment length to be considered as evidence
  --closing_expected_max_depth_stdev CLOSING_EXPECTED_MAX_DEPTH_STDEV
                        Number of standard deviations for calculating expected
                        max depth for closing spike filter
  --unique_alignment_threshold UNIQUE_ALIGNMENT_THRESHOLD
                        Unique alignments shall have no alignments with
                        alignment score within this percent
  --number_of_genus_to_perform_noise_projection NUMBER_OF_GENUS_TO_PERFORM_NOISE_PROJECTION
                        Number of genus to perform noise projection
  --min_percent_abundance_to_perform_noise_projection MIN_PERCENT_ABUNDANCE_TO_PERFORM_NOISE_PROJECTION
                        Minimum percent of abundance relative to the most
                        abundant species in a genus to perform noise
                        projection
  --noise_projection_simulated_read_length_bin_size NOISE_PROJECTION_SIMULATED_READ_LENGTH_BIN_SIZE
                        Read length bin size for generating simulated reads
  --noise_projection_simulated_read_length_multiplier NOISE_PROJECTION_SIMULATED_READ_LENGTH_MULTIPLIER
                        Multiplier over average read length to obtain maximum
                        read length
  --noise_projection_simulated_read_error_profile NOISE_PROJECTION_SIMULATED_READ_ERROR_PROFILE
                        Error profile for generating simulated reads
  --noise_projection_num_read_to_simulate NOISE_PROJECTION_NUM_READ_TO_SIMULATE
                        Number of simulated reads to generate
  --similar_species_marker_num_genus SIMILAR_SPECIES_MARKER_NUM_GENUS
                        Number of top most abundant species (1 per genus) to
                        be considered as possible source of noise
  --similar_species_marker_alignment_similarity_1 {99,98,95,90,80}
                        Similarity cutoff (1) used for alignment
  --similar_species_marker_aligned_region_threshold_1 SIMILAR_SPECIES_MARKER_ALIGNED_REGION_THRESHOLD_1
                        Percentage of aligned region (1) to be considered as
                        highly similar
  --similar_species_marker_alignment_similarity_2 {99,98,95,90,80}
                        Similarity cutoff (2) used for alignment
  --similar_species_marker_aligned_region_threshold_2 SIMILAR_SPECIES_MARKER_ALIGNED_REGION_THRESHOLD_2
                        Percentage of aligned region (2) to be considered as
                        highly similar
  --similar_species_marker_similarity_combine_logic {and,or}
                        Logic for combining criteria 1 and 2 (and / or)
  --quality_score_bin_size QUALITY_SCORE_BIN_SIZE
                        Bin size for quality score histogram
  --read_length_bin_size READ_LENGTH_BIN_SIZE
                        Bin size for read length histogram
  --human HUMAN         Human genome set
  --decoy DECOY         Decoy genome set
  --species SPECIES     Genome set for species identification
  --assembly ASSEMBLY   Genome set for assembly identification
  --query QUERY         Query file (fastq or fasta)
  --output_prefix OUTPUT_PREFIX
                        Output prefix
  --output_folder OUTPUT_FOLDER
                        Output folder
  --archive_format {zip,tar,gztar,bztar}
                        Format used for archive file
```


## megapath-nano_megapath_nano_amr.py

### Tool Description
MegaPath-Nano: AMR Detection

### Metadata
- **Docker Image**: quay.io/biocontainers/megapath-nano:2--hee3b9ab_0
- **Homepage**: https://github.com/HKU-BAL/MegaPath-Nano
- **Package**: https://anaconda.org/channels/bioconda/packages/megapath-nano/overview
- **Validation**: PASS

### Original Help Text
```text
usage: megapath_nano_amr.py [-h] --query_bam QUERY_BAM --output_folder
                            OUTPUT_FOLDER [--taxon TAXON] [--threads THREADS]
                            [--blast_perc_identity BLAST_PERC_IDENTITY]
                            [--blast_qcov_hsp_perc BLAST_QCOV_HSP_PERC]
                            [--REFSEQ_PATH REFSEQ_PATH]
                            [--NANO_DIR_PATH NANO_DIR_PATH]
                            [--CBMAR_PROT_DB_PATH CBMAR_PROT_DB_PATH]
                            [--FAMILY_DETAILS_PATH FAMILY_DETAILS_PATH]

MegaPath-Nano: AMR Detection

optional arguments:
  -h, --help            show this help message and exit
  --query_bam QUERY_BAM
                        Input sorted and indexed bam
  --output_folder OUTPUT_FOLDER
                        Output directory
  --taxon TAXON         Taxon-specific options for AMRFinder, curated
                        organisms: Campylobacter, Enterococcus_faecalis,
                        Enterococcus_faecium, Escherichia, Klebsiella,
                        Salmonella, Staphylococcus_aureus,
                        Staphylococcus_pseudintermedius, Vibrio_cholerae
  --threads THREADS     Num of threads
  --blast_perc_identity BLAST_PERC_IDENTITY
                        The threshold of percentage of identical matches in
                        blast
  --blast_qcov_hsp_perc BLAST_QCOV_HSP_PERC
                        The threshold of percentage of query coverage in blast
  --REFSEQ_PATH REFSEQ_PATH
                        The path of reference files. RefSeq by default
  --NANO_DIR_PATH NANO_DIR_PATH
                        The path of root directory of MegaPath-Nano
  --CBMAR_PROT_DB_PATH CBMAR_PROT_DB_PATH
                        The path of betalactamase family details in protein,
                        collected from http://proteininformatics.org/mkumar/la
                        ctamasedb/cllasification.html.
  --FAMILY_DETAILS_PATH FAMILY_DETAILS_PATH
                        The path of betalactamase family details in protein,
                        collected from http://proteininformatics.org/mkumar/la
                        ctamasedb/cllasification.html.
```


## megapath-nano_runMegaPath-Nano-Amplicon.sh

### Tool Description
Runs the MegaPath-Nano amplicon pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/megapath-nano:2--hee3b9ab_0
- **Homepage**: https://github.com/HKU-BAL/MegaPath-Nano
- **Package**: https://anaconda.org/channels/bioconda/packages/megapath-nano/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/runMegaPath-Nano-Amplicon.sh -r <read.fq> [options]
    -p  output prefix [megapath-nano-amplicon]
    -t  number of threads [24]
    -d  database directory [/usr/local/MegaPath-Nano/bin/db]
```


## Metadata
- **Skill**: generated
