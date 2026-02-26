cwlVersion: v1.2
class: CommandLineTool
baseCommand: Haplotype Comparison
label: hap.py
doc: "Haplotype Comparison\n\nTool homepage: https://github.com/Illumina/hap.py"
inputs:
  - id: vcfs
    type:
      type: array
      items: File
    doc: Two VCF files.
    inputBinding:
      position: 1
  - id: adjust_conf_regions
    type:
      - 'null'
      - boolean
    doc: Adjust confident regions to include variant locations. Note this will 
      only include variants that are included in the CONF regions already when 
      viewing with bcftools; this option only makes sure insertions are padded 
      correctly in the CONF regions (to capture these, both the base before and 
      after must be contained in the bed file).
    inputBinding:
      position: 102
      prefix: --adjust-conf-regions
  - id: bcf
    type:
      - 'null'
      - boolean
    doc: Use BCF internally. This is the default when the input file is in BCF 
      format already. Using BCF can speed up temp file access, but may fail for 
      VCF files that have broken headers or records that don't comply with the 
      header.
    inputBinding:
      position: 102
      prefix: --bcf
  - id: bcftools_norm
    type:
      - 'null'
      - boolean
    doc: Enable preprocessing through bcftools norm -c x -D (requires external 
      preprocessing to be switched on).
    inputBinding:
      position: 102
      prefix: --bcftools-norm
  - id: ci_alpha
    type:
      - 'null'
      - float
    doc: Confidence level for Jeffrey's CI for recall, precision and fraction of
      non-assessed calls.
    inputBinding:
      position: 102
      prefix: --ci-alpha
  - id: convert_gvcf_query
    type:
      - 'null'
      - boolean
    doc: Convert the query set from genome VCF format to a VCF before 
      processing.
    inputBinding:
      position: 102
      prefix: --convert-gvcf-query
  - id: convert_gvcf_to_vcf
    type:
      - 'null'
      - boolean
    doc: Convert the input set from genome VCF format to a VCF before 
      processing.
    inputBinding:
      position: 102
      prefix: --convert-gvcf-to-vcf
  - id: convert_gvcf_truth
    type:
      - 'null'
      - boolean
    doc: Convert the truth set from genome VCF format to a VCF before 
      processing.
    inputBinding:
      position: 102
      prefix: --convert-gvcf-truth
  - id: decompose
    type:
      - 'null'
      - boolean
    doc: Decompose variants into primitives. This results in more granular 
      counts.
    inputBinding:
      position: 102
      prefix: --decompose
  - id: engine
    type:
      - 'null'
      - string
    doc: Comparison engine to use.
    inputBinding:
      position: 102
      prefix: --engine
  - id: engine_vcfeval_path
    type:
      - 'null'
      - string
    doc: This parameter should give the path to the "rtg" executable. The 
      default is rtg
    inputBinding:
      position: 102
      prefix: --engine-vcfeval-path
  - id: engine_vcfeval_template
    type:
      - 'null'
      - string
    doc: Vcfeval needs the reference sequence formatted in its own file format 
      (SDF -- run rtg format -o ref.SDF ref.fa). You can specify this here to 
      save time when running hap.py with vcfeval. If no SDF folder is specified,
      hap.py will create a temporary one.
    inputBinding:
      position: 102
      prefix: --engine-vcfeval-template
  - id: false_positives
    type:
      - 'null'
      - File
    doc: False positive / confident call regions (.bed or .bed.gz). Calls 
      outside these regions will be labelled as UNK.
    inputBinding:
      position: 102
      prefix: --false-positives
  - id: filter_nonref
    type:
      - 'null'
      - boolean
    doc: Remove any variants genotyped as <NON_REF>.
    inputBinding:
      position: 102
      prefix: --filter-nonref
  - id: filters_only
    type:
      - 'null'
      - string
    doc: Specify a comma-separated list of filters to apply (by default all 
      filters are ignored / passed on.
    inputBinding:
      position: 102
      prefix: --filters-only
  - id: fixchr
    type:
      - 'null'
      - boolean
    doc: 'Add chr prefix to VCF records where necessary (default: auto, attempt to
      match reference).'
    inputBinding:
      position: 102
      prefix: --fixchr
  - id: gender
    type:
      - 'null'
      - string
    doc: 'Specify sex. This determines how haploid calls on chrX get treated: for
      male samples, all non-ref calls (in the truthset only when running through hap.py)
      are given a 1/1 genotype.'
    inputBinding:
      position: 102
      prefix: --gender
  - id: keep_scratch
    type:
      - 'null'
      - boolean
    doc: Filename prefix for scratch report output.
    inputBinding:
      position: 102
      prefix: --keep-scratch
  - id: leftshift
    type:
      - 'null'
      - boolean
    doc: Left-shift variants safely.
    inputBinding:
      position: 102
      prefix: --leftshift
  - id: locations
    type:
      - 'null'
      - string
    doc: Comma-separated list of locations [use naming after preprocessing], 
      when not specified will use whole VCF.
    inputBinding:
      position: 102
      prefix: --location
  - id: logfile
    type:
      - 'null'
      - File
    doc: Write logging information into file rather than to stderr
    inputBinding:
      position: 102
      prefix: --logfile
  - id: lose_match_distance
    type:
      - 'null'
      - int
    doc: For distance-based matching (vcfeval and scmp), this is the distance 
      between variants to use.
    inputBinding:
      position: 102
      prefix: --lose-match-distance
  - id: no_adjust_conf_regions
    type:
      - 'null'
      - boolean
    doc: Do not adjust confident regions for insertions.
    inputBinding:
      position: 102
      prefix: --no-adjust-conf-regions
  - id: no_decompose
    type:
      - 'null'
      - boolean
    doc: Do not decompose variants into primitives.
    inputBinding:
      position: 102
      prefix: --no-decompose
  - id: no_fixchr
    type:
      - 'null'
      - boolean
    doc: 'Do not add chr prefix to VCF records (default: auto, attempt to match reference).'
    inputBinding:
      position: 102
      prefix: --no-fixchr
  - id: no_json
    type:
      - 'null'
      - boolean
    doc: Disable JSON file output.
    inputBinding:
      position: 102
      prefix: --no-json
  - id: no_leftshift
    type:
      - 'null'
      - boolean
    doc: Do not left-shift variants safely.
    inputBinding:
      position: 102
      prefix: --no-leftshift
  - id: no_roc
    type:
      - 'null'
      - boolean
    doc: Disable ROC computation and only output summary statistics for more 
      concise output.
    inputBinding:
      position: 102
      prefix: --no-roc
  - id: no_write_counts
    type:
      - 'null'
      - boolean
    doc: Do not write advanced counts and metrics.
    inputBinding:
      position: 102
      prefix: --no-write-counts
  - id: output_vtc
    type:
      - 'null'
      - boolean
    doc: Write VTC field in the final VCF which gives the counts each position 
      has contributed to.
    inputBinding:
      position: 102
      prefix: --output-vtc
  - id: pass_only
    type:
      - 'null'
      - boolean
    doc: Keep only PASS variants.
    inputBinding:
      position: 102
      prefix: --pass-only
  - id: preprocess_truth
    type:
      - 'null'
      - boolean
    doc: Preprocess truth file with same settings as query (default is to accept
      truth in original format).
    inputBinding:
      position: 102
      prefix: --preprocess-truth
  - id: preprocessing_window_size
    type:
      - 'null'
      - int
    doc: Preprocessing window size (variants further apart than that size are 
      not expected to interfere).
    inputBinding:
      position: 102
      prefix: --preprocessing-window-size
  - id: preserve_info
    type:
      - 'null'
      - boolean
    doc: When using XCMP, preserve and merge the INFO fields in truth and query.
      Useful for ROC computation.
    inputBinding:
      position: 102
      prefix: --preserve-info
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Set logging level to output errors only.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: reference
    type:
      - 'null'
      - File
    doc: Specify a reference file.
    inputBinding:
      position: 102
      prefix: --reference
  - id: regions_bedfile
    type:
      - 'null'
      - File
    doc: Restrict analysis to given (sparse) regions (using -R in bcftools).
    inputBinding:
      position: 102
      prefix: --restrict-regions
  - id: report_prefix
    type:
      - 'null'
      - string
    doc: Filename prefix for report output.
    inputBinding:
      position: 102
      prefix: --report-prefix
  - id: roc
    type:
      - 'null'
      - string
    doc: Select a feature to produce a ROC on (INFO feature, QUAL, GQX, ...).
    inputBinding:
      position: 102
      prefix: --roc
  - id: roc_delta
    type:
      - 'null'
      - float
    doc: Minimum spacing between ROC QQ levels.
    inputBinding:
      position: 102
      prefix: --roc-delta
  - id: roc_filter
    type:
      - 'null'
      - string
    doc: Select a filter to ignore when making ROCs.
    inputBinding:
      position: 102
      prefix: --roc-filter
  - id: roc_regions
    type:
      - 'null'
      - string
    doc: Select a list of regions to compute ROCs in. By default, only the '*' 
      region will produce ROC output (aggregate variant counts).
    inputBinding:
      position: 102
      prefix: --roc-regions
  - id: scmp_distance
    type:
      - 'null'
      - int
    doc: For distance-based matching (vcfeval and scmp), this is the distance 
      between variants to use.
    inputBinding:
      position: 102
      prefix: --scmp-distance
  - id: scratch_prefix
    type:
      - 'null'
      - Directory
    doc: Directory for scratch files.
    inputBinding:
      position: 102
      prefix: --scratch-prefix
  - id: set_gt
    type:
      - 'null'
      - string
    doc: 'This is used to treat Strelka somatic files Possible values for this parameter:
      half / hemi / het / hom / half to assign one of the following genotypes to the
      resulting sample: 1 | 0/1 | 1/1 | ./1. This will replace all sample columns
      and replace them with a single one.'
    inputBinding:
      position: 102
      prefix: --set-gt
  - id: somatic
    type:
      - 'null'
      - boolean
    doc: Assume the input file is a somatic call file and squash all columns 
      into one, putting all FORMATs into INFO + use half genotypes (see also 
      --set-gt). This will replace all sample columns and replace them with a 
      single one.
    inputBinding:
      position: 102
      prefix: --somatic
  - id: stratification
    type:
      - 'null'
      - File
    doc: Stratification file list (TSV format -- first column is region name, 
      second column is file name).
    inputBinding:
      position: 102
      prefix: --stratification
  - id: stratification_fixchr
    type:
      - 'null'
      - boolean
    doc: Add chr prefix to stratification files if necessary
    inputBinding:
      position: 102
      prefix: --stratification-fixchr
  - id: stratification_region
    type:
      - 'null'
      - string
    doc: Add single stratification region, e.g. --stratification-region 
      TEST:test.bed
    inputBinding:
      position: 102
      prefix: --stratification-region
  - id: targets_bedfile
    type:
      - 'null'
      - File
    doc: Restrict analysis to given (dense) regions (using -T in bcftools).
    inputBinding:
      position: 102
      prefix: --target-regions
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 102
      prefix: --threads
  - id: type
    type:
      - 'null'
      - string
    doc: Annotation format in input VCF file.
    inputBinding:
      position: 102
      prefix: --type
  - id: unhappy
    type:
      - 'null'
      - boolean
    doc: Disable haplotype comparison (only count direct GT matches as TP).
    inputBinding:
      position: 102
      prefix: --unhappy
  - id: usefiltered_truth
    type:
      - 'null'
      - boolean
    doc: Use filtered variant calls in truth file (by default, only PASS calls 
      in the truth file are used)
    inputBinding:
      position: 102
      prefix: --usefiltered-truth
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Raise logging level from warning to info.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: window_size
    type:
      - 'null'
      - int
    doc: Minimum distance between variants such that they fall into the same 
      superlocus.
    inputBinding:
      position: 102
      prefix: --window-size
  - id: write_counts
    type:
      - 'null'
      - boolean
    doc: Write advanced counts and metrics.
    inputBinding:
      position: 102
      prefix: --write-counts
  - id: write_vcf
    type:
      - 'null'
      - boolean
    doc: Write an annotated VCF.
    inputBinding:
      position: 102
      prefix: --write-vcf
  - id: xcmp_enumeration_threshold
    type:
      - 'null'
      - int
    doc: Enumeration threshold / maximum number of sequences to enumerate per 
      block.
    inputBinding:
      position: 102
      prefix: --xcmp-enumeration-threshold
  - id: xcmp_expand_hapblocks
    type:
      - 'null'
      - int
    doc: Expand haplotype blocks by this many basepairs left and right.
    inputBinding:
      position: 102
      prefix: --xcmp-expand-hapblocks
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hap.py:0.3.15--py27hcb73b3d_0
stdout: hap.py.out
