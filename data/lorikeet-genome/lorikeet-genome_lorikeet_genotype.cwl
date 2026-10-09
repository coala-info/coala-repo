cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lorikeet
  - genotype
label: lorikeet-genome_lorikeet_genotype
doc: "Experimental: report strain-level genotypes and abundances based on variant read mappings.\n\nTool homepage: https://github.com/rhysnewell/Lorikeet"
inputs:
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Path to BAM file(s). These must be reference sorted (e.g. with samtools sort) unless `--sharded` is specified, in which case they must be read name sorted (e.g. with `samtools sort -n`). When specified, no read mapping algorithm is undertaken."
    inputBinding:
      position: 100
      prefix: --bam-files
  - id: sharded
    type:
      - 'null'
      - boolean
    doc: "If `-b/--bam-files` was used: Input BAM files are read-sorted alignments of a set of reads mapped to multiple reference contig sets. Choose the best hit for each read pair. Otherwise if mapping was carried out: Map reads to each reference, choosing the best hit for each pair. [default: not set]"
    inputBinding:
      position: 101
      prefix: --sharded
  - id: exclude_genomes_from_deshard
    type:
      - 'null'
      - string
    doc: "exclude genomes from deshard"
    inputBinding:
      position: 102
      prefix: --exclude-genomes-from-deshard
  - id: read1
    type:
      - 'null'
      - type: array
        items: File
    doc: "read1"
    inputBinding:
      position: 103
      prefix: --read1
  - id: read2
    type:
      - 'null'
      - type: array
        items: File
    doc: "read2"
    inputBinding:
      position: 104
      prefix: --read2
  - id: coupled
    type:
      - 'null'
      - type: array
        items: File
    doc: "One or more pairs of forward and reverse possibly gzipped FASTA/Q files for mapping in order <sample1_R1.fq.gz> <sample1_R2.fq.gz> <sample2_R1.fq.gz> <sample2_R2.fq.gz> .."
    inputBinding:
      position: 105
      prefix: --coupled
  - id: interleaved
    type:
      - 'null'
      - type: array
        items: File
    doc: "Interleaved FASTA/Q files(s) for mapping. These may be gzipped or not."
    inputBinding:
      position: 106
      prefix: --interleaved
  - id: single
    type:
      - 'null'
      - type: array
        items: File
    doc: "Unpaired FASTA/Q files(s) for mapping. These may be gzipped or not."
    inputBinding:
      position: 107
      prefix: --single
  - id: longreads
    type:
      - 'null'
      - type: array
        items: File
    doc: "Longread FASTA/Q files(s) for mapping. These may be gzipped or not."
    inputBinding:
      position: 108
      prefix: --longreads
  - id: longread_bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Path to longread BAM file(s). These must be reference sorted (e.g. with samtools sort) unless `--sharded` is specified, in which case they must be read name sorted (e.g. with `samtools sort -n`). When specified, no read mapping algorithm is undertaken."
    inputBinding:
      position: 109
      prefix: --longread-bam-files
  - id: genome_fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "genome fasta files"
    secondaryFiles:
      - pattern: .fai
        required: true
    inputBinding:
      position: 110
      prefix: --genome-fasta-files
  - id: genome_fasta_directory
    type:
      - 'null'
      - Directory
    doc: "Directory containing FASTA files of contigs e.g. genomes or metagenome assembly [required unless `-r/--reference` is specified]"
    inputBinding:
      position: 111
      prefix: --genome-fasta-directory
  - id: genome_fasta_extension
    type:
      - 'null'
      - string
    doc: "FASTA file extension in --genome-fasta-directory [default 'fna'] [default: fna]"
    inputBinding:
      position: 112
      prefix: --genome-fasta-extension
  - id: features_vcf
    type:
      - 'null'
      - File
    doc: "The set of alleles to force-call regardless of evidence. Note: The sight containing these alleles has to be called as 'active' in order for them to appear in the final VCF. Addtionally, Provided file must be compressed using bgzip and indexed using bcftools index. If no index is present, and index will be attempted to be created. If the file is not properly compressed, Lorikeet will unfortunately SEGFAULT with no error message."
    inputBinding:
      position: 113
      prefix: --features-vcf
  - id: threads
    type:
      - 'null'
      - int
    doc: "Maximum number of threads used. [default: 8] [default: 10]"
    inputBinding:
      position: 114
      prefix: --threads
  - id: parallel_genomes
    type:
      - 'null'
      - int
    doc: "Number of genomes to run in parallel. Increases memory usage linearly. Thread usage qill not exceed the value provided by --threads [default 4] [default: 1]"
    inputBinding:
      position: 115
      prefix: --parallel-genomes
  - id: mapper
    type:
      - 'null'
      - string
    doc: "Underlying mapping software used for short reads [default: `minimap2-sr`]. One of:"
    inputBinding:
      position: 116
      prefix: --mapper
  - id: longread_mapper
    type:
      - 'null'
      - string
    doc: "Underlying mapping software used for long reads [default: `minimap2-sr`]. One of:"
    inputBinding:
      position: 117
      prefix: --longread-mapper
  - id: minimap2_params
    type:
      - 'null'
      - string
    doc: "Extra parameters to provide to minimap2, both indexing command (if used) and for mapping. Note that usage of this parameter has security implications if untrusted input is specified. '`-a`' is always specified to minimap2. [default: none]"
    inputBinding:
      position: 118
      prefix: --minimap2-params
  - id: bwa_params
    type:
      - 'null'
      - string
    doc: "Extra parameters to provide to BWA or BWA-MEM2. Note that usage of this parameter has security implications if untrusted input is specified. [default: none]"
    inputBinding:
      position: 119
      prefix: --bwa-params
  - id: keep_unmapped
    type:
      - 'null'
      - boolean
    doc: "keep unmapped"
    inputBinding:
      position: 120
      prefix: --keep-unmapped
  - id: split_bams
    type:
      - 'null'
      - boolean
    doc: "Split the mapped read files up per reference. Useful if you think run time is being hampered by I/O. Most of the time this will not improve performance and instead just increase disk usage."
    inputBinding:
      position: 121
      prefix: --split-bams
  - id: min_read_aligned_length
    type:
      - 'null'
      - int
    doc: "Exclude reads with smaller numbers of aligned bases. [default: `0`]"
    inputBinding:
      position: 122
      prefix: --min-read-aligned-length
  - id: min_read_percent_identity
    type:
      - 'null'
      - float
    doc: "Exclude reads by overall percent identity e.g. 95 for 95%. [default: `0`]"
    inputBinding:
      position: 123
      prefix: --min-read-percent-identity
  - id: min_read_aligned_percent
    type:
      - 'null'
      - float
    doc: "Exclude reads by percent aligned bases e.g. 95 means 95% of the read's bases must be aligned. [default: `0`] [default: 0.0]"
    inputBinding:
      position: 124
      prefix: --min-read-aligned-percent
  - id: min_read_aligned_length_pair
    type:
      - 'null'
      - int
    doc: "Exclude pairs with smaller numbers of aligned bases. Implies --proper-pairs-only. [default: `0`]"
    inputBinding:
      position: 125
      prefix: --min-read-aligned-length-pair
  - id: min_read_percent_identity_pair
    type:
      - 'null'
      - float
    doc: "Exclude pairs by overall percent identity e.g. 95 for 95%. Implies --proper-pairs-only. [default: `0`]"
    inputBinding:
      position: 126
      prefix: --min-read-percent-identity-pair
  - id: min_read_aligned_percent_pair
    type:
      - 'null'
      - float
    doc: "Exclude reads by percent aligned bases e.g. 95 means 95% of the read's bases must be aligned. Implies --proper-pairs-only. [default: `0`]"
    inputBinding:
      position: 127
      prefix: --min-read-aligned-percent-pair
  - id: min_covered_fraction
    type:
      - 'null'
      - float
    doc: "[default: 0.0]"
    inputBinding:
      position: 128
      prefix: --min-covered-fraction
  - id: min_contig_size
    type:
      - 'null'
      - int
    doc: "The minimum contig size to call variants on. Smaller contigs can often contain highly variable regions that mostly represent noise. Call variants on them can often be slow and not produce anything fruitful. If you wish to call variants on all available contigs, then set this to 0. [default: 2500] [default: 0]"
    inputBinding:
      position: 129
      prefix: --min-contig-size
  - id: phred_scaled_global_read_mismapping_rate
    type:
      - 'null'
      - int
    doc: "The global assumed mismapping rate for reads. [default: 45] [default: 45]"
    inputBinding:
      position: 130
      prefix: --phred-scaled-global-read-mismapping-rate
  - id: pair_hmm_gap_continuation_penalty
    type:
      - 'null'
      - int
    doc: "[default: 10]"
    inputBinding:
      position: 131
      prefix: --pair-hmm-gap-continuation-penalty
  - id: pcr_indel_model
    type:
      - 'null'
      - string
    doc: "The PCR indel model to use. [default: conservative] [default: conservative]"
    inputBinding:
      position: 132
      prefix: --pcr-indel-model
  - id: heterozygosity_stdev
    type:
      - 'null'
      - float
    doc: "Standard deviation of heterozygosity for SNP and indel calling. [default: 0.01] [default: 0.01]"
    inputBinding:
      position: 133
      prefix: --heterozygosity-stdev
  - id: snp_heterozygosity
    type:
      - 'null'
      - float
    doc: "[default: 0.001]"
    inputBinding:
      position: 134
      prefix: --snp-heterozygosity
  - id: indel_heterozygosity
    type:
      - 'null'
      - float
    doc: "Heterozygosity for indel calling. [default: 0.000125] [default: 0.000125]"
    inputBinding:
      position: 135
      prefix: --indel-heterozygosity
  - id: standard_min_confidence_threshold_for_calling
    type:
      - 'null'
      - float
    doc: "The minimum phred-scaled confidence threshold at which variants should be called. [default: 30.0] [default: 25.0]"
    inputBinding:
      position: 136
      prefix: --standard-min-confidence-threshold-for-calling
  - id: genotype_assignment_method
    type:
      - 'null'
      - string
    doc: "[default: UsePLsToAssign]"
    inputBinding:
      position: 137
      prefix: --genotype-assignment-method
  - id: use_posteriors_to_calculate_qual
    type:
      - 'null'
      - boolean
    doc: "if available, use the genotype posterior probabilities to calculate the site QUAL."
    inputBinding:
      position: 138
      prefix: --use-posteriors-to-calculate-qual
  - id: annotate_with_num_discovered_alleles
    type:
      - 'null'
      - boolean
    doc: "If provided, we will annotate records with the number of alternate alleles that were discovered (but not necessarily genotyped) at a given site."
    inputBinding:
      position: 139
      prefix: --annotate-with-num-discovered-alleles
  - id: active_probability_threshold
    type:
      - 'null'
      - float
    doc: "Minimum probability for a locus to be considered active. [default: 0.002] [default: 0.002]"
    inputBinding:
      position: 140
      prefix: --active-probability-threshold
  - id: min_assembly_region_size
    type:
      - 'null'
      - int
    doc: "Minimum size of an assembly region. [default: 50] [default: 50]"
    inputBinding:
      position: 141
      prefix: --min-assembly-region-size
  - id: max_assembly_region_size
    type:
      - 'null'
      - int
    doc: "Maximum size of an assembly region. [default: 300] [default: 300]"
    inputBinding:
      position: 142
      prefix: --max-assembly-region-size
  - id: kmer_sizes
    type:
      - 'null'
      - type: array
        items: int
    doc: "K-mer sizes used to generate DeBruijn Graphs. Multiple values at once are accepted and encouraged e.g. 10 25 [default: 10 25]"
    inputBinding:
      position: 143
      prefix: --kmer-sizes
  - id: disable_automatic_kmer_adjustment
    type:
      - 'null'
      - boolean
    doc: "disable automatic kmer adjustment"
    inputBinding:
      position: 144
      prefix: --disable-automatic-kmer-adjustment
  - id: max_allowed_path_for_read_threading_assembler
    type:
      - 'null'
      - int
    doc: "[default: 128]"
    inputBinding:
      position: 145
      prefix: --max-allowed-path-for-read-threading-assembler
  - id: dont_increase_kmer_sizes_for_cycles
    type:
      - 'null'
      - boolean
    doc: "Disable iterating over kmer sizes when graph cycles are detected."
    inputBinding:
      position: 146
      prefix: --dont-increase-kmer-sizes-for-cycles
  - id: allow_non_unique_kmers_in_ref
    type:
      - 'null'
      - boolean
    doc: "Allow graphs that have non-unique kmers in the reference."
    inputBinding:
      position: 147
      prefix: --allow-non-unique-kmers-in-ref
  - id: debug_graph_transformations
    type:
      - 'null'
      - boolean
    doc: "debug graph transformations"
    inputBinding:
      position: 148
      prefix: --debug-graph-transformations
  - id: do_not_recover_dangling_branches
    type:
      - 'null'
      - boolean
    doc: "do not recover dangling branches"
    inputBinding:
      position: 149
      prefix: --do-not-recover-dangling-branches
  - id: do_not_run_physical_phasing
    type:
      - 'null'
      - boolean
    doc: "Disable physical phasing."
    inputBinding:
      position: 150
      prefix: --do-not-run-physical-phasing
  - id: recover_all_dangling_branches
    type:
      - 'null'
      - boolean
    doc: "Recover all dangling branches."
    inputBinding:
      position: 151
      prefix: --recover-all-dangling-branches
  - id: min_dangling_branch_length
    type:
      - 'null'
      - int
    doc: "Minimum length of a dangling branch to attempt recovery. [default: 4] [default: 1]"
    inputBinding:
      position: 152
      prefix: --min-dangling-branch-length
  - id: num_pruning_samples
    type:
      - 'null'
      - int
    doc: "Number of samples that must pass the min_pruning threshold [default: 1] [default: 1]"
    inputBinding:
      position: 153
      prefix: --num-pruning-samples
  - id: min_prune_factor
    type:
      - 'null'
      - int
    doc: "Minimum support to not prune paths in the graph. [default: 2] [default: 1]"
    inputBinding:
      position: 154
      prefix: --min-prune-factor
  - id: disable_prune_factor_correction
    type:
      - 'null'
      - boolean
    doc: "disable prune factor correction"
    inputBinding:
      position: 155
      prefix: --disable-prune-factor-correction
  - id: use_adaptive_pruning
    type:
      - 'null'
      - boolean
    doc: "Use more advanced pruning algorithm to prune paths in graph. Better suited when performing variant calling on when depth along a genome is variable e.g. RNA and exome data."
    inputBinding:
      position: 156
      prefix: --use-adaptive-pruning
  - id: dont_use_soft_clipped_bases
    type:
      - 'null'
      - boolean
    doc: "Do not analyse soft clipped bases in the reads."
    inputBinding:
      position: 157
      prefix: --dont-use-soft-clipped-bases
  - id: initial_error_rate_for_pruning
    type:
      - 'null'
      - float
    doc: "Initial base error rate estimate for adaptive pruning. [default: 0.001] [default: 0.001]"
    inputBinding:
      position: 158
      prefix: --initial-error-rate-for-pruning
  - id: pruning_seeding_log_odds_threshold
    type:
      - 'null'
      - float
    doc: "[default: 4.0]"
    inputBinding:
      position: 159
      prefix: --pruning-seeding-log-odds-threshold
  - id: pruning_log_odds_threshold
    type:
      - 'null'
      - float
    doc: "Likelihood ratio threshold for adaptive pruning algorithm. This value will be converted to log odds value. [default: 1.0] [default: 1.0]"
    inputBinding:
      position: 160
      prefix: --pruning-log-odds-threshold
  - id: max_unpruned_variants
    type:
      - 'null'
      - int
    doc: "Maximum number of variants in graph the adaptive pruner will allow. [default: 100] [default: 100]"
    inputBinding:
      position: 161
      prefix: --max-unpruned-variants
  - id: max_input_depth
    type:
      - 'null'
      - int
    doc: "The maximum number of reads included within an assembly region across all samples. Larger numbers increase run time. If the depth of an assembly region exceeds this value, then the reads will be filtered by mean base quality. [default: 200000] [default: 200000]"
    inputBinding:
      position: 162
      prefix: --max-input-depth
  - id: min_variant_depth_for_genotyping
    type:
      - 'null'
      - int
    doc: "[default: 10]"
    inputBinding:
      position: 163
      prefix: --min-variant-depth-for-genotyping
  - id: contig_end_exclusion
    type:
      - 'null'
      - int
    doc: "Exclude bases at the ends of reference [default: 0]"
    inputBinding:
      position: 164
      prefix: --contig-end-exclusion
  - id: max_prob_propagation_distance
    type:
      - 'null'
      - int
    doc: "Upper limit on how many bases away probability mass can be moved around when calculating the boundaries between active and inactive assembly regions. [default: 50] [default: 50]"
    inputBinding:
      position: 165
      prefix: --max-prob-propagation-distance
  - id: use_linked_debruijn_graph
    type:
      - 'null'
      - boolean
    doc: "use linked debruijn graph"
    inputBinding:
      position: 166
      prefix: --use-linked-debruijn-graph
  - id: error_correct_reads
    type:
      - 'null'
      - boolean
    doc: "error correct reads"
    inputBinding:
      position: 167
      prefix: --error-correct-reads
  - id: kmer_length_for_read_error_correction
    type:
      - 'null'
      - int
    doc: "[default: 25]"
    inputBinding:
      position: 168
      prefix: --kmer-length-for-read-error-correction
  - id: min_observations_for_kmers_to_be_solid
    type:
      - 'null'
      - int
    doc: "[default: 20]"
    inputBinding:
      position: 169
      prefix: --min-observations-for-kmers-to-be-solid
  - id: max_mnp_distance
    type:
      - 'null'
      - int
    doc: "Two or more phased substitutions separated by this distance or less are merged into MNPs. [default: 0] [default: 0]"
    inputBinding:
      position: 170
      prefix: --max-mnp-distance
  - id: min_observation_for_kmer_to_be_solid
    type:
      - 'null'
      - int
    doc: "[default: 20]"
    inputBinding:
      position: 171
      prefix: --min-observation-for-kmer-to-be-solid
  - id: enable_legacy_graph_cycle_detection
    type:
      - 'null'
      - boolean
    doc: "enable legacy graph cycle detection"
    inputBinding:
      position: 172
      prefix: --enable-legacy-graph-cycle-detection
  - id: min_matching_bases_to_dangling_end_recovery
    type:
      - 'null'
      - int
    doc: "[default: -1]"
    inputBinding:
      position: 173
      prefix: --min-matching-bases-to-dangling-end-recovery
  - id: assembly_region_padding
    type:
      - 'null'
      - int
    doc: "Number of additional bases of context to include around each assembly region. [default: 100] [default: 100]"
    inputBinding:
      position: 174
      prefix: --assembly-region-padding
  - id: indel_padding_for_genotyping
    type:
      - 'null'
      - int
    doc: "[default: 75]"
    inputBinding:
      position: 175
      prefix: --indel-padding-for-genotyping
  - id: str_padding_for_genotyping
    type:
      - 'null'
      - int
    doc: "[default: 75]"
    inputBinding:
      position: 176
      prefix: --str-padding-for-genotyping
  - id: snp_padding_for_genotyping
    type:
      - 'null'
      - int
    doc: "[default: 20]"
    inputBinding:
      position: 177
      prefix: --snp-padding-for-genotyping
  - id: max_extension_into_region_padding
    type:
      - 'null'
      - int
    doc: "[default: 25]"
    inputBinding:
      position: 178
      prefix: --max-extension-into-region-padding
  - id: soft_clip_low_quality_ends
    type:
      - 'null'
      - boolean
    doc: "soft clip low quality ends"
    inputBinding:
      position: 179
      prefix: --soft-clip-low-quality-ends
  - id: trim_min
    type:
      - 'null'
      - float
    doc: "Remove this smallest fraction of positions [default: 0.00]"
    inputBinding:
      position: 180
      prefix: --trim-min
  - id: trim_max
    type:
      - 'null'
      - float
    doc: "Maximum fraction for trimmed_mean [default: 1.00]"
    inputBinding:
      position: 181
      prefix: --trim-max
  - id: mapping_quality_threshold_for_genotyping
    type:
      - 'null'
      - int
    doc: "[default: 20]"
    inputBinding:
      position: 182
      prefix: --mapping-quality-threshold-for-genotyping
  - id: min_sv_qual
    type:
      - 'null'
      - int
    doc: "Minimum structural variants quality returned by svim and used by lorikeet. Not PHRED-scaled quality, value determined by number of supporting reads. Consult svim documentation for details. [default: 3] [default: 3]"
    inputBinding:
      position: 183
      prefix: --min-sv-qual
  - id: do_not_call_svs
    type:
      - 'null'
      - boolean
    doc: "Opts not to use svim to call structural variants using provided longreads. If no longreads are provided this has no effect."
    inputBinding:
      position: 184
      prefix: --do-not-call-svs
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: "Minimum MAPQ score for reads to be considered during variant calling. [default: 20] [default: 20]"
    inputBinding:
      position: 185
      prefix: --min-mapq
  - id: min_long_read_size
    type:
      - 'null'
      - int
    doc: "The minimum size for long reads to be used for analysis [default: 1500] [default: 1500]"
    inputBinding:
      position: 186
      prefix: --min-long-read-size
  - id: min_long_read_average_base_qual
    type:
      - 'null'
      - int
    doc: "The minimum average base quality of a long read for it to be used for analysis [default: 20] [default: 20]"
    inputBinding:
      position: 187
      prefix: --min-long-read-average-base-qual
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: "Minimum base quality required to consider a base for calling. [default: 10] [default: 10]"
    inputBinding:
      position: 188
      prefix: --min-base-quality
  - id: base_quality_score_threshold
    type:
      - 'null'
      - int
    doc: "Base qualities below this threshold will be reduced to the minimum (6). [default: 18] [default: 18]"
    inputBinding:
      position: 189
      prefix: --base-quality-score-threshold
  - id: qual_by_depth_filter
    type:
      - 'null'
      - float
    doc: "The minimum QD value for a variant to have for it to be included in the genotyping or ANI analyses. [default: 25] [default: 25.0]"
    inputBinding:
      position: 190
      prefix: --qual-by-depth-filter
  - id: qual_threshold
    type:
      - 'null'
      - float
    doc: "The PHRED-scaled quality score threshold for use with ANI calculations. [default: 150] [default: 150.0]"
    inputBinding:
      position: 191
      prefix: --qual-threshold
  - id: depth_per_sample_filter
    type:
      - 'null'
      - int
    doc: "Minimum depth of a variant in a sample for that sample to be included in ANI & Fst calculations for that variant. [default: 5] [default: 5]"
    inputBinding:
      position: 192
      prefix: --depth-per-sample-filter
  - id: disable_dynamic_read_disqualification_for_genotyping
    type:
      - 'null'
      - boolean
    doc: "disable dynamic read disqualification for genotyping"
    inputBinding:
      position: 193
      prefix: --disable-dynamic-read-disqualification-for-genotyping
  - id: dynamic_read_disqualification_threshold
    type:
      - 'null'
      - float
    doc: "[default: 1.0]"
    inputBinding:
      position: 194
      prefix: --dynamic-read-disqualification-threshold
  - id: expected_mismatch_rate_for_read_disqualification
    type:
      - 'null'
      - float
    doc: "[default: 0.02]"
    inputBinding:
      position: 195
      prefix: --expected-mismatch-rate-for-read-disqualification
  - id: allele_informative_reads_overlap_margin
    type:
      - 'null'
      - int
    doc: "[default: 2]"
    inputBinding:
      position: 196
      prefix: --allele-informative-reads-overlap-margin
  - id: disable_symmetric_hmm_normalizing
    type:
      - 'null'
      - boolean
    doc: "disable symmetric hmm normalizing"
    inputBinding:
      position: 197
      prefix: --disable-symmetric-hmm-normalizing
  - id: disable_cap_base_qualities_to_map_quality
    type:
      - 'null'
      - boolean
    doc: "disable cap base qualities to map quality"
    inputBinding:
      position: 198
      prefix: --disable-cap-base-qualities-to-map-quality
  - id: disable_spanning_event_genotyping
    type:
      - 'null'
      - boolean
    doc: "disable spanning event genotyping"
    inputBinding:
      position: 199
      prefix: --disable-spanning-event-genotyping
  - id: disable_optimizations
    type:
      - 'null'
      - boolean
    doc: "Don't skip calculations in ActiveRegions with no variants"
    inputBinding:
      position: 200
      prefix: --disable-optimizations
  - id: disable_avx
    type:
      - 'null'
      - boolean
    doc: "Disable the use of the GKL-rs AVX acceleration components for PairHMM and Smith-Waterman calculations."
    inputBinding:
      position: 201
      prefix: --disable-avx
  - id: no_zeros
    type:
      - 'null'
      - boolean
    doc: "no zeros"
    inputBinding:
      position: 202
      prefix: --no-zeros
  - id: allow_improper_pairs
    type:
      - 'null'
      - boolean
    doc: "allow improper pairs"
    inputBinding:
      position: 203
      prefix: --allow-improper-pairs
  - id: include_secondary
    type:
      - 'null'
      - boolean
    doc: "Include secondary alignments. [default: not set]"
    inputBinding:
      position: 204
      prefix: --include-secondary
  - id: exclude_supplementary
    type:
      - 'null'
      - boolean
    doc: "Exclude supplementary alignments. [default: not set]"
    inputBinding:
      position: 205
      prefix: --exclude-supplementary
  - id: ploidy
    type:
      - 'null'
      - int
    doc: "Sets the default ploidy for the analysis to N. [default: 1] [default: 2]"
    inputBinding:
      position: 206
      prefix: --ploidy
  - id: calculate_dnds
    type:
      - 'null'
      - boolean
    doc: "Calculate coding regions and perform dN/dS calculations along them using called variants. *Microbial only*."
    inputBinding:
      position: 207
      prefix: --calculate-dnds
  - id: calculate_fst
    type:
      - 'null'
      - boolean
    doc: "Calculate Fst values between samples and variants."
    inputBinding:
      position: 208
      prefix: --calculate-fst
  - id: prodigal_params
    type:
      - 'null'
      - string
    doc: "[default: -p meta]"
    inputBinding:
      position: 209
      prefix: --prodigal-params
  - id: limiting_interval
    type:
      - 'null'
      - string
    doc: "Mainly used for debugging purposes. Only call variants within this given span on all contigs. E.g. providing '1000-2000' would only call variants between the 1000 and 2000 bp span on each provided contig."
    inputBinding:
      position: 210
      prefix: --limiting-interval
  - id: profile
    type:
      - 'null'
      - string
    doc: "profile"
    inputBinding:
      position: 211
      prefix: --profile
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Forcefully overwrite previous runs."
    inputBinding:
      position: 212
      prefix: --force
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print extra debugging information. [default: not set]"
    inputBinding:
      position: 213
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Unless there is an error, do not print log messages. [default: not set]"
    inputBinding:
      position: 214
      prefix: --quiet
  - id: bam_file_cache_directory
    type:
      - 'null'
      - string
    doc: Output BAM files generated during alignment to this directory. The directory may or may not exist.
    inputBinding:
      position: 215
      prefix: --bam-file-cache-directory
  - id: output_directory
    type: string
    default: lorikeet_out
    doc: Output directory. Folder will contain subfolders for each input genome.
    inputBinding:
      position: 216
      prefix: --output-directory
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the results
    outputBinding:
      glob: $(inputs.output_directory)
  - id: bam_cache_dir
    type:
      - 'null'
      - Directory
    doc: Directory with cached BAM files
    outputBinding:
      glob: $(inputs.bam_file_cache_directory)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorikeet-genome:0.8.2--h8e1a5b0_0
