cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- AlleleFrequencyQC
label: gatk_AlleleFrequencyQC
doc: |-
  Given a variant callset, it is common to calculate various quality control metrics. These metrics include the number of raw or filtered SNP counts; ratio of transition mutations to transversions; concordance of a particular sample's calls to a genotyping chip; number of singletons per sample; etc. Furthermore, it is often useful to stratify these metrics by various criteria like functional class (missense, nonsense, silent), whether the site is CpG site, the amino acid degeneracy of the site, etc. VariantEval facilitates these calculations in two ways: by providing several built-in evaluation and stratification modules, and by providing a framework that permits the easy development of new evaluation and stratification modules.

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: eval
  type:
    type: array
    items: File
    inputBinding:
      prefix: --eval
  doc: Input evaluation file(s) This argument must be specified at least once.
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: output
  type: string
  doc: File to which variants should be written
  inputBinding:
    prefix: --output
- id: reference
  type: File
  doc: Reference sequence file
  inputBinding:
    prefix: --reference
  secondaryFiles:
  - pattern: .fai
    required: true
  - pattern: ^.dict
    required: true
- id: allowed_variance
  type:
  - 'null'
  - double
  doc: 'Variance allowed in calculating the modified chi squared statistic. Default
    value: 0.01.'
  inputBinding:
    prefix: --allowedVariance
- id: ancestral_alignments
  type:
  - 'null'
  - File
  doc: Fasta file with ancestral alleles
  inputBinding:
    prefix: --ancestral-alignments
- id: comparison
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --comparison
  doc: Input comparison file(s) This argument may be specified 0 or more times.
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: dbsnp
  type:
  - 'null'
  - File
  doc: dbSNP file
  inputBinding:
    prefix: --dbsnp
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: debug_file
  type:
  - 'null'
  - string
  doc: File to save the results from variant eval for debugging
  inputBinding:
    prefix: --debugFile
- id: do_not_use_all_standard_modules
  type:
  - 'null'
  - boolean
  doc: 'Do not use the standard modules by default (instead, only those that are specified
    with the -EV option) Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --do-not-use-all-standard-modules
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: do_not_use_all_standard_stratifications
  type:
  - 'null'
  - boolean
  doc: 'Do not use the standard stratification modules by default (instead, only those
    that are specified with the -S option) Default value: false. Possible values:
    {true, false}'
  inputBinding:
    prefix: --do-not-use-all-standard-stratifications
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: eval_module
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --eval-module
  doc: One or more specific eval modules to apply to the eval track(s) (in addition
    to the standard modules, unless -no-ev is specified) This argument may be specified
    0 or more times.
- id: exclude_intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --exclude-intervals
  doc: One or more genomic intervals to exclude from processing This argument may
    be specified 0 or more times.
- id: gold_standard
  type:
  - 'null'
  - File
  doc: Evaluations that count calls at sites of true variation (e.g., indel calls)
    will use this argument as their gold standard for comparison
  inputBinding:
    prefix: --gold-standard
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: interval_padding
  type:
  - 'null'
  - int
  doc: 'Amount of padding (in bp) to add to each interval you are including. Default
    value: 0.'
  inputBinding:
    prefix: --interval-padding
- id: intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --intervals
  doc: One or more genomic intervals over which to operate This argument may be specified
    0 or more times.
- id: keep_ac0
  type:
  - 'null'
  - boolean
  doc: 'If provided, modules that track polymorphic sites will not require that a
    site have AC > 0 when the input eval has genotypes Default value: false. Possible
    values: {true, false}'
  inputBinding:
    prefix: --keep-ac0
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: known_cnvs
  type:
  - 'null'
  - File
  doc: File containing tribble-readable features describing a known list of copy number
    variants
  inputBinding:
    prefix: --known-cnvs
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: known_names
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --knownNames
  doc: Name of feature bindings containing variant sites that should be treated as
    known when splitting eval features into known and novel subsets This argument
    may be specified 0 or more times.
