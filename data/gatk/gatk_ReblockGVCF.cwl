cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- ReblockGVCF
label: gatk_ReblockGVCF
doc: |-
  Compress a single-sample GVCF from HaplotypeCaller by merging homRef blocks using new GQ band parameters

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
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
- id: variant
  type:
    type: array
    items: File
    inputBinding:
      prefix: --variant
  doc: One or more VCF files containing variants This argument must be specified at
    least once.
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: annotate_with_num_discovered_alleles
  type:
  - 'null'
  - boolean
  doc: 'If provided, we will annotate records with the number of alternate alleles
    that were discovered (but not necessarily genotyped) at a given site Default value:
    false. Possible values: {true, false}'
  inputBinding:
    prefix: --annotate-with-num-discovered-alleles
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: annotation
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --annotation
  doc: 'One or more specific annotations to add to variant calls This argument may
    be specified 0 or more times. Possible values: {AlleleFraction, AllelePseudoDepth,
    AS_BaseQualityRankSumTest, AS_FisherStrand, AS_InbreedingCoeff, AS_MappingQualityRankSumTest,
    AS_QualByDepth, AS_ReadPosRankSumTest, AS_RMSMappingQuality, AS_StrandBiasMutectAnnotation,
    AS_StrandOddsRatio, AssemblyComplexity, BaseQuality, BaseQualityHistogram, BaseQualityRankSumTest,
    ChromosomeCounts, ClippingRankSumTest, CountNs, Coverage, CycleSkipStatus, DepthPerAlleleBySample,
    DepthPerSampleHC, ExcessHet, FisherStrand, FragmentDepthPerAlleleBySample, FragmentLength,
    GcContent, GenotypeSummaries, HaplotypeFilteringAnnotation, HmerIndelLength, HmerIndelNuc,
    HmerMotifs, InbreedingCoeff, IndelClassify, IndelLength, LikelihoodRankSumTest,
    MappingQuality, MappingQualityRankSumTest, MappingQualityZero, OrientationBiasReadCounts,
    OriginalAlignment, PossibleDeNovo, QualByDepth, RawGtCount, ReadPosition, ReadPosRankSumTest,
    ReferenceBases, RMSMappingQuality, SampleList, StrandBiasBySample, StrandOddsRatio,
    TandemRepeat, TransmittedSingleton, UniqueAltReadCount, VariantType}'
- id: annotation_group
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --annotation-group
  doc: 'One or more groups of annotations to apply to variant calls This argument
    may be specified 0 or more times. Possible values: {AlleleSpecificAnnotation,
    AS_StandardAnnotation, GenotypeAnnotation, InfoFieldAnnotation, JumboGenotypeAnnotation,
    JumboInfoAnnotation, ReducibleAnnotation, StandardAnnotation, StandardFlowBasedAnnotation,
    StandardHCAnnotation, StandardMutectAnnotation, VariantAnnotation}'
- id: annotations_to_exclude
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --annotations-to-exclude
  doc: 'One or more specific annotations to exclude from variant calls This argument
    may be specified 0 or more times. Possible values: {AS_BaseQualityRankSumTest,
    AS_FisherStrand, AS_InbreedingCoeff, AS_MappingQualityRankSumTest, AS_QualByDepth,
    AS_ReadPosRankSumTest, AS_RMSMappingQuality, AS_StrandOddsRatio, BaseQualityRankSumTest,
    ChromosomeCounts, Coverage, DepthPerAlleleBySample, ExcessHet, FisherStrand, InbreedingCoeff,
    MappingQualityRankSumTest, QualByDepth, ReadPosRankSumTest, RMSMappingQuality,
    StrandOddsRatio}'
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
- id: flow_order_for_annotations
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --flow-order-for-annotations
  doc: flow order used for this annotations. [readGroup:]flowOrder This argument may
    be specified 0 or more times.
- id: founder_id
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --founder-id
  doc: Samples representing the population "founders" This argument may be specified
    0 or more times.
- id: genotype_assignment_method
  type:
  - 'null'
  - string
  doc: 'How we assign genotypes Default value: USE_PLS_TO_ASSIGN. Possible values:
    {SET_TO_NO_CALL, USE_PLS_TO_ASSIGN, USE_POSTERIORS_ANNOTATION, SET_TO_NO_CALL_NO_ANNOTATIONS,
    BEST_MATCH_TO_ORIGINAL, DO_NOT_ASSIGN_GENOTYPES, USE_POSTERIOR_PROBABILITIES,
    PREFER_PLS}'
  inputBinding:
    prefix: --genotype-assignment-method
