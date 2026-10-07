cwlVersion: v1.2
class: CommandLineTool
baseCommand: cc.bin
label: canopy_cc.bin
doc: "Cluster abundance profiles into co-abundant gene groups (MGS) using canopy
  clustering (canopy2, cc.bin). cc.bin prints no usage text; the options come from
  the program source (options.cpp, v0.25).\n\nTool homepage: https://github.com/hildebra/canopy2/"
inputs:
  - id: input_file_path
    type: File
    doc: Tab-separated abundance matrix with a header line; each row is a
      profile ID followed by its sample values
    inputBinding:
      position: 101
      prefix: --input_file_path
  - id: output_clusters_file_path
    type:
      - 'null'
      - string
    doc: 'Output file with cluster (canopy) membership (default: clusters_out)'
    inputBinding:
      position: 101
      prefix: --output_clusters_file_path
  - id: output_cluster_profiles_file
    type:
      - 'null'
      - string
    doc: Output file with the profile of each cluster
    inputBinding:
      position: 101
      prefix: --output_cluster_profiles_file
  - id: output_clusters_partial_file_path
    type:
      - 'null'
      - string
    doc: Output file with partial cluster membership
    inputBinding:
      position: 101
      prefix: --output_clusters_partial_file_path
  - id: cluster_name_prefix
    type:
      - 'null'
      - string
    doc: Prefix for cluster names (e.g. MGS)
    inputBinding:
      position: 101
      prefix: --cluster_name_prefix
  - id: priority_reads_file_path
    type:
      - 'null'
      - File
    doc: File with profile IDs to use first as canopy seeds
    inputBinding:
      position: 101
      prefix: --priority_reads_file_path
  - id: guide_matrix
    type:
      - 'null'
      - File
    doc: Guide profiles (no header; guide ID followed by the same samples as the
      input matrix) for guided clustering
    inputBinding:
      position: 101
      prefix: --guide_matrix
  - id: reference_mb2
    type:
      - 'null'
      - File
    doc: MetaBAT2-derived guides; tab-separated bin_id and profile_id
    inputBinding:
      position: 101
      prefix: --referenceMB2
  - id: max_mb2_genes
    type:
      - 'null'
      - int
    doc: 'Maximum number of genes used per MetaBAT2 bin (default: 1000)'
    inputBinding:
      position: 101
      prefix: --maxMB2genes
  - id: profile_measure
    type:
      - 'null'
      - string
    doc: 'Measure used to build cluster profiles, e.g. 75Q or median (default: 75Q)'
    inputBinding:
      position: 101
      prefix: --profile_measure
  - id: input_filter_file
    type:
      - 'null'
      - string
    doc: Output file listing the input profiles removed by the filters
    inputBinding:
      position: 101
      prefix: --input_filter_file
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (default: 1)'
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: seed
    type:
      - 'null'
      - int
    doc: Random number generator seed
    inputBinding:
      position: 101
      prefix: --seed
  - id: verbosity
    type:
      - 'null'
      - string
    doc: 'Verbosity level (default: info)'
    inputBinding:
      position: 101
      prefix: --verbosity
  - id: sample_dist_mat_file
    type:
      - 'null'
      - string
    doc: Output file for the sample distance matrix (autocorrelation filter)
    inputBinding:
      position: 101
      prefix: --sampleDistMatFile
  - id: sample_dist_log
    type:
      - 'null'
      - string
    doc: Output log of samples removed by the autocorrelation filter
    inputBinding:
      position: 101
      prefix: --sampleDistLog
  - id: sample_min_dist
    type:
      - 'null'
      - float
    doc: 'Minimum distance between samples; closer (autocorrelated) samples are removed
      (default: 2, i.e. off)'
    inputBinding:
      position: 101
      prefix: --sampleMinDist
  - id: max_canopy_dist
    type:
      - 'null'
      - float
    doc: 'Maximum distance of a profile to the canopy center (default: 0.1)'
    inputBinding:
      position: 101
      prefix: --max_canopy_dist
  - id: max_canopy_dist_part
    type:
      - 'null'
      - float
    doc: 'Maximum distance for partial canopy membership (default: max_canopy_dist)'
    inputBinding:
      position: 101
      prefix: --max_canopy_dist_part
  - id: max_close_dist
    type:
      - 'null'
      - float
    doc: 'Maximum distance for close neighbours used in canopy walks (default: 0.6)'
    inputBinding:
      position: 101
      prefix: --max_close_dist
  - id: max_merge_dist
    type:
      - 'null'
      - float
    doc: 'Maximum distance between canopies to merge them (default: 0.1)'
    inputBinding:
      position: 101
      prefix: --max_merge_dist
  - id: min_step_dist
    type:
      - 'null'
      - float
    doc: 'Minimum step distance of a canopy walk (default: 0.001)'
    inputBinding:
      position: 101
      prefix: --min_step_dist
  - id: filter_min_obs
    type:
      - 'null'
      - int
    doc: 'Minimum number of samples with a non-zero value for an input profile (default:
      3)'
    inputBinding:
      position: 101
      prefix: --filter_min_obs
  - id: filter_max_top3_sample_contribution
    type:
      - 'null'
      - float
    doc: 'Maximum signal fraction from the top 3 samples for an input profile (default:
      0.9)'
    inputBinding:
      position: 101
      prefix: --filter_max_top3_sample_contribution
  - id: cag_filter_min_sample_obs
    type:
      - 'null'
      - int
    doc: 'Minimum number of samples with a non-zero value for a cluster (default: 3)'
    inputBinding:
      position: 101
      prefix: --cag_filter_min_sample_obs
  - id: cag_filter_max_top3_sample_contribution
    type:
      - 'null'
      - float
    doc: 'Maximum signal fraction from the top 3 samples for a cluster (default: 0.9)'
    inputBinding:
      position: 101
      prefix: --cag_filter_max_top3_sample_contribution
  - id: stop_criteria
    type:
      - 'null'
      - int
    doc: 'Stop after this many seeds are processed without a new canopy; 0 = never
      (default: 50000)'
    inputBinding:
      position: 101
      prefix: --stop_criteria
  - id: not_processed_profiles_file
    type:
      - 'null'
      - string
    doc: Output file for profiles not processed when clustering stops early
    inputBinding:
      position: 101
      prefix: --not_processed_profiles_file
  - id: progress_stat_file
    type:
      - 'null'
      - string
    doc: 'Output file with progress statistics (default: canopy_progress.out)'
    inputBinding:
      position: 101
      prefix: --progress_stat_file
  - id: max_num_canopy_walks
    type:
      - 'null'
      - int
    doc: 'Maximum number of canopy walks (default: 6)'
    inputBinding:
      position: 101
      prefix: --max_num_canopy_walks
  - id: dont_create_progress_stat_file
    type:
      - 'null'
      - boolean
    doc: Do not write the progress statistics file
    inputBinding:
      position: 101
      prefix: --dont_create_progress_stat_file
  - id: show_progress_bar
    type:
      - 'null'
      - boolean
    doc: Show a progress bar
    inputBinding:
      position: 101
      prefix: --show_progress_bar
  - id: print_time_statistics
    type:
      - 'null'
      - boolean
    doc: Toggle printing of time statistics (on by default; the flag turns it
      off)
    inputBinding:
      position: 101
      prefix: --print_time_statistics
  - id: die_on_kill
    type:
      - 'null'
      - boolean
    doc: Toggle dying on an interrupt signal (on by default; the flag makes the
      program stop and write output instead)
    inputBinding:
      position: 101
      prefix: --die_on_kill
  - id: high_mem
    type:
      - 'null'
      - boolean
    doc: Use a dense (non-sparse) matrix; faster but uses more memory
    inputBinding:
      position: 101
      prefix: --high_mem
  - id: redundant_guides
    type:
      - 'null'
      - boolean
    doc: Do not filter redundantly assigned genes in guided mode
    inputBinding:
      position: 101
      prefix: --redundant_guides
  - id: use_spearman
    type:
      - 'null'
      - boolean
    doc: Use Spearman instead of Pearson correlation distance
    inputBinding:
      position: 101
      prefix: --use_spearman