- id: list
  type:
  - 'null'
  - boolean
  doc: 'List the available eval modules and exit Default value: false. Possible values:
    {true, false}'
  inputBinding:
    prefix: --list
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: mendelian_violation_qual_threshold
  type:
  - 'null'
  - double
  doc: 'Minimum genotype QUAL score for each trio member required to accept a site
    as a violation. Default is 50. Default value: 50.0.'
  inputBinding:
    prefix: --mendelian-violation-qual-threshold
- id: merge_evals
  type:
  - 'null'
  - boolean
  doc: 'If provided, all -eval tracks will be merged into a single eval track Default
    value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --merge-evals
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: min_phase_quality
  type:
  - 'null'
  - double
  doc: 'Minimum phasing quality Default value: 10.0.'
  inputBinding:
    prefix: --min-phase-quality
- id: pedigree
  type:
  - 'null'
  - File
  doc: Pedigree file for determining the population "founders"
  inputBinding:
    prefix: --pedigree
- id: pedigree_validation_type
  type:
  - 'null'
  - string
  doc: 'The strictness for validating the pedigree. Can be either STRICT or SILENT.
    Default is STRICT Default value: STRICT. Possible values: {STRICT, SILENT}'
  inputBinding:
    prefix: --pedigreeValidationType
- id: require_strict_allele_match
  type:
  - 'null'
  - boolean
  doc: 'If provided only comp and eval tracks with exactly matching reference and
    alternate alleles will be counted as overlapping Default value: false. Possible
    values: {true, false}'
  inputBinding:
    prefix: --require-strict-allele-match
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: sample_ploidy
  type:
  - 'null'
  - int
  doc: 'Per-sample ploidy (number of chromosomes per sample) Default value: 2.'
  inputBinding:
    prefix: --sample-ploidy
- id: select_exps
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --selectExps
  doc: One or more stratifications to use when evaluating the data This argument may
    be specified 0 or more times.
- id: select_names
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --selectNames
  doc: Names to use for the list of stratifications (must be a 1-to-1 mapping) This
    argument may be specified 0 or more times.
- id: strat_intervals
  type:
  - 'null'
  - File
  doc: File containing tribble-readable features for the IntervalStratificiation
  inputBinding:
    prefix: --strat-intervals
- id: stratification_module
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --stratification-module
  doc: One or more specific stratification modules to apply to the eval track(s) (in
    addition to the standard stratifications, unless -noS is specified) This argument
    may be specified 0 or more times.
- id: threshold
  type:
  - 'null'
  - double
  doc: 'Threshold to cut off the pvalue. Default value: 0.05.'
  inputBinding:
    prefix: --threshold
- id: combine_variants_distance
  type:
  - 'null'
  - int
  doc: 'Maximum distance for variants to be grouped together Default value: 0.'
  inputBinding:
    prefix: --combine-variants-distance
- id: ignore_variants_starting_outside_interval
  type:
  - 'null'
  - boolean
  doc: 'Restrict variant output to sites that start within provided intervals (only
    applies when an interval is specified) Default value: false. Possible values:
    {true, false}'
  inputBinding:
    prefix: --ignore-variants-starting-outside-interval
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: max_distance
  type:
  - 'null'
  - int
  doc: 'Maximum distance for variants to be grouped together Default value: 2147483647.'
  inputBinding:
    prefix: --max-distance
- id: ref_padding
  type:
  - 'null'
  - int
  doc: 'Number of bases on either side to expand spanning reference window Default
    value: 1.'
  inputBinding:
    prefix: --ref-padding
outputs:
- id: output_output
  type: File
  doc: File to which variants should be written
  outputBinding:
    glob: $(inputs.output)
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: output_debug_file
  type:
  - 'null'
  - File
  doc: File to save the results from variant eval for debugging
  outputBinding:
    glob: $(inputs.debug_file)
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