- id: heterozygosity
  type:
  - 'null'
  - double
  doc: 'Heterozygosity value used to compute prior probabilities for any locus. See
    the GATKDocs for full details on the meaning of this population genetics concept
    Default value: 0.001.'
  inputBinding:
    prefix: --heterozygosity
- id: heterozygosity_stdev
  type:
  - 'null'
  - double
  doc: 'Standard deviation of heterozygosity for SNP and indel calling. Default value:
    0.01.'
  inputBinding:
    prefix: --heterozygosity-stdev
- id: indel_heterozygosity
  type:
  - 'null'
  - double
  doc: 'Heterozygosity for indel calling. See the GATKDocs for heterozygosity for
    full details on the meaning of this population genetics concept Default value:
    1.25E-4.'
  inputBinding:
    prefix: --indel-heterozygosity
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
- id: num_reference_samples_if_no_call
  type:
  - 'null'
  - int
  doc: 'Number of hom-ref genotypes to infer at sites not present in a panel Default
    value: 0.'
  inputBinding:
    prefix: --num-reference-samples-if-no-call
- id: pedigree
  type:
  - 'null'
  - File
  doc: Pedigree file for determining the population "founders"
  inputBinding:
    prefix: --pedigree
- id: population_callset
  type:
  - 'null'
  - File
  doc: Callset to use in calculating genotype priors
  inputBinding:
    prefix: --population-callset
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: sample_ploidy
  type:
  - 'null'
  - int
  doc: 'Ploidy (number of chromosomes) per sample. For pooled data, set to (Number
    of samples in each pool * Sample Ploidy). Default value: 2.'
  inputBinding:
    prefix: --sample-ploidy
- id: standard_min_confidence_threshold_for_calling
  type:
  - 'null'
  - double
  doc: 'The minimum phred-scaled confidence threshold at which variants should be
    called Default value: 30.0.'
  inputBinding:
    prefix: --standard-min-confidence-threshold-for-calling
- id: use_new_qual_calculator
  type:
  - 'null'
  - boolean
  doc: 'This argument is DEPRECATED (New qual score is on by default). Use the new
    AF model instead of the so-called exact model Default value: true. Possible values:
    {true, false}'
  inputBinding:
    prefix: --use-new-qual-calculator
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: use_posteriors_to_calculate_qual
  type:
  - 'null'
  - boolean
  doc: 'if available, use the genotype posterior probabilities to calculate the site
    QUAL Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --use-posteriors-to-calculate-qual
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: add_site_filters_to_genotype
  type:
  - 'null'
  - boolean
  doc: 'Add site level filters to genotype level. Site level filters removed by default,
    if they should be kept, use --keep-site-filters Default value: false. Possible
    values: {true, false}'
  inputBinding:
    prefix: --add-site-filters-to-genotype
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: allow_missing_hom_ref_data
  type:
  - 'null'
  - boolean
  doc: 'Fill in homozygous reference genotypes with no PLs and no GQ with PL=[0,0,0].
    Necessary for input from Regeneron''s WeCall variant caller. Default value: false.
    Possible values: {true, false}'
  inputBinding:
    prefix: --allow-missing-hom-ref-data
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: annotations_to_keep
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --annotations-to-keep
  doc: Annotations that are not recognized by GATK to keep, that should be kept in
    final GVCF at variant sites. This argument may be specified 0 or more times.
- id: disable_tool_default_annotations
  type:
  - 'null'
  - boolean
  doc: 'Disable all tool default annotations Default value: false. Possible values:
    {true, false}'
  inputBinding:
    prefix: --disable-tool-default-annotations
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: do_qual_score_approximation
  type:
  - 'null'
  - boolean
  doc: 'Add necessary INFO field annotation to perform QUAL approximation downstream;
    required for GnarlyGenotyper Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --do-qual-score-approximation
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: dont_use_dragstr_priors
  type:
  - 'null'
  - boolean
  doc: 'Forfeit the use of the DRAGstr model to calculate genotype priors. This argument
    does not have any effect in the absence of DRAGstr model parameters (--dragstr-model-params)
    Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --dont-use-dragstr-priors
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: drop_low_quals
  type:
  - 'null'
  - boolean
  doc: 'Exclude variants and homRef blocks that are GQ0 from the reblocked GVCF to
    save space; drop low quality/uncalled alleles Default value: false. Possible values:
    {true, false}'
  inputBinding:
    prefix: --drop-low-quals
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: enable_all_annotations
  type:
  - 'null'
  - boolean
  doc: 'Use all possible annotations (not for the faint of heart) Default value: false.
    Possible values: {true, false}'
  inputBinding:
    prefix: --enable-all-annotations
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: floor_blocks
  type:
  - 'null'
  - boolean
  doc: 'Output the band lower bound for each GQ block regardless of the data it represents
    Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --floor-blocks
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: format_annotations_to_remove
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --format-annotations-to-remove
  doc: FORMAT level annotations to remove from all genotypes in final GVCF. This argument
    may be specified 0 or more times.