outputs:
  - id: clusters
    type: File
    doc: Cluster membership (cluster name and profile ID)
    outputBinding:
      glob: "$(inputs.output_clusters_file_path ? inputs.output_clusters_file_path
        : 'clusters_out')"
  - id: cluster_profiles
    type:
      - 'null'
      - File
    doc: Profile of each cluster
    outputBinding:
      glob: $(inputs.output_cluster_profiles_file)
  - id: clusters_partial
    type:
      - 'null'
      - File
    doc: Partial cluster membership
    outputBinding:
      glob: $(inputs.output_clusters_partial_file_path)
  - id: filtered_profiles
    type:
      - 'null'
      - File
    doc: Input profiles removed by the filters
    outputBinding:
      glob: $(inputs.input_filter_file)
  - id: sample_dist_matrix
    type:
      - 'null'
      - File
    doc: Sample distance matrix
    outputBinding:
      glob: $(inputs.sample_dist_mat_file)
  - id: sample_dist_log_file
    type:
      - 'null'
      - File
    doc: Log of samples removed by the autocorrelation filter
    outputBinding:
      glob: $(inputs.sample_dist_log)
  - id: not_processed_profiles
    type:
      - 'null'
      - File
    doc: Profiles not processed when clustering stopped early
    outputBinding:
      glob: $(inputs.not_processed_profiles_file)
  - id: progress_stats
    type:
      - 'null'
      - File
    doc: Progress statistics
    outputBinding:
      glob: "$(inputs.progress_stat_file ? inputs.progress_stat_file : 'canopy_progress.out')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/canopy:0.25--h077b44d_1
