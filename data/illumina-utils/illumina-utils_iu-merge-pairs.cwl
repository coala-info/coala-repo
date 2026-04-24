cwlVersion: v1.2
class: CommandLineTool
baseCommand: iu-merge-pairs
label: illumina-utils_iu-merge-pairs
doc: "Merge Overlapping Paired-End Illumina Reads\n\nTool homepage: https://github.com/meren/illumina-utils"
inputs:
  - id: config_file
    type: string
    doc: User configuration to run
    inputBinding:
      position: 1
  - id: compute_qual_dicts
    type:
      - 'null'
      - boolean
    doc: When set, qual dicts will be computed. May take a very long time for 
      datasets with more than a million pairs.
    inputBinding:
      position: 102
      prefix: --compute-qual-dicts
  - id: debug
    type:
      - 'null'
      - boolean
    doc: When set, debug messages will be printed
    inputBinding:
      position: 102
      prefix: --debug
  - id: distance_metric
    type:
      - 'null'
      - string
    doc: Distance metric to use for comparison. Can be 'hamming' or 
      'levenshtein'.
    inputBinding:
      position: 102
      prefix: --distance-metric
  - id: enforce_q30_check
    type:
      - 'null'
      - boolean
    doc: By default, quality filtering is being done based only on the 
      mismatches found in the overlapped region, and the beginning and the end 
      of merged reads are not being checked. However a final control can be 
      enforced using this flag. This flag turns on the Q30 check, as it was 
      explained by Minoche et al. in their 2012 paper. Briefly, Q30-check 
      eliminates pairs if the 66% of bases in the first half of each read do not
      have Q-scores over Q30. Note that Q30 is applied only to the parts of 
      reads that did not overlap. If either of reads fail Q30 check, merged 
      sequence is discarded.
    inputBinding:
      position: 102
      prefix: --enforce-Q30-check
  - id: exclude_low_diversity_seqs
    type:
      - 'null'
      - float
    doc: Removes low-diversity sequences where most of their bases are the same.
      It takes a value between 0.5 and 1.0, where a value of 1.0 will remove a 
      merged sequence if the most frequent base in it makes 100% of the 
      sequence.
    inputBinding:
      position: 102
      prefix: --exclude-low-diversity-seqs
  - id: ignore_deflines
    type:
      - 'null'
      - boolean
    doc: If FASTQ files are not CASAVA outputs, parsing the header info may go 
      wrong. This flag tells the software to skip parsing deflines.
    inputBinding:
      position: 102
      prefix: --ignore-deflines
  - id: ignore_ns
    type:
      - 'null'
      - boolean
    doc: Merged sequences are being eliminated if they have any ambiguous bases.
      If this parameter is set merged pairs with Ns stay in the merged pairs 
      bin.
    inputBinding:
      position: 102
      prefix: --ignore-Ns
  - id: marker_gene_stringent
    type:
      - 'null'
      - boolean
    doc: Finds the best merge going beyond expected "partial overlap" case for 
      amplicons. Please read the description at url 
      https://github.com/meren/illumina-utils/issues/1 for details.
    inputBinding:
      position: 102
      prefix: --marker-gene-stringent
  - id: max_num_mismatches
    type:
      - 'null'
      - int
    doc: Maximum number of mismatches at the overlapped region to retain the 
      pair. The default behavior relies on `-P` parameter and does not pay 
      attention to the number of mismatches at the overlapped region. As of now,
      this parameter must be set to 0 for forward and reverse reads of unequal 
      length.
    inputBinding:
      position: 102
      prefix: --max-num-mismatches
  - id: min_overlap_size
    type:
      - 'null'
      - int
    doc: Overlap size must exceed this value.
    inputBinding:
      position: 102
      prefix: --min-overlap-size
  - id: min_qual_score
    type:
      - 'null'
      - int
    doc: Minimum Q-score for a base to overwrite a mismatch at the overlapped 
      region. If there is a mismatch at the overlapped region, the base with 
      higher quality is being used in the final sequence. Alternatively, if the 
      Q-score of the base with higher quality is lower than the Q-score declared
      with this parameter, that base is being marked as an ambiguous base, which
      may result in the elimination of the merged sequence depending on the 
      --ignore-Ns paranmeter.
    inputBinding:
      position: 102
      prefix: --min-qual-score
  - id: num_threads
    type:
      - 'null'
      - int
    doc: This triggers a faster algorithm for merging reads with no mismatches 
      in the overlapping region. This can only be used in combination with 
      `--max-num-mismatches 0`. Specify the number of CPU cores that you wish to
      use.
    inputBinding:
      position: 102
      prefix: --num-threads
  - id: output_file_prefix
    type:
      - 'null'
      - string
    doc: Output file prefix (which will be used as a prefix for files that 
      appear in output directory)
    inputBinding:
      position: 102
      prefix: --output_file_prefix
  - id: p_value_threshold
    type:
      - 'null'
      - float
    doc: Any merged sequence with P above the declared value is discarded and 
      stored in a separate file. P is computed by dividing the number of 
      mismatches at the overlapped region by the length of the overlapped 
      region. For instance, if the length of the overlapped region is 30 nt 
      long, and there are 3 mismatches in the overlapped region, P would be 3 / 
      30 = 0.1. The default value for P is 0.300000, however it must be adjusted
      based on the expected overlap in a given study with respect to desired 
      stringency. Stringency can also be adjusted using `--max-num-mismatches` 
      parameter, or can be done post-merging, using the program 
      `filter-merged-reads`.
    inputBinding:
      position: 102
      prefix: --p-value-threshold
  - id: report_r1_prefix
    type:
      - 'null'
      - boolean
    doc: If there is a prefix to read 1 specified in the config file, these 
      sequences will be reported for merged reads when this flag is set. This 
      can be useful if the prefix sequence has variable bases, such as in a 
      unique molecular identifier (UMI).
    inputBinding:
      position: 102
      prefix: --report-r1-prefix
  - id: report_r2_prefix
    type:
      - 'null'
      - boolean
    doc: If there is a prefix to read 2 specified in the config file, these 
      sequences will be reported for merged reads when this flag is set. This 
      can be useful if the prefix sequence has variable bases, such as in a 
      unique molecular identifier (UMI).
    inputBinding:
      position: 102
      prefix: --report-r2-prefix
  - id: retain_only_overlap
    type:
      - 'null'
      - boolean
    doc: When set, merger will only return the parts of reads that do overlap, 
      and parts of reads that do not overlap will be trimmed.
    inputBinding:
      position: 102
      prefix: --retain-only-overlap
  - id: skip_suffix_trimming
    type:
      - 'null'
      - boolean
    doc: Some datasets contain both partially and completely overlapping reads. 
      `--marker-gene-stringent` would be used in that case. Completely 
      overlapping reads can contain unwanted adapter sequence at the ends of the
      reads (read 1 adapter at the end of read 2 and read 2 adapter at the end 
      of read 1). By default, these adapter suffixes are trimmed from merged 
      reads, and non-overlapping parts of the insert are left untouched in 
      partially overlapping reads (`--retain-only-overlap` trims partially 
      overlapping merges). Setting this flag leaves adapter suffixes untrimmed.
    inputBinding:
      position: 102
      prefix: --skip-suffix-trimming
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-utils:2.13--pyhdfd78af_0
stdout: illumina-utils_iu-merge-pairs.out
