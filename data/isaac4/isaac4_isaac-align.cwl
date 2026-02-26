cwlVersion: v1.2
class: CommandLineTool
baseCommand: isaac-align
label: isaac4_isaac-align
doc: "Aligns sequencing reads to a reference genome.\n\nTool homepage: https://github.com/Illumina/Isaac4"
inputs:
  - id: allow_empty_flowcells
    type:
      - 'null'
      - int
    doc: Avoid failure when some of the --base-calls contain no data
    default: 0
    inputBinding:
      position: 101
      prefix: --allow-empty-flowcells
  - id: anchor_mate
    type:
      - 'null'
      - int
    doc: Allow entire pair to be anchored by only one read if it has not been 
      realigned. If not set, each read is anchored individually and does not 
      affect anchoring of its mate.
    default: 1
    inputBinding:
      position: 101
      prefix: --anchor-mate
  - id: anomalous_pair_handicap
    type:
      - 'null'
      - int
    doc: When deciding between an anomalous pair and a rescued pair, this is 
      proportional to the number of mismatches anomalous pair needs to have less
      in order to be accepted instead of a rescued pair.
    default: 240
    inputBinding:
      position: 101
      prefix: --anomalous-pair-handicap
  - id: bam_exclude_tags
    type:
      - 'null'
      - string
    doc: 'Comma-separated list of regular tags to exclude from the output BAM files.
      Allowed values are: all,none,AS,BC,NM,OC,RG,SM,ZX,ZY'
    default: ZX,ZY
    inputBinding:
      position: 101
      prefix: --bam-exclude-tags
  - id: bam_gzip_level
    type:
      - 'null'
      - int
    doc: Gzip level to use for BAM
    default: 1
    inputBinding:
      position: 101
      prefix: --bam-gzip-level
  - id: bam_header_tag
    type:
      - 'null'
      - string
    doc: Additional bam entries that are copied into the header of each produced
      bam file. Use '\t' to represent tab separators.
    inputBinding:
      position: 101
      prefix: --bam-header-tag
  - id: bam_pessimistic_mapq
    type:
      - 'null'
      - int
    doc: When set, the MAPQ is computed as MAPQ:=min(60, min(SM, AS)), otherwise
      MAPQ:=min(60, max(SM, AS))
    default: 0
    inputBinding:
      position: 101
      prefix: --bam-pessimistic-mapq
  - id: bam_produce_md5
    type:
      - 'null'
      - int
    doc: Controls whether a separate file containing md5 checksum is produced 
      for each output bam.
    default: 1
    inputBinding:
      position: 101
      prefix: --bam-produce-md5
  - id: bam_pu_format
    type:
      - 'null'
      - string
    doc: 'Template string for bam header RG tag PU field. Ordinary characters are
      directly copied. The following placeholders are supported: - %F : Flowcell ID
      - %L : Lane number - %B : Barcode'
    default: '%F:%L:%B'
    inputBinding:
      position: 101
      prefix: --bam-pu-format
  - id: barcode_mismatches
    type:
      - 'null'
      - string
    doc: 'Multiple entries allowed. Each entry is applied to the corresponding base-calls.
      Last entry applies to all the bases-calls-directory that do not have barcode-mismatches
      specified. Last component mismatch value applies to all subsequent barcode components
      should there be more than one. Examples: - 1:0 : allow one mismatch for the
      first barcode component and no mismatches for the subsequent components. - 1
      : allow one mismatch for every barcode component. - 0 : no mismatches allowed
      in any barcode component. This is the default.'
    default: '1'
    inputBinding:
      position: 101
      prefix: --barcode-mismatches
  - id: base_calls
    type:
      type: array
      items: Directory
    doc: Full path to the base calls. Multiple entries allowed. Path should 
      point either to a directory or a file depending on --base-calls-format
    inputBinding:
      position: 101
      prefix: --base-calls
  - id: base_calls_format
    type:
      - 'null'
      - type: array
        items: string
    doc: "Multiple entries allowed. Each entry is applied to the corresponding base-calls.
      Last entry is applied to all --base-calls that don't have --base-calls-format
      specified. - bam : --base-calls points to a Bam file. All data found in bam
      file is assumed to come from lane 1 of a single flowcell. - bcl : --base-calls
      points to RunInfo.xml file. Data is made of uncompressed bcl files. - bcl-gz
      : --base-calls points to RunInfo.xml file. Bcl cycle tile files are individually
      compressed and named s_X_YYYY.bcl.gz - bcl-bgzf : --base-calls points to RunInfo.xml
      file. Bcl data is stored in cycle files that are named CCCC.bcl.bgzf - fastq
      : --base-calls points to a directory containing one fastq per lane/read named
      lane<X>_read<Y>.fastq. Use lane<X>_read1.fastq for single-ended data. - fastq-gz
      : --base-calls points to a directory containing one compressed fastq per lane/read
      named lane<X>_read<Y>.fastq.gz. Use lane<X>_read1.fastq.gz for single-ended
      data."
    inputBinding:
      position: 101
      prefix: --base-calls-format
  - id: base_quality_cutoff
    type:
      - 'null'
      - int
    doc: 3' end quality trimming cutoff. Value above 0 causes low quality bases 
      to be soft-clipped. 0 turns the trimming off.
    default: 15
    inputBinding:
      position: 101
      prefix: --base-quality-cutoff
  - id: bcl_tiles_per_chunk
    type:
      - 'null'
      - int
    doc: Increase this number when the tiles are too small for the processing to
      be efficient. In particular, collecting the template length statistics 
      requires several tens of thousands clusters to work. If tiles are small 
      and data is heavily multiplexed, there might be not enough clusters in a 
      single tile to collect the tls for a sample
    default: 1
    inputBinding:
      position: 101
      prefix: --bcl-tiles-per-chunk
  - id: bin_regex
    type:
      - 'null'
      - string
    doc: 'Define which bins appear in the output bam files all : Include all bins
      in the bam and all contig entries in the bam header. skip-empty : Include only
      the contigs that have aligned data. REGEX : Is treated as comma-separated list
      of regular expressions. Bam files will be filtered to contain only the bins
      that match by the name.'
    default: all
    inputBinding:
      position: 101
      prefix: --bin-regex
  - id: candidate_matches_max
    type:
      - 'null'
      - int
    doc: Maximum number of candidate matches to be considered for finding the 
      best alignment. If seeds yield a greater number, the alignment generally 
      is not performed. Other mechanisms such as shadow rescue may still place 
      the fragment.
    default: 800
    inputBinding:
      position: 101
      prefix: --candidate-matches-max
  - id: cleanup_intermediary
    type:
      - 'null'
      - int
    doc: When set, Isaac will erase intermediate input files for the stages that
      have been completed. Notice that this will prevent resumption from the 
      stages that have their input files removed. --start-from Last will still 
      work.
    default: 0
    inputBinding:
      position: 101
      prefix: --cleanup-intermediary
  - id: clip_overlapping
    type:
      - 'null'
      - int
    doc: When set, the pairs that have read ends overlapping each other will 
      have the lower-quality end soft-clipped.
    default: 1
    inputBinding:
      position: 101
      prefix: --clip-overlapping
  - id: clip_semialigned
    type:
      - 'null'
      - int
    doc: When set, reads have their bases soft-clipped on either sides until a 
      stretch of 5 matches is found
    default: 0
    inputBinding:
      position: 101
      prefix: --clip-semialigned
  - id: cluster
    type:
      - 'null'
      - type: array
        items: string
    doc: Restrict the alignment to the specified cluster Id (multiple entries 
      allowed)
    inputBinding:
      position: 101
      prefix: --cluster
  - id: clusters_at_a_time
    type:
      - 'null'
      - int
    doc: Bam and fastq only. When not set, number of clusters to process 
      together when input is bam or fastq is computed automatically based on the
      amount of available RAM. Set to non-zero value to force deterministic 
      behavior.
    default: 8000000
    inputBinding:
      position: 101
      prefix: --clusters-at-a-time
  - id: decoy_regex
    type:
      - 'null'
      - string
    doc: 'Contigs that have matching names are marked as decoys and enjoy reduced
      effort. In particular: - Smith waterman is not used for alignments - Suspicious
      alignments are marked dodgyFor example, to mark everything that does not begin
      with chr as decoy use the following regex: ^(?!chr.*)'
    default: decoy
    inputBinding:
      position: 101
      prefix: --decoy-regex
  - id: default_adapters
    type:
      - 'null'
      - type: array
        items: string
    doc: "Multiple entries allowed. Each entry is associated with the corresponding
      base-calls. Flowcells that don't have default-adapters provided, don't get adapters
      clipped in the data. Each entry is a comma-separated list of adapter sequences
      written in the direction of the reference. Wildcard (* character) is allowed
      only on one side of the sequence. Entries with * apply only to the alignments
      on the matching strand. Entries without * apply to all strand alignments and
      are matched in the order of appearance in the list. Examples: ACGT*,*TGCA :
      Will clip ACGT and all subsequent bases in the forward-strand alignments and
      mirror the behavior for the reverse-strand alignments. ACGT,TGCA : Will find
      the following sequences in the reads: ACGT, TGCA, ACGTTGCA (but not TGCAACGT!)
      regardless of the alignment strand. Then will attempt to clip off the side of
      the read that is shorter. If both sides are roughly equal length, will clip
      off the side that has less matches. Standard : Standard protocol adapters. Same
      as AGATCGGAAGAGC*,*GCTCTTCCGATCT Nextera : Nextera standard. Same as CTGTCTCTTATACACATCT*,*AGATGTGTATAAGAGACAG
      NexteraMp : Nextera mate-pair. Same as CTGTCTCTTATACACATCT,AGATGTGTATAAGAGACAG"
    inputBinding:
      position: 101
      prefix: --default-adapters
  - id: description
    type:
      - 'null'
      - string
    doc: Free form text to be stored in the Isaac @PG DS bam header tag
    inputBinding:
      position: 101
      prefix: --description
  - id: detect_template_block_size
    type:
      - 'null'
      - int
    doc: Number of pairs to use as a single block for template length statistics
      detection
    default: 10000
    inputBinding:
      position: 101
      prefix: --detect-template-block-size
  - id: disable_resume
    type:
      - 'null'
      - int
    doc: If enabled, Isaac does not persist the state of the analysis on disk. 
      This might save noticeable amount of runtime at the expense of not being 
      able to use --start-from option.
    default: 0
    inputBinding:
      position: 101
      prefix: --disable-resume
  - id: dodgy_alignment_score
    type:
      - 'null'
      - string
    doc: 'Controls the behavior for templates where alignment score is impossible
      to assign: - Unaligned : marks template fragments as unaligned - 0-254 : exact
      MAPQ value to be set in bam - Unknown : assigns value 255 for bam MAPQ. Ensures
      SM and AS are not specified in the bam'
    inputBinding:
      position: 101
      prefix: --dodgy-alignment-score
  - id: enable_numa
    type:
      - 'null'
      - boolean
    doc: Replicate static data across NUMA nodes, lock threads to their NUMA 
      nodes, allocate thread private data on the corresponding NUMA node
    default: false
    inputBinding:
      position: 101
      prefix: --enable-numa
  - id: expected_bgzf_ratio
    type:
      - 'null'
      - float
    doc: compressed = ratio * uncompressed. To avoid memory overallocation 
      during the bam generation, Isaac has to assume certain compression ratio. 
      If Isaac estimates less memory than is actually required, it will fail at 
      runtime. You can check how far you are from the dangerous zone by looking 
      at the resident/swap memory numbers for your process during the bam 
      generation. If you see too much showing as 'swap', it is safe to reduce 
      the --expected-bgzf-ratio.
    default: 1.0
    inputBinding:
      position: 101
      prefix: --expected-bgzf-ratio
  - id: expected_coverage
    type:
      - 'null'
      - int
    doc: Expected coverage is required for Isaac to estimate the efficient 
      binning of the aligned data.
    default: 60
    inputBinding:
      position: 101
      prefix: --expected-coverage
  - id: fastq_q0
    type:
      - 'null'
      - string
    doc: Character to serve as base quality 0 in fastq input.
    default: '!'
    inputBinding:
      position: 101
      prefix: --fastq-q0
  - id: gap_scoring
    type:
      - 'null'
      - string
    doc: 'Gapped alignment algorithm parameters: - eland : equivalent of 2:-1:-15:-3:-25
      - bwa : equivalent of 0:-3:-11:-4:-20 - bwa-mem : equivalent of 1:-4:-6:-1:-20
      - m:mm:go:ge:me:gl : colon-delimited string of values where: m : match score
      mm : mismatch score go : gap open score ge : gap extend score me : min extend
      score (all gaps reaching this score will be treated as equal)'
    default: bwa
    inputBinding:
      position: 101
      prefix: --gap-scoring
  - id: hash_table_buckets
    type:
      - 'null'
      - int
    doc: 'Number of buckets to use for reference hash table. Larger number of buckets
      requires more RAM but it tends to speed up the execution and improve sensitivity.
      Value of 0 indicates default bucket count: 2^({seed-length}*2)'
    default: 0
    inputBinding:
      position: 101
      prefix: --hash-table-buckets
  - id: help_defaults
    type:
      - 'null'
      - boolean
    doc: produce tab-delimited list of command line options and their default 
      values
    inputBinding:
      position: 101
      prefix: --help-defaults
  - id: help_md
    type:
      - 'null'
      - boolean
    doc: produce help message pre-formatted as a markdown file section and exit
    inputBinding:
      position: 101
      prefix: --help-md
  - id: ignore_missing_bcls
    type:
      - 'null'
      - int
    doc: When set, missing bcl files are treated as all clusters having N bases 
      for the corresponding tile cycle. Otherwise, encountering a missing bcl 
      file causes the analysis to fail.
    default: 0
    inputBinding:
      position: 101
      prefix: --ignore-missing-bcls
  - id: ignore_missing_filters
    type:
      - 'null'
      - int
    doc: When set, missing filter files are treated as if all clusters pass 
      filter for the corresponding tile. Otherwise, encountering a missing 
      filter file causes the analysis to fail.
    default: 0
    inputBinding:
      position: 101
      prefix: --ignore-missing-filters
  - id: input_concurrent_load
    type:
      - 'null'
      - int
    doc: Maximum number of concurrent file read operations for --base-calls
    default: 64
    inputBinding:
      position: 101
      prefix: --input-concurrent-load
  - id: jobs
    type:
      - 'null'
      - int
    doc: Maximum number of compute threads to run in parallel
    default: 20
    inputBinding:
      position: 101
      prefix: --jobs
  - id: keep_duplicates
    type:
      - 'null'
      - int
    doc: Keep duplicate pairs in the bam file (with 0x400 flag set in all but 
      the best one)
    default: 1
    inputBinding:
      position: 101
      prefix: --keep-duplicates
  - id: keep_unaligned
    type:
      - 'null'
      - string
    doc: 'Available options: - discard : discard clusters where both reads are not
      aligned - front : keep unaligned clusters in the front of the BAM file - back
      : keep unaligned clusters in the back of the BAM file'
    default: back
    inputBinding:
      position: 101
      prefix: --keep-unaligned
  - id: known_indels
    type:
      - 'null'
      - File
    doc: path to a VCF file containing known indels fore realignment.
    inputBinding:
      position: 101
      prefix: --known-indels
  - id: lane_number_max
    type:
      - 'null'
      - int
    doc: Maximum lane number to look for in --base-calls-directory (fastq only).
    default: 8
    inputBinding:
      position: 101
      prefix: --lane-number-max
  - id: mapq_threshold
    type:
      - 'null'
      - int
    doc: If any fragment alignment in template is below the threshold, template 
      is not stored in the BAM.
    default: -1
    inputBinding:
      position: 101
      prefix: --mapq-threshold
  - id: mark_duplicates
    type:
      - 'null'
      - int
    doc: If not set and --keep-duplicates is set, the duplicates are not 
      discarded and not flagged.
    default: 1
    inputBinding:
      position: 101
      prefix: --mark-duplicates
  - id: match_finder_shadow_split_repeats
    type:
      - 'null'
      - int
    doc: Maximum number of seed candidate matches to be considered for finding a
      possible alignment split.
    default: 100000
    inputBinding:
      position: 101
      prefix: --match-finder-shadow-split-repeats
  - id: match_finder_too_many_repeats
    type:
      - 'null'
      - int
    doc: Maximum number of seed matches to be looked at for each attempted seed
    default: 4000
    inputBinding:
      position: 101
      prefix: --match-finder-too-many-repeats
  - id: match_finder_way_too_many_repeats
    type:
      - 'null'
      - int
    doc: Maximum number of seed matches to be looked at if in a pair one read 
      has candidate alignments and the other has gone over 
      match-finder-too-many-repeats on all seeds or over candidate-matches-max 
      when seed position merge was attempted
    default: 100000
    inputBinding:
      position: 101
      prefix: --match-finder-way-too-many-repeats
  - id: memory_control
    type:
      - 'null'
      - string
    doc: "Define the behavior in case unexpected memory allocations are detected:
      - warning : Log WARNING about the allocation. - off : Don't monitor dynamic
      memory usage. - strict : Fail memory allocation. Intended for development use."
    default: off
    inputBinding:
      position: 101
      prefix: --memory-control
  - id: memory_limit
    type:
      - 'null'
      - int
    doc: Limits major memory consumption operations to a set number of 
      gigabytes. 0 means no limit, however 0 is not allowed as in such case 
      Isaac will most likely consume all the memory on the system and cause it 
      to crash. Default value is taken from ulimit -v.
    default: 0
    inputBinding:
      position: 101
      prefix: --memory-limit
  - id: neighborhood_size_threshold
    type:
      - 'null'
      - int
    doc: Threshold used to decide if the number of reference 32-mers sharing the
      same prefix (16 bases) is small enough to justify the neighborhood search.
      Use large enough value e.g. 10000 to enable alignment to positions where 
      seeds don't match exactly.
    default: 0
    inputBinding:
      position: 101
      prefix: --neighborhood-size-threshold
  - id: output_concurrent_save
    type:
      - 'null'
      - int
    doc: Maximum number of concurrent file write operations for 
      --output-directory
    default: 120
    inputBinding:
      position: 101
      prefix: --output-concurrent-save
  - id: per_tile_tls
    type:
      - 'null'
      - int
    doc: Forces template length statistics(TLS) to be recomputed for each tile. 
      When not set, the first tile that produces stable TLS will determine TLS 
      for the rest of the tiles of the lane. Notice that as the tiles are not 
      guaranteed to be processed in the same order between different runs, some 
      pair alignments might vary between two runs on the same data unless 
      --per-tile-tls is set. It is not recommended to set --per-tile-tls when 
      input data is not randomly distributed (such as bam) as in such cases, the
      shadow rescue range will be biased by the input data ordering.
    default: 0
    inputBinding:
      position: 101
      prefix: --per-tile-tls
  - id: pf_only
    type:
      - 'null'
      - int
    doc: When set, only the fragments passing filter (PF) are generated in the 
      BAM file
    default: 1
    inputBinding:
      position: 101
      prefix: --pf-only
  - id: pre_allocate_bins
    type:
      - 'null'
      - int
    doc: Use fallocate to reduce the bin file fragmentation. Since bin files are
      pre-allocated based on the estimation of their size, it is recommended to 
      turn bin pre-allocation off when using RAM disk as temporary storage.
    default: 0
    inputBinding:
      position: 101
      prefix: --pre-allocate-bins
  - id: pre_sort_bins
    type:
      - 'null'
      - int
    doc: Unset this value if you are working with references that have many 
      contigs (1000+)
    default: 1
    inputBinding:
      position: 101
      prefix: --pre-sort-bins
  - id: read_name_length
    type:
      - 'null'
      - int
    doc: Maximum read name length (fastq and bam only). Value of 0 causes the 
      read name length to be determined by reading the first records of the 
      input data. Shorter than needed read names can cause duplicate names in 
      the output bam files.
    default: 0
    inputBinding:
      position: 101
      prefix: --read-name-length
  - id: realign_dodgy
    type:
      - 'null'
      - int
    doc: If not set, the reads without alignment score are not realigned against
      gaps found in other reads.
    default: 0
    inputBinding:
      position: 101
      prefix: --realign-dodgy
  - id: realign_gaps
    type:
      - 'null'
      - string
    doc: 'For reads overlapping the gaps occurring on other reads, check if applying
      those gaps reduces mismatch count. Significantly reduces number of false SNPs
      reported around short indels. - no : no gap realignment - sample : realign against
      gaps found in the same sample - project : realign against gaps found in all
      samples of the same project - all : realign against gaps found in all samples'
    default: sample
    inputBinding:
      position: 101
      prefix: --realign-gaps
  - id: realign_mapq_min
    type:
      - 'null'
      - int
    doc: Gaps from alignments with lower MAPQ will not be used as candidates for
      gap realignment
    default: 60
    inputBinding:
      position: 101
      prefix: --realign-mapq-min
  - id: realign_vigorously
    type:
      - 'null'
      - int
    doc: If set, the realignment result will be used to search for more gaps and
      attempt another realignment, effectively extending the realignment over 
      multiple deletions not covered by the original alignment.
    default: 0
    inputBinding:
      position: 101
      prefix: --realign-vigorously
  - id: realigned_gaps_per_fragment
    type:
      - 'null'
      - int
    doc: Maximum number of gaps the realigner can introduce into a fragment. For
      100 bases long DNA it is reasonable to keep it no bigger than 2. RNA reads
      can overlap multiple introns. Therefore a larger number is probably 
      required for RNA. Notice that bigger values can significantly slow down 
      the bam generation as there is a n choose k combination try with n being 
      the number of gaps detected by all other fragment alignments that overlap 
      the fragment being realigned.
    default: 4
    inputBinding:
      position: 101
      prefix: --realigned-gaps-per-fragment
  - id: reference_genome
    type: File
    doc: Full path to the reference genome XML descriptor.
    inputBinding:
      position: 101
      prefix: --reference-genome
  - id: reference_name
    type:
      - 'null'
      - type: array
        items: string
    doc: "Unique symbolic name of the reference. Multiple entries allowed. Each entry
      is associated with the corresponding --reference-genome and will be matched
      against the 'reference' column in the sample sheet. Special names: - unknown
      : default reference to use with data that did not match any barcode. - default
      : reference to use for the data with no matching value in sample sheet 'reference'
      column."
    default: default
    inputBinding:
      position: 101
      prefix: --reference-name
  - id: remap_qscores
    type:
      - 'null'
      - string
    doc: 'Replace the base calls qscores according to the rules provided. - identity
      : No remapping. Original qscores are preserved - bin:8 : Equivalent of 0-1:0,2-9:7,10-19:11,20-24:22
      ,25-29:27,30-34:32,35-39:37,40-63:40'
    inputBinding:
      position: 101
      prefix: --remap-qscores
  - id: repeat_threshold
    type:
      - 'null'
      - int
    doc: Threshold used to decide if matches must be discarded as too abundant 
      (when the number of repeats is greater or equal to the threshold)
    default: 100
    inputBinding:
      position: 101
      prefix: --repeat-threshold
  - id: rescue_shadows
    type:
      - 'null'
      - int
    doc: Scan within dominant template range off an orphan, for a possible 
      shadow alignment
    default: 1
    inputBinding:
      position: 101
      prefix: --rescue-shadows
  - id: response_file
    type:
      - 'null'
      - File
    doc: file with more command line arguments
    inputBinding:
      position: 101
      prefix: --response-file
  - id: sample_sheet
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Multiple entries allowed. Each entry is applied to the corresponding base-calls.
      - none : process flowcell as if there is no sample sheet - default : use <base-calls>/SampleSheet.csv
      if it exists. This is the default behavior. - <file path> : use <file path>
      as sample sheet for the flowcell.'
    inputBinding:
      position: 101
      prefix: --sample-sheet
  - id: scatter_repeats
    type:
      - 'null'
      - int
    doc: When set, extra care will be taken to scatter pairs aligning to repeats
      across the repeat locations
    default: 1
    inputBinding:
      position: 101
      prefix: --scatter-repeats
  - id: seed_base_quality_min
    type:
      - 'null'
      - int
    doc: Minimum base quality for the seed to be used in alignment candidate 
      search.
    default: 3
    inputBinding:
      position: 101
      prefix: --seed-base-quality-min
  - id: seed_length
    type:
      - 'null'
      - int
    doc: Length of the seed in bases. Only 10 11 12 13 14 15 16 17 18 19 20 are 
      allowed. Longer seeds reduce sensitivity on noisy data but improve repeat 
      resolution and run time.
    default: 16
    inputBinding:
      position: 101
      prefix: --seed-length
  - id: shadow_scan_range
    type:
      - 'null'
      - int
    doc: -1 - scan for possible mate alignments between template min and max >=0
      - scan for possible mate alignments in range of template median += 
      shadow-scan-range
    default: -1
    inputBinding:
      position: 101
      prefix: --shadow-scan-range
  - id: single_library_samples
    type:
      - 'null'
      - int
    doc: If set, the duplicate detection will occur across all read pairs in the
      sample. If not set, different lanes are assumed to originate from 
      different libraries and duplicate detection is not performed across lanes.
    default: 1
    inputBinding:
      position: 101
      prefix: --single-library-samples
  - id: smith_waterman_gap_size_max
    type:
      - 'null'
      - int
    doc: Maximum length of gap detectable by smith waterman algorithm.
    default: 16
    inputBinding:
      position: 101
      prefix: --smith-waterman-gap-size-max
  - id: smith_waterman_gaps_max
    type:
      - 'null'
      - int
    doc: Maximum number of gaps that can be introduced into an alignment by 
      Smith-Waterman algorithm. If the optimum alignment has more gaps, it is 
      simply ignored as an alignment candidate.
    default: 4
    inputBinding:
      position: 101
      prefix: --smith-waterman-gaps-max
  - id: split_alignments
    type:
      - 'null'
      - int
    doc: When set, alignments crossing a structural variant are allowed to be 
      split with SA tag.
    default: 1
    inputBinding:
      position: 101
      prefix: --split-alignments
  - id: split_gap_length
    type:
      - 'null'
      - int
    doc: Maximum length of insertion or deletion allowed to exist in a read. If 
      a gap exceeds this limit, the read gets broken up around the gap with SA 
      tag introduced
    default: 10000
    inputBinding:
      position: 101
      prefix: --split-gap-length
  - id: start_from
    type:
      - 'null'
      - string
    doc: "Start processing at the specified stage: - Start : don't resume, start from
      beginning - Align : same as Start - AlignmentReports : regenerate alignment
      reports and bam - Bam : resume at bam generation - Finish : Same as Bam. - Last
      : resume from the last successful step Note that although Isaac attempts to
      perform some basic validation, the only safe option is 'Start' The primary purpose
      of the feature is to reduce the time required to diagnose the issues rather
      than be used on a regular basis."
    default: Start
    inputBinding:
      position: 101
      prefix: --start-from
  - id: stats_image_format
    type:
      - 'null'
      - string
    doc: 'Format to use for images during stats generation - gif : produce .gif type
      plots - none : no stat generation'
    default: none
    inputBinding:
      position: 101
      prefix: --stats-image-format
  - id: stop_at
    type:
      - 'null'
      - string
    doc: "Stop processing after the specified stage is complete: - Start : perform
      the first stage only - Align : same as Start - AlignmentReports : don't perform
      bam generation - Bam : finish when bam is done - Finish : stop at the end. -
      Last : perform up to the last successful step only Note that although Isaac
      attempts to perform some basic validation, the only safe option is 'Finish'
      The primary purpose of the feature is to reduce the time required to diagnose
      the issues rather than be used on a regular basis."
    default: Finish
    inputBinding:
      position: 101
      prefix: --stop-at
  - id: target_bin_size
    type:
      - 'null'
      - int
    doc: Isaac will attempt to bin temporary data so that each bin is close to 
      targetBinSize in megabytes (1024 * 1024 bytes). Value of 0 will cause 
      Isaac to compute the target bin size automatically based on the available 
      memory.
    default: 0
    inputBinding:
      position: 101
      prefix: --target-bin-size
  - id: temp_concurrent_load
    type:
      - 'null'
      - int
    doc: Maximum number of concurrent file read operations for --temp-directory
    default: 4
    inputBinding:
      position: 101
      prefix: --temp-concurrent-load
  - id: temp_concurrent_save
    type:
      - 'null'
      - int
    doc: Maximum number of concurrent file write operations for --temp-directory
    default: 680
    inputBinding:
      position: 101
      prefix: --temp-concurrent-save
  - id: temp_directory
    type:
      - 'null'
      - Directory
    doc: Directory where the temporary files will be stored (matches, unsorted 
      alignments, etc.)
    default: ./Temp
    inputBinding:
      position: 101
      prefix: --temp-directory
  - id: tiles
    type:
      - 'null'
      - type: array
        items: string
    doc: "Comma-separated list of regular expressions to select only a subset of the
      tiles available in the flow-cell. - to select all the tiles ending with '5'
      in all lanes: --tiles [0-9][0-9][0-9]5 - to select tile 2 in lane 1 and all
      the tiles in the other lanes: --tiles s_1_0002,s_[2-8] Multiple entries allowed,
      each applies to the corresponding base-calls."
    inputBinding:
      position: 101
      prefix: --tiles
  - id: tls
    type:
      - 'null'
      - string
    doc: Template-length statistics in the format 
      'min:median:max:lowStdDev:highStdDev:M0:M1', where M0 and M1 are the 
      numeric value of the models (0=FFp, 1=FRp, 2=RFp, 3=RRp, 4=FFm, 5=FRm, 
      6=RFm, 7=RRm)
    inputBinding:
      position: 101
      prefix: --tls
  - id: trim_pe
    type:
      - 'null'
      - int
    doc: Trim overhanging ends of PE alignments
    default: 1
    inputBinding:
      position: 101
      prefix: --trim-pe
  - id: use_bases_mask
    type:
      - 'null'
      - string
    doc: 'Conversion mask characters: - Y or y : use - N or n : discard - I or i :
      use for indexing If not given, the mask will be guessed from the config.xml
      file in the base-calls directory. For instance, in a 2x76 indexed paired end
      run, the mask I<Y76,I6n,y75n> means: use all 76 bases from the first end, discard
      the last base of the indexing read, and use only the first 75 bases of the second
      end.'
    inputBinding:
      position: 101
      prefix: --use-bases-mask
  - id: use_smith_waterman
    type:
      - 'null'
      - string
    doc: "One of the following: - always : Use smith-waterman to reduce the amount
      of mismatches in aligned reads - smart : apply heuristics to avoid executing
      costly smith-waterman on sequences that are unlikely to produce gaps - never
      : Don't use smith-waterman"
    default: smart
    inputBinding:
      position: 101
      prefix: --use-smith-waterman
  - id: variable_read_length
    type:
      - 'null'
      - boolean
    doc: Unless set, Isaac will fail if the length of the sequence changes 
      between the records of a fastq or a bam file.
    inputBinding:
      position: 101
      prefix: --variable-read-length
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity: FATAL(0), ERRORS(1), WARNINGS(2), INFO(3), DEBUG(4) (not supported
      yet)'
    default: 2
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory where the final alignment data be stored
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isaac4:04.18.11.09--h07bff40_0