- id: gvcf_gq_bands
  type:
  - 'null'
  - type: array
    items: int
    inputBinding:
      prefix: --gvcf-gq-bands
  doc: 'Exclusive upper bounds for reference confidence GQ bands (must be in [1, 100]
    and specified in increasing order) This argument may be specified 0 or more times.
    Default value: [20, 100].'
- id: keep_all_alts
  type:
  - 'null'
  - boolean
  doc: 'Keep all ALT alleles and full PL array for most accurate GQs Default value:
    false. Possible values: {true, false}'
  inputBinding:
    prefix: --keep-all-alts
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: keep_site_filters
  type:
  - 'null'
  - boolean
  doc: 'Keep site level filters for variants (not ref blocks). Default value: false.
    Possible values: {true, false}'
  inputBinding:
    prefix: --keep-site-filters
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: max_alternate_alleles
  type:
  - 'null'
  - int
  doc: 'Maximum number of alternate alleles to genotype Default value: 6.'
  inputBinding:
    prefix: --max-alternate-alleles
- id: max_genotype_count
  type:
  - 'null'
  - int
  doc: 'Maximum number of genotypes to consider at any site Default value: 1024.'
  inputBinding:
    prefix: --max-genotype-count
- id: rgq_threshold_to_no_call
  type:
  - 'null'
  - double
  doc: 'Reference genotype quality (PL[0]) value below which variant sites will be
    converted to GQ0 homRef calls Default value: 0.0.'
  inputBinding:
    prefix: --rgq-threshold-to-no-call
- id: tree_score_threshold_to_no_call
  type:
  - 'null'
  - double
  doc: 'Tree score value below which variant sites will be converted to GQ0 homRef
    calls. Disabled when set to 0 (which is the default). Default value: 0.0.'
  inputBinding:
    prefix: --tree-score-threshold-to-no-call
- id: dirichlet_keep_prior_in_count
  type:
  - 'null'
  - boolean
  doc: 'By default we don''t keep the prior use in the output counts ase it makes
    it easier to interpretthis quantity as the number of supporting reads specially
    in low depth sites. We this toggled the prior is included Default value: false.
    Possible values: {true, false}'
  inputBinding:
    prefix: --dirichlet-keep-prior-in-count
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: dirichlet_prior_pseudo_count
  type:
  - 'null'
  - double
  doc: 'Pseudo-count used as prior for all alleles. The default is 1.0 resulting in
    a flat prior Default value: 1.0.'
  inputBinding:
    prefix: --dirichlet-prior-pseudo-count
- id: pseudo_count_weight_decay_rate
  type:
  - 'null'
  - double
  doc: 'A what rate the weight of a read decreases base on its informativeness; e.g.
    1.0 is linear decay (default), 2.0 is for quadratic decay Default value: 1.0.
    Valid only if "AssemblyComplexity" is specified:'
  inputBinding:
    prefix: --pseudo-count-weight-decay-rate
- id: assembly_complexity_reference_mode
  type:
  - 'null'
  - boolean
  doc: 'If enabled will treat the reference as the basis for assembly complexity as
    opposed to estimated germline haplotypes Default value: false. Possible values:
    {true, false} Valid only if "PossibleDeNovo" is specified:'
  inputBinding:
    prefix: --assembly-complexity-reference-mode
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: denovo_depth_threshold
  type:
  - 'null'
  - int
  doc: 'Minimum depth (DP) for all trio members to be considered for de novo calculation.
    Default value: 0.'
  inputBinding:
    prefix: --denovo-depth-threshold
- id: denovo_parent_gq_threshold
  type:
  - 'null'
  - int
  doc: 'Minimum genotype quality for parents to be considered for de novo calculation
    (separate from GQ thershold for full trio). Default value: 20. Valid only if "RMSMappingQuality"
    is specified:'
  inputBinding:
    prefix: --denovo-parent-gq-threshold
- id: allow_old_rms_mapping_quality_annotation_data
  type:
  - 'null'
  - boolean
  doc: 'Override to allow old RMSMappingQuality annotated VCFs to function Default
    value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --allow-old-rms-mapping-quality-annotation-data
    valueFrom: '$(self ? ''true'' : ''false'')'
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
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
