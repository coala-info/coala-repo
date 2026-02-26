cwlVersion: v1.2
class: CommandLineTool
baseCommand: grenedalf sync
label: grenedalf_sync
doc: "Create a sync file that lists per-sample base counts at each position in the
  genome.\n\nTool homepage: https://github.com/lczech/grenedalf"
inputs:
  - id: allow_file_overwriting
    type:
      - 'null'
      - boolean
    doc: Allow to overwrite existing output files instead of aborting the 
      command. By default, we abort if any output file already exists, to avoid 
      overwriting by mistake.
    inputBinding:
      position: 101
      prefix: --allow-file-overwriting
  - id: compress
    type:
      - 'null'
      - boolean
    doc: If set, compress the output files using gzip. Output file extensions 
      are automatically extended by `.gz`.
    inputBinding:
      position: 101
      prefix: --compress
  - id: file_prefix
    type:
      - 'null'
      - string
    doc: File prefix for output files. Most grenedalf commands use the command 
      name as the base name for file output. This option amends the base name, 
      to distinguish runs with different data.
    inputBinding:
      position: 101
      prefix: --file-prefix
  - id: file_suffix
    type:
      - 'null'
      - string
    doc: File suffix for output files. Most grenedalf commands use the command 
      name as the base name for file output. This option amends the base name, 
      to distinguish runs with different data.
    inputBinding:
      position: 101
      prefix: --file-suffix
  - id: filter_mask_samples_bed_invert
    type:
      - 'null'
      - boolean
    doc: When using `--filter-mask-samples-bed-list`, set this flag to invert 
      the specified mask. Needs one of `--reference-genome-fasta`, 
      `--reference-genome-dict`, `--reference-genome-fai` to determine 
      chromosome lengths.
    inputBinding:
      position: 101
      prefix: --filter-mask-samples-bed-invert
  - id: filter_mask_samples_bed_list
    type:
      - 'null'
      - File
    doc: "For each sample, genomic positions to mask (mark as missing), as a set of
      BED files.\nSee the below `--filter-mask-total-bed` for details. Here, individual
      BED files can be provided for each sample, for fine-grained control over the
      masking. The option takes a path to a file that contains a comma- or tab-separated
      list of sample names and BED file paths, with one name/path pair per line, in
      any order of lines."
    inputBinding:
      position: 101
      prefix: --filter-mask-samples-bed-list
  - id: filter_mask_samples_fasta_invert
    type:
      - 'null'
      - boolean
    doc: When using `--filter-mask-samples-fasta-list`, invert the mask. When 
      this flag is set, the mask specified above is inverted.
    inputBinding:
      position: 101
      prefix: --filter-mask-samples-fasta-invert
  - id: filter_mask_samples_fasta_list
    type:
      - 'null'
      - File
    doc: "For each sample, genomic positions to mask, as a FASTA-like mask file.\n\
      See the below `--filter-mask-total-fasta` for details. Here, individual FASTA
      files can be provided for each sample, for fine-grained control over the masking.
      The option takes a path to a file that contains a comma- or tab-separated list
      of sample names and FASTA file paths, with one name/path pair per line, in any
      order of lines."
    inputBinding:
      position: 101
      prefix: --filter-mask-samples-fasta-list
  - id: filter_mask_samples_fasta_min
    type:
      - 'null'
      - int
    doc: When using `--filter-mask-samples-fasta-list`, set the cutoff threshold
      for the masked digits. All positions above that value are masked. The 
      default is 0, meaning that only exactly the positons with value 0 will not
      be masked.
    default: 0
    inputBinding:
      position: 101
      prefix: --filter-mask-samples-fasta-min
  - id: filter_mask_total_bed
    type:
      - 'null'
      - File
    doc: "Genomic positions to mask (mark as missing), as a BED file.\nThe regions
      listed in the BED file are masked; this is in line with, e.g., smcpp, but is
      the inverse of the above usage of a BED file for selection regions, where instead
      the listed regions are kept. Note that this also conceptually differs from the
      region BED above. We here do not remove the masked positions, but instead just
      mark them as masked, so that they can still contribute to, e.g., denominators
      in the statistics for certain settings.\nThis only uses the chromosome, as well
      as start and end information per line, and ignores everything else in the file.
      Note that BED uses 0-based positions, and a half-open `[)` interval for the
      end position; simply using columns extracted from other file formats (such as
      vcf or gff) will not work."
    inputBinding:
      position: 101
      prefix: --filter-mask-total-bed
  - id: filter_mask_total_bed_invert
    type:
      - 'null'
      - boolean
    doc: When using `--filter-mask-total-bed`, set this flag to invert the 
      specified mask. Needs one of `--reference-genome-fasta`, 
      `--reference-genome-dict`, `--reference-genome-fai` to determine 
      chromosome lengths.
    inputBinding:
      position: 101
      prefix: --filter-mask-total-bed-invert
  - id: filter_mask_total_fasta
    type:
      - 'null'
      - File
    doc: "Genomic positions to mask, as a FASTA-like mask file (such as used by vcftools).\n\
      The file contains a sequence of integer digits `[0-9]`, one for each position
      on the chromosomes, which specify if the position should be masked or not. Any
      positions with digits above the `--filter-mask-total-fasta-min` value are tagged
      as being masked. Note that this conceptually differs from the region fasta above.
      We here do not remove the the masked positions, but instead just mark them as
      masked, so that they can still contribute to, e.g., denominators in the statistics
      for certain settings."
    inputBinding:
      position: 101
      prefix: --filter-mask-total-fasta
  - id: filter_mask_total_fasta_invert
    type:
      - 'null'
      - boolean
    doc: When using `--filter-mask-total-fasta`, invert the mask. This option 
      has the same effect as the equivalent in vcftools, but instead of 
      specifying the file, this here is a flag. When it is set, the mask 
      specified above is inverted.
    inputBinding:
      position: 101
      prefix: --filter-mask-total-fasta-invert
  - id: filter_mask_total_fasta_min
    type:
      - 'null'
      - int
    doc: When using `--filter-mask-total-fasta`, set the cutoff threshold for 
      the masked digits. All positions above that value are masked. The default 
      is 0, meaning that only exactly the positons with value 0 will not be 
      masked.
    default: 0
    inputBinding:
      position: 101
      prefix: --filter-mask-total-fasta-min
  - id: filter_region
    type:
      - 'null'
      - type: array
        items: string
    doc: Genomic region to filter for, in the format "chr" (for whole 
      chromosomes), "chr:position", "chr:start-end", or "chr:start..end". 
      Positions are 1-based and inclusive (closed intervals). The filter keeps 
      all listed positions, and removes all that are not listed. Multiple region
      options can be provided, see also `--filter-region-set`.
    inputBinding:
      position: 101
      prefix: --filter-region
  - id: filter_region_bed
    type:
      - 'null'
      - type: array
        items: File
    doc: Genomic regions to filter for, as a BED file. This only uses the 
      chromosome, as well as start and end information per line, and ignores 
      everything else in the file. Note that BED uses 0-based positions, and a 
      half-open `[)` interval for the end position; simply using columns 
      extracted from other file formats (such as vcf or gff) will not work. The 
      filter keeps all listed positions, and removes all that are not listed.
    inputBinding:
      position: 101
      prefix: --filter-region-bed
  - id: filter_region_fasta
    type:
      - 'null'
      - type: array
        items: File
    doc: Genomic positions to filter for, as a FASTA-like mask file (such as 
      used by vcftools). The file contains a sequence of integer digits `[0-9]`,
      one for each position on the chromosomes, which specify if the position 
      should be filtered out or not. Any positions with digits above the 
      `--filter-region-fasta-min` value are removed. Note that this conceptually
      differs from a mask file, and merely uses the same format.
    inputBinding:
      position: 101
      prefix: --filter-region-fasta
  - id: filter_region_fasta_invert
    type:
      - 'null'
      - boolean
    doc: When using `--filter-region-mask-fasta`, invert the mask. This option 
      has the same effect as the equivalent in vcftools, but instead of 
      specifying the file, this here is a flag. When it is set, the mask 
      specified above is inverted.
    inputBinding:
      position: 101
      prefix: --filter-region-fasta-invert
  - id: filter_region_fasta_min
    type:
      - 'null'
      - int
    doc: When using `--filter-region-mask-fasta`, set the cutoff threshold for 
      the filtered digits. Only positions with that value or lower will be kept.
      The default is 0, meaning that all positions with digits greater than 0 
      will be removed.
    default: 0
    inputBinding:
      position: 101
      prefix: --filter-region-fasta-min
  - id: filter_region_gff
    type:
      - 'null'
      - type: array
        items: File
    doc: Genomic regions to filter for, as a GFF2/GFF3/GTF file. This only uses 
      the chromosome, as well as start and end information per line, and ignores
      everything else in the file. The filter keeps all listed positions, and 
      removes all that are not listed.
    inputBinding:
      position: 101
      prefix: --filter-region-gff
  - id: filter_region_list
    type:
      - 'null'
      - type: array
        items: File
    doc: Genomic regions to filter for, as a file with one region per line, 
      either in the format "chr" (for whole chromosomes), "chr:position", 
      "chr:start-end", "chr:start..end", or tab- or space-delimited "chr 
      position" or "chr start end". Positions are 1-based and inclusive (closed 
      intervals). The filter keeps all listed positions, and removes all that 
      are not listed. Multiple region options can be provided, see also 
      `--filter-region-set`.
    inputBinding:
      position: 101
      prefix: --filter-region-list
  - id: filter_region_map_bim
    type:
      - 'null'
      - type: array
        items: File
    doc: Genomic positions to filter for, as a MAP or BIM file as used in PLINK.
      This only uses the chromosome and coordinate per line, and ignores 
      everything else in the file. The filter keeps all listed positions, and 
      removes all that are not listed.
    inputBinding:
      position: 101
      prefix: --filter-region-map-bim
  - id: filter_region_set
    type:
      - 'null'
      - string
    doc: It is possible to provide multiple of the above region filter options, 
      even of different types. In that case, decide on how to combine the loci 
      of these filters.
    default: union
    inputBinding:
      position: 101
      prefix: --filter-region-set
  - id: filter_region_vcf
    type:
      - 'null'
      - type: array
        items: File
    doc: Genomic positions to filter for, as a VCF/BCF file (such as a 
      known-variants file). This only uses the chromosome and position per line,
      and ignores everything else in the file. The filter keeps all listed 
      positions, and removes all that are not listed.
    inputBinding:
      position: 101
      prefix: --filter-region-vcf
  - id: filter_sample_deletions_limit
    type:
      - 'null'
      - int
    doc: Maximum number of deletions at a position before being filtered out. If
      this is set to a value greater than 0, and the number of deletions at the 
      position is equal to or greater than this value, the sample is filtered 
      out.
    default: 0
    inputBinding:
      position: 101
      prefix: --filter-sample-deletions-limit
  - id: filter_sample_max_count
    type:
      - 'null'
      - int
    doc: Maximum base count for a nucleotide (in `ACGT`) to be considered as an 
      allele. Counts above that are set to zero, and hence ignored as an 
      allele/variant. For example, spuriously high read counts can be filtered 
      out this way.
    default: 0
    inputBinding:
      position: 101
      prefix: --filter-sample-max-count
  - id: filter_sample_max_read_depth
    type:
      - 'null'
      - int
    doc: Maximum read depth expected for a position in a sample to be considered
      covered. If the sum of nucleotide counts (in `ACGT`) at a given position 
      in a sample is greater than the provided value, the sample is ignored at 
      this position. This can for example be used to filter spuriously high read
      depth positions.
    default: 0
    inputBinding:
      position: 101
      prefix: --filter-sample-max-read-depth
  - id: filter_sample_min_count
    type:
      - 'null'
      - int
    doc: Minimum base count for a nucleotide (in `ACGT`) to be considered as an 
      allele. Counts below that are set to zero, and hence ignored as an 
      allele/variant. For example, singleton read sequencing errors can be 
      filtered out this way.
    default: 0
    inputBinding:
      position: 101
      prefix: --filter-sample-min-count
  - id: filter_sample_min_read_depth
    type:
      - 'null'
      - int
    doc: Minimum read depth expected for a position in a sample to be considered
      covered. If the sum of nucleotide counts (in `ACGT`) at a given position 
      in a sample is less than the provided value, the sample is ignored at this
      position.
    default: 0
    inputBinding:
      position: 101
      prefix: --filter-sample-min-read-depth
  - id: filter_sample_only_biallelic_snps
    type:
      - 'null'
      - boolean
    doc: Filter out any positions in a sample that do not have exactly two 
      alleles. That is, after applying `--filter-sample-min-count` and 
      `--filter-sample-max-count`, if not exactly two counts (in `ACGT`) are 
      non-zero, the position is not considered a biallelic SNP for the sample, 
      and ignored.
    inputBinding:
      position: 101
      prefix: --filter-sample-only-biallelic-snps
  - id: filter_sample_only_snps
    type:
      - 'null'
      - boolean
    doc: Filter out any positions in a sample that do not have two or more 
      alleles (i.e., that are invariant). That is, after applying 
      `--filter-sample-min-count` and `--filter-sample-max-count`, if less than 
      two counts (in `ACGT`) are non-zero, the position is not considered a SNP 
      for the sample, and ignored.
    inputBinding:
      position: 101
      prefix: --filter-sample-only-snps
  - id: filter_samples_exclude
    type:
      - 'null'
      - string
    doc: Sample names to exclude (all other samples are included); either (1) a 
      comma- or tab-separated list given on the command line (in a typical 
      shell, this list has to be enclosed in quotation marks), or (2) a file 
      with one sample name per line. If no sample filter is provided, all 
      samples in the input file are used. The option is applied after 
      potentially renaming the samples with `--rename-samples-list`.
    inputBinding:
      position: 101
      prefix: --filter-samples-exclude
  - id: filter_samples_include
    type:
      - 'null'
      - string
    doc: Sample names to include (all other samples are excluded); either (1) a 
      comma- or tab-separated list given on the command line (in a typical 
      shell, this list has to be enclosed in quotation marks), or (2) a file 
      with one sample name per line. If no sample filter is provided, all 
      samples in the input file are used. The option is applied after 
      potentially renaming the samples with `--rename-samples-list`.
    inputBinding:
      position: 101
      prefix: --filter-samples-include
  - id: filter_total_deletions_limit
    type:
      - 'null'
      - int
    doc: Maximum number of deletions at a position before being filtered out, 
      summed across all samples. If this is set to a value greater than 0, and 
      the number of deletions at the position is equal to or greater than this 
      value, the position is filtered out.
    default: 0
    inputBinding:
      position: 101
      prefix: --filter-total-deletions-limit
  - id: filter_total_max_read_depth
    type:
      - 'null'
      - int
    doc: Maximum read depth expected for a position in total to be considered 
      covered. If the sum of nucleotide counts (in `ACGT`) at a given position 
      in total (across all samples) is greater than the provided value, the 
      position is ignored. This can for example be used to filter spuriously 
      high read depth positions.
    default: 0
    inputBinding:
      position: 101
      prefix: --filter-total-max-read-depth
  - id: filter_total_min_read_depth
    type:
      - 'null'
      - int
    doc: Minimum read depth expected for a position in total to be considered 
      covered. If the sum of nucleotide counts (in `ACGT`) at a given position 
      in total (across all samples) is less than the provided value, the 
      position is ignored.
    default: 0
    inputBinding:
      position: 101
      prefix: --filter-total-min-read-depth
  - id: filter_total_only_biallelic_snps
    type:
      - 'null'
      - boolean
    doc: Filter out any positions that do not have exactly two alleles across 
      all samples. That is, after applying all previous filters, if not exactly 
      two counts (in `ACGT`) are non-zero in total across all samples, the 
      position is not considered a biallelic SNP, and ignored.
    inputBinding:
      position: 101
      prefix: --filter-total-only-biallelic-snps
  - id: filter_total_only_snps
    type:
      - 'null'
      - boolean
    doc: Filter out any positions that do not have two or more alleles (i.e., 
      that are invariant) across all samples. That is, after applying all 
      previous filters, if less than two counts (in `ACGT`) are non-zero in 
      total across all samples, the position is not considered a SNP, and 
      ignored.
    inputBinding:
      position: 101
      prefix: --filter-total-only-snps
  - id: filter_total_snp_max_count
    type:
      - 'null'
      - int
    doc: When filtering for positions that are SNPs, use this maximum count 
      (summed across all samples) to identify what is considered a SNP. 
      Positions where the counts are above this are filtered out; probably not 
      relevant in practice, but offered for completeness.
    default: 0
    inputBinding:
      position: 101
      prefix: --filter-total-snp-max-count
  - id: filter_total_snp_min_count
    type:
      - 'null'
      - int
    doc: When filtering for positions that are SNPs, use this minimum count 
      (summed across all samples) to identify what is considered a SNP. 
      Positions where the counts are below this are filtered out.
    default: 0
    inputBinding:
      position: 101
      prefix: --filter-total-snp-min-count
  - id: filter_total_snp_min_frequency
    type:
      - 'null'
      - float
    doc: Minimum allele frequency that needs to be reached for a position to be 
      used. Positions where the allele frequency `af` across all samples, or `1 
      - af`, is below this value, are ignored. If both the reference and 
      alternative base are known, allele frequencies are computed based on 
      those; if only the reference base is known, the most frequent 
      non-reference base is used as the alternative; if neither is known, the 
      first and second most frequent bases are used to compute the frequency.
    default: 0.0
    inputBinding:
      position: 101
      prefix: --filter-total-snp-min-frequency
  - id: frequency_table_alt_base_column
    type:
      - 'null'
      - string
    doc: Specify the name of the alternative base column in the header, case 
      sensitive. By default, we look for columns named "alternative", 
      "alternativebase", "alt", or "altbase", case insensitive, and ignoring any
      extra punctuation marks.
    inputBinding:
      position: 101
      prefix: --frequency-table-alt-base-column
  - id: frequency_table_chr_column
    type:
      - 'null'
      - string
    doc: Specify the name of the chromosome column in the header, case 
      sensitive. By default, we look for columns named "chromosome", "chrom", 
      "chr", or "contig", case insensitive.
    inputBinding:
      position: 101
      prefix: --frequency-table-chr-column
  - id: frequency_table_depth_factor
    type:
      - 'null'
      - float
    doc: For frequency table input that only contains allele frequencies, 
      without any information on read depth, we need to transform those 
      frequencies into counts for our internal processing. This number is 
      multiplied by the frequency to obtain these pseudo-counts. By default, we 
      use 1000000, to get a reasonable interger approximation of the floating 
      point frequency. This is of course above any typical read depth, but 
      allows for more accurate counts when using for instance 
      haplotype-corrected frequencies such as those from HAF-pipe.
    default: 0.0
    inputBinding:
      position: 101
      prefix: --frequency-table-depth-factor
  - id: frequency_table_freq_is_ref
    type:
      - 'null'
      - boolean
    doc: For frequency table input that contains allele frequencies, we need to 
      decide whether those frequencies represent the reference or the 
      alternative allele. By default, we assume the latter, i.e., values are 
      interpreted as alternative allele frequencies. Use this flag to instead 
      interpret them as reference allele frequencies.
    inputBinding:
      position: 101
      prefix: --frequency-table-freq-is-ref
  - id: frequency_table_missing_value
    type:
      - 'null'
      - string
    doc: Marker for denoting missing values in the table. By default, we use 
      `.`, `nan`, and `na`.
    inputBinding:
      position: 101
      prefix: --frequency-table-missing-value
  - id: frequency_table_paths
    type:
      - 'null'
      - type: array
        items: File
    doc: List of frequency table files or directories to process. For 
      directories, only files with the extension `.(csv|tsv)[.gz]` are 
      processed. To input more than one file or directory, either separate them 
      with spaces, or provide this option multiple times.
    inputBinding:
      position: 101
      prefix: --frequency-table-path
  - id: frequency_table_pos_column
    type:
      - 'null'
      - string
    doc: Specify the name of the position column in the header, case sensitive. 
      By default, we look for columns named "position" or "pos", case 
      insensitive.
    inputBinding:
      position: 101
      prefix: --frequency-table-pos-column
  - id: frequency_table_ref_base_column
    type:
      - 'null'
      - string
    doc: Specify the name of the reference base column in the header, case 
      sensitive. By default, we look for columns named "reference", 
      "referencebase", "ref", or "refbase", case insensitive, and ignoring any 
      extra punctuation marks.
    inputBinding:
      position: 101
      prefix: --frequency-table-ref-base-column
  - id: frequency_table_sample_alt_count_column
    type:
      - 'null'
      - string
    doc: Specify the exact prefix or suffix of the per-sample alternative count 
      columns in the header, case sensitive. By default, we look leniently for 
      column names that combine any of "alternative", "alternativebase", "alt", 
      or "altbase" with any of "counts", "count", "cnt", or "ct", case 
      insensitive, and ignoring any extra punctuation marks, as a prefix or 
      suffix, with the remainder of the column name used as the sample name. For
      example, "S1.alt_cnt" indicates the alternative count column for sample 
      "S1".
    inputBinding:
      position: 101
      prefix: --frequency-table-sample-alt-count-column
  - id: frequency_table_sample_depth_column
    type:
      - 'null'
      - string
    doc: Specify the exact prefix or suffix of the per-sample read depth columns
      in the header, case sensitive. By default, we look for column names having
      "readdepth", "depth", "coverage", "cov", or "ad", case insensitive, and 
      ignoring any extra punctuation marks, as a prefix or suffix, with the 
      remainder of the column name used as the sample name. For example, 
      "S1.read-depth" indicates the read depth column for sample "S1".
    inputBinding:
      position: 101
      prefix: --frequency-table-sample-depth-column
  - id: frequency_table_sample_freq_column
    type:
      - 'null'
      - string
    doc: Specify the exact prefix or suffix of the per-sample frequency columns 
      in the header, case sensitive. By default, we look for column names having
      "frequency", "freq", "maf", "af", or "allelefrequency", case insensitive, 
      and ignoring any extra punctuation marks, as a prefix or suffix, with the 
      remainder of the column name used as the sample name. For example, 
      "S1.freq" indicates the frequency column for sample "S1". Note that when 
      the input data contains frequencies, but no reference or alternative base 
      columns, such as HAF-pipe output tables, we cannot know the bases, and 
      will hence guess. To properly set the reference bases, consider providing 
      the `--reference-genome-fasta` option.
    inputBinding:
      position: 101
      prefix: --frequency-table-sample-freq-column
  - id: frequency_table_sample_ref_count_column
    type:
      - 'null'
      - string
    doc: Specify the exact prefix or suffix of the per-sample reference count 
      columns in the header, case sensitive. By default, we look leniently for 
      column names that combine any of "reference", "referencebase", "ref", or 
      "refbase" with any of "counts", "count", "cnt", or "ct", case insensitive,
      and ignoring any extra punctuation marks, as a prefix or suffix, with the 
      remainder of the column name used as the sample name. For example, 
      "S1.ref_cnt" indicates the reference count column for sample "S1".
    inputBinding:
      position: 101
      prefix: --frequency-table-sample-ref-count-column
  - id: frequency_table_separator_char
    type:
      - 'null'
      - string
    doc: Separator char between fields of the frequency table input.
    default: comma
    inputBinding:
      position: 101
      prefix: --frequency-table-separator-char
  - id: gapless_gsync
    type:
      - 'null'
      - boolean
    doc: 'By default, only the positions for which there is data are printed in the
      output. However, it might make processing with other tools easier if all files
      contain all positions, which one might call a `gsync` file (following the `gvcf`
      format). With this option, all missing positions are filled with the missing
      data indicator, or with zero counts, depending on the `--no-missing-marker`
      option. If a referene genome or dictionary is given, this might also include
      positions beyond where there is input data, up until the length of each chromosome.
      Hence, the resulting `gsync` files shall all have the exact same number of lines,
      which is convenient for simply downstream scripts. Note: This option is an alias
      for the more general `--make-gapless` option.'
    inputBinding:
      position: 101
      prefix: --gapless-gsync
  - id: guess_reference_base
    type:
      - 'null'
      - boolean
    doc: By default, when reading from input file formats that do not store the 
      reference base, we do not attempt to guess it. When set however, we use 
      the base with the highest count as the reference base for the output. 
      Alternatively, when a reference genome is provided, we use that to 
      correctly set the reference bases, independently of whether this flag is 
      set.
    inputBinding:
      position: 101
      prefix: --guess-reference-base
  - id: log_file
    type:
      - 'null'
      - string
    doc: Write all output to a log file, in addition to standard output to the 
      terminal.
    inputBinding:
      position: 101
      prefix: --log-file
  - id: make_gapless
    type:
      - 'null'
      - boolean
    doc: By default, we only operate on the positions for which there is data. 
      In particular, positions that are absent in the input are completely 
      ignored; they do not even show up in the `missing` column of output 
      tables. This is because for the statistics, data being absent or (marked 
      as) missing is merely a sementic distinction, but it does not change the 
      results. However, it might make processing with downstream tools easier if
      the output contains all positions, for instance when using `single` 
      windows. With this option, all absent positions are filled in as missing 
      data, so that they show up in the `missing` column and as entries in 
      single windows. If a referene genome or dictionary is given, this might 
      also include positions beyond where there is input data, up until the 
      length of each chromosome. Note that this can lead to large ouput tables 
      when processing single positions.
    inputBinding:
      position: 101
      prefix: --make-gapless
  - id: multi_file_locus_set
    type:
      - 'null'
      - string
    doc: When multiple input files are provided, select whether the union of all
      their loci is used (outer join), or their intersection (inner join). For 
      their union, input files that do not have data at a particular locus are 
      considered as missing at that locus. Note that we allow to use multiple 
      input files even with different file types.
    default: union
    inputBinding:
      position: 101
      prefix: --multi-file-locus-set
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: 'We provide an extension of the sync format that allows to store sample names
      in sync files, where a header line is added to the output file of the form:
      `#chr pos ref S1...`, where `S1...` is the list of sample names. Not all other
      tools that read sync files will be able to parse this, and it hence can be deactivated
      with this option.'
    inputBinding:
      position: 101
      prefix: --no-header
  - id: no_missing_marker
    type:
      - 'null'
      - boolean
    doc: We provide an extension of the sync format that allows to mark 
      positions as missing, by using the format `.:.:.:.:.:.`, instead of 
      setting zero counts for these positions. This is particularly useful when 
      storing data from multiple samples, to for instance distinguish true 
      missing data from positions that have been filtered out. Not all other 
      tools that read sync files will be able to parse this, and it hence can be
      deactivated here, in which case zero counts are written at these positions
      instead.
    inputBinding:
      position: 101
      prefix: --no-missing-marker
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Directory to write files to
    default: .
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: pileup_min_base_qual
    type:
      - 'null'
      - int
    doc: Minimum phred quality score [0-90] for a base in (m)pileup files to be 
      considered. Bases below this are ignored when computing allele 
      frequencies. Default is 0, meaning no filtering by phred quality score.
    default: 0
    inputBinding:
      position: 101
      prefix: --pileup-min-base-qual
  - id: pileup_paths
    type:
      - 'null'
      - type: array
        items: File
    doc: List of (m)pileup files or directories to process. For directories, 
      only files with the extension `.(plp|mplp|pileup|mpileup)[.gz]` are 
      processed. To input more than one file or directory, either separate them 
      with spaces, or provide this option multiple times.
    inputBinding:
      position: 101
      prefix: --pileup-path
  - id: pileup_quality_encoding
    type:
      - 'null'
      - string
    doc: Encoding of the quality scores of the bases in (m)pileup files, when 
      using `--pileup-min-base-qual`. Default is "sanger", which seems to be the
      most common these days. Both "sanger" and "illumina-1.8" are identical and
      use an ASCII offset of 33, while "illumina-1.3" and "illumina-1.5" are 
      identical with an ASCII offset of 64 (we provide different names for 
      completeness). Lastly, "solexa" has an offset of 64, but uses a different 
      equation (not phred score) for the encoding.
    default: sanger
    inputBinding:
      position: 101
      prefix: --pileup-quality-encoding
  - id: reference_genome_dict
    type:
      - 'null'
      - File
    doc: Provide a reference genome sequence dictionary in `.dict` format. It is
      used to determine the chromosome order and length, without having to 
      provide the full reference genome.
    inputBinding:
      position: 101
      prefix: --reference-genome-dict
  - id: reference_genome_fai
    type:
      - 'null'
      - File
    doc: Provide a reference genome sequence dictionary in `.fai` format. It is 
      used to determine the chromosome order and length, without having to 
      provide the full reference genome.
    inputBinding:
      position: 101
      prefix: --reference-genome-fai
  - id: reference_genome_fasta
    type:
      - 'null'
      - File
    doc: Provide a reference genome in `.fasta[.gz]` format. This allows to 
      correctly assign the reference bases in file formats that do not store 
      them, and serves as an integrity check in those that do. It further is 
      used as a sequence dictionary to determine the chromosome order and 
      length, on behalf of a dict or fai file.
    inputBinding:
      position: 101
      prefix: --reference-genome-fasta
  - id: rename_samples_list
    type:
      - 'null'
      - File
    doc: "Allows to rename samples, by providing a file that lists the original and
      new sample names, one per line, separating original and new names by a comma
      or tab.\nBy default, we use sample names as provided in the input files. Some
      file types however do not contain sample names, such as (m)pileup or sync files
      (unless the non-standard sync header line is provided). For such file types,
      sample names are automatically assigned by using their input file base name
      (without path and extension), followed by a dot and numbers 1..n for all samples
      in that file. For instance, samples in `/path/to/sample.sync` are named `sample.1`,
      `sample.2`, etc.\nUsing this option, those names can be renamed as needed. Use
      verbose output (`--verbose`) to show a list of all sample names. We then use
      these names in the output as well as in the `--filter-samples-include` and `--filter-samples-exclude`
      options."
    inputBinding:
      position: 101
      prefix: --rename-samples-list
  - id: sam_flags_exclude_all
    type:
      - 'null'
      - string
    doc: Do not use reads with all bits set in the given value present in the 
      FLAG field of the read. This is equivalent to the `-G` setting in 
      `samtools view`. See `--sam-flags-include-all` above for how to specify 
      the value.
    inputBinding:
      position: 101
      prefix: --sam-flags-exclude-all
  - id: sam_flags_exclude_any
    type:
      - 'null'
      - string
    doc: Do not use reads with any bits set in the given value present in the 
      FLAG field of the read. This is equivalent to the `-F` / `--excl-flags` / 
      `--exclude-flags` setting in `samtools view`. See 
      `--sam-flags-include-all` above for how to specify the value.
    inputBinding:
      position: 101
      prefix: --sam-flags-exclude-any
  - id: sam_flags_include_all
    type:
      - 'null'
      - string
    doc: Only use reads with all bits in the given value present in the FLAG 
      field of the read. This is equivalent to the `-f` / `--require-flags` 
      setting in `samtools view`, and uses the same flag names and their 
      corresponding binary values. The value can be specified in hex by 
      beginning with `0x` (i.e., `/^0x[0-9A-F]+/`), in octal by beginning with 
      `0` (i.e., `/^0[0-7]+/`), as a decimal number not beginning with '0', or 
      as a comma-, plus-, space-, or vertiacal-bar-separated list of flag names 
      as specified by samtools. We are more lenient in parsing flag names than 
      `samtools`, and allow different capitalization and delimiteres such as 
      dashes and underscores in the flag names as well.
    inputBinding:
      position: 101
      prefix: --sam-flags-include-all
  - id: sam_flags_include_any
    type:
      - 'null'
      - string
    doc: Only use reads with any bits set in the given value present in the FLAG
      field of the read. This is equivalent to the `--rf` / `--incl-flags` / 
      `--include-flags` setting in `samtools view`. See 
      `--sam-flags-include-all` above for how to specify the value.
    inputBinding:
      position: 101
      prefix: --sam-flags-include-any
  - id: sam_min_base_qual
    type:
      - 'null'
      - int
    doc: Minimum phred-scaled quality score [0-90] for a base in sam/bam/cram 
      files to be considered. Bases below this are ignored when computing allele
      frequencies. Default is 0, meaning no filtering by base quality.
    default: 0
    inputBinding:
      position: 101
      prefix: --sam-min-base-qual
  - id: sam_min_map_qual
    type:
      - 'null'
      - int
    doc: Minimum phred-scaled mapping quality score [0-90] for a read in 
      sam/bam/cram files to be considered. Any read that is below the given 
      value of mapping quality will be completely discarded, and its bases not 
      taken into account. Default is 0, meaning no filtering by base quality.
    default: 0
    inputBinding:
      position: 101
      prefix: --sam-min-map-qual
  - id: sam_paths
    type:
      - 'null'
      - type: array
        items: File
    doc: List of sam/bam/cram files or directories to process. For directories, 
      only files with the extension `.sam[.gz]|.bam|.cram` are processed. To 
      input more than one file or directory, either separate them with spaces, 
      or provide this option multiple times.
    inputBinding:
      position: 101
      prefix: --sam-path
  - id: sam_split_by_rg
    type:
      - 'null'
      - boolean
    doc: Instead of considering the whole sam/bam/cram file as one large 
      colletion of reads, use the `@RG` read group tag to split reads. Each read
      group is then considered a sample. Reads with an invalid (not in the 
      header) read group tag or without a tag are ignored.
    inputBinding:
      position: 101
      prefix: --sam-split-by-rg
  - id: sample_group_merge_table
    type:
      - 'null'
      - File
    doc: When the input contains multiple samples (either within a single input 
      file, or by providing multiple input files), these can be merged into new 
      samples, by summing up their nucleotide base counts at each position. This
      has essentially the same effect as having merged the raw fastq files or 
      the mapped sam/bam files of the samples, that is, all reads from those 
      samples are treated as if they were a single sample. For this grouping, 
      the option takes a simple table file (comma- or tab-separated), with the 
      sample names (after the above renaming, if provided) in the first column, 
      and their assigned group names in the second column. All samples in the 
      same group are then merged into a grouped sample, and the group names are 
      used as the new sample names for the output. Note that the `--pool-sizes` 
      option then need to contain the summed up pool sizes for each group, using
      the group names.
    inputBinding:
      position: 101
      prefix: --sample-group-merge-table
  - id: subsample_max_read_depth
    type:
      - 'null'
      - int
    doc: If provided, the nucleotide counts of each sample are subsampled so 
      that they do not exceed this given maximum total read depth (sum of the 
      four nucleotide counts `ACGT`, as well as the any `N` and deleted `D` 
      counts). If they are below this value anyway, they are not changed. This 
      transformation is useful to limit the maximum read depth. For instance, 
      the diversity estimators for Theta Pi and Theta Watterson have terms that 
      depend on read depth. In particular when merging samples such as with 
      `--sample-group-merge-table`, having an upper limit can hence avoid long 
      compute times. Furthermore, a very low Tajima's D, usually indicative of a
      selective sweep, may be found as an artifact in highly covered regions, as
      such regions have just more sequencing errors. To avoid these kinds of 
      biases we recommend to subsample to an uniform read depth. This 
      transformation is applied after the numerical filters, so that, e.g., 
      filters for high read depth are able to remove any unwanted positions 
      first. See `--subsample-method` for the subsampling method.
    default: 0
    inputBinding:
      position: 101
      prefix: --subsample-max-read-depth
  - id: subsample_method
    type:
      - 'null'
      - string
    doc: When using `--subsample-max-read-depth`, decide which method to use. 
      The default `subscale` simply re-scales the base counts to the given max 
      read depth, and hence maintains the allele frequencies (within integer 
      precision). We recommend to use this to subsample to, e.g., a max read 
      depth of 10,000, which is a good compromise in most cases. The two 
      alternative options re-sample instead, with and without replacement, by 
      drawing from a multinomial or multivariate hypergeometric distribution, 
      respectively, based on the original counts of the sample.
    default: subscale
    inputBinding:
      position: 101
      prefix: --subsample-method
  - id: sync_paths
    type:
      - 'null'
      - type: array
        items: File
    doc: List of sync (as specified by PoPoolation2) files or directories to 
      process. For directories, only files with the extension `.sync[.gz]` are 
      processed. To input more than one file or directory, either separate them 
      with spaces, or provide this option multiple times.
    inputBinding:
      position: 101
      prefix: --sync-path
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for calculations. If not set, we guess a 
      reasonable number of threads, by looking at the environmental variables 
      (1) `OMP_NUM_THREADS` (OpenMP) and (2) `SLURM_CPUS_PER_TASK` (slurm), as 
      well as (3) the hardware concurrency (number of CPU cores), taking 
      hyperthreads into account, in the given order of precedence.
    default: 14
    inputBinding:
      position: 101
      prefix: --threads
  - id: vcf_paths
    type:
      - 'null'
      - type: array
        items: File
    doc: List of vcf/bcf files or directories to process. For directories, only 
      files with the extension `.vcf[.gz]|.bcf` are processed. To input more 
      than one file or directory, either separate them with spaces, or provide 
      this option multiple times. This expects that the input file has the 
      per-sample VCF FORMAT field `AD` (alleleic depth) given, containing the 
      counts of the reference and alternative base. This assumes that the data 
      that was used to create the VCF file was actually a pool of individuals 
      (e.g., from pool sequencing) for each sample (column) of the VCF file. We 
      then interpret the `AD` field as the allele counts of each pool of 
      individuals. Note that only SNP positions are used; positions that contain
      indels and other non-SNP variants are skipped.
    inputBinding:
      position: 101
      prefix: --vcf-path
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Produce more verbose output.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grenedalf:0.6.3--hbefcdb2_0
stdout: grenedalf_sync.out
