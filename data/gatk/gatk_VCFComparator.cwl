cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- VCFComparator
label: gatk_VCFComparator
doc: |-
  Compare two VCFs, as for pipeline test updates

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: expected_variant
  type: File
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
  doc: The expected VCF (passed as --variant:expected; the tool needs exactly one
    expected and one actual VCF, marked with these GATK tags)
  inputBinding:
    prefix: --variant:expected
- id: actual_variant
  type: File
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
  doc: The actual VCF to compare with the expected one (passed as --variant:actual)
  inputBinding:
    prefix: --variant:actual
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
- id: allow_extra_alleles
  type:
  - 'null'
  - boolean
  doc: 'Allow extra alleles in actual provided actual is a superset of expected Default
    value: false. Possible values: {true, false} Cannot be used in conjunction with
    argument(s) allowNewStars positionsOnly'
  inputBinding:
    prefix: --allow-extra-alleles
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: allow_missing_stars
  type:
  - 'null'
  - boolean
  doc: 'Allow missing * in actual if actual has no corresponding deletions Default
    value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --allow-missing-stars
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: allow_nan_mismatch
  type:
  - 'null'
  - boolean
  doc: 'Allow VCF values of missing (.) and NaN to match Default value: false. Possible
    values: {true, false}'
  inputBinding:
    prefix: --allow-nan-mismatch
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: allow_new_stars
  type:
  - 'null'
  - boolean
  doc: 'Allow additional * alleles in actual if there is a corresponding deletion
    Default value: false. Possible values: {true, false} Cannot be used in conjunction
    with argument(s) positionsOnly allowExtraAlleles'
  inputBinding:
    prefix: --allow-new-stars
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
- id: default_ploidy
  type:
  - 'null'
  - int
  doc: 'Overall expected ploidy. Default value is 2. Default value: 2.'
  inputBinding:
    prefix: --default-ploidy
- id: dp_change_allowed
  type:
  - 'null'
  - int
  doc: 'Note that this is a signed change (actual - expected) Default value: 0. Cannot
    be used in conjunction with argument(s) positionsOnly'
  inputBinding:
    prefix: --dp-change-allowed
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
- id: finish_before_failing
  type:
  - 'null'
  - boolean
  doc: 'emit warnings as necesarry, but perform the whole comparison before failing
    Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --finish-before-failing
    valueFrom: '$(self ? ''true'' : ''false'')'
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
- id: good_qual_threshold
  type:
  - 'null'
  - double
  doc: 'Variants with QUAL at or above this value are considered high quality and
    should appear in both files Default value: 100.0.'
  inputBinding:
    prefix: --good-qual-threshold
- id: ignore_annotations
  type:
  - 'null'
  - boolean
  doc: 'Only match on position and alleles, ignoring all INFO annotations Default
    value: false. Possible values: {true, false} Cannot be used in conjunction with
    argument(s) positionsOnly'
  inputBinding:
    prefix: --ignore-annotations
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: ignore_attribute
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --ignore-attribute
  doc: Ignore INFO attributes with this key This argument may be specified 0 or more
    times. Cannot be used in conjunction with argument(s) positionsOnly
- id: ignore_dbsnp_ids
  type:
  - 'null'
  - boolean
  doc: 'Undocumented option Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --ignore-dbsnp-ids
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: ignore_filters
  type:
  - 'null'
  - boolean
  doc: 'Ignore filter status when comparing variants Default value: false. Possible
    values: {true, false} Cannot be used in conjunction with argument(s) positionsOnly'
  inputBinding:
    prefix: --ignore-filters
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: ignore_genotype_annotations
  type:
  - 'null'
  - boolean
  doc: 'Only match on genotype call, ignoring all FORMAT annotations Default value:
    false. Possible values: {true, false} Cannot be used in conjunction with argument(s)
    positionsOnly'
  inputBinding:
    prefix: --ignore-genotype-annotations
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: ignore_genotype_phasing
  type:
  - 'null'
  - boolean
  doc: 'Only check called genotype alleles, not order or phasing status Default value:
    false. Possible values: {true, false}'
  inputBinding:
    prefix: --ignore-genotype-phasing
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: ignore_gq0
  type:
  - 'null'
  - boolean
  doc: 'Undocumented option Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --ignore-gq0
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: ignore_hom_ref_attributes
  type:
  - 'null'
  - boolean
  doc: 'Skip attribute comparison for homozygous reference genotypes Default value:
    false. Possible values: {true, false}'
  inputBinding:
    prefix: --ignore-hom-ref-attributes
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: ignore_non_ref_data
  type:
  - 'null'
  - boolean
  doc: 'Undocumented option Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --ignore-non-ref-data
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: ignore_quals
  type:
  - 'null'
  - boolean
  doc: 'Undocumented option Default value: false. Possible values: {true, false} Cannot
    be used in conjunction with argument(s) positionsOnly'
  inputBinding:
    prefix: --ignore-quals
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: ignore_some_multi_allelics
  type:
  - 'null'
  - boolean
  doc: 'Ignore sites where the AC length in the actual matches the actual number of
    alleles, but doesn''t match the expected VC. Default value: false. Possible values:
    {true, false}'
  inputBinding:
    prefix: --ignore-some-multi-allelics
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: ignore_star_attributes
  type:
  - 'null'
  - boolean
  doc: 'Ignore annotation values for spanning deletion (*) alleles Default value:
    false. Possible values: {true, false}'
  inputBinding:
    prefix: --ignore-star-attributes
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: inbreeding_coeff_change_allowed
  type:
  - 'null'
  - double
  doc: 'Undocumented option Default value: 0.001.'
  inputBinding:
    prefix: --inbreeding-coeff-change-allowed
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
- id: likelihood_change_allowed
  type:
  - 'null'
  - int
  doc: 'Undocumented option Default value: 0.'
  inputBinding:
    prefix: --likelihood-change-allowed
- id: mute_acceptable_diffs
  type:
  - 'null'
  - boolean
  doc: 'Suppress warnings or exceptions for differences that are consequences of low
    quality genotypes or AN discrepancies Default value: false. Possible values: {true,
    false}'
  inputBinding:
    prefix: --mute-acceptable-diffs
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: pedigree
  type:
  - 'null'
  - File
  doc: Pedigree file for determining the population "founders"
  inputBinding:
    prefix: --pedigree
- id: positions_only
  type:
  - 'null'
  - boolean
  doc: 'Only match on position, ignoring alleles and annotations Default value: false.
    Possible values: {true, false} Cannot be used in conjunction with argument(s)
    ignoreQuals dpChange ignoreAnnotations ignoreGenotypeAnnotations ignoreFilters
    ignoreAttributes allowNewStars allowExtraAlleles'
  inputBinding:
    prefix: --positions-only
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: qual_change_allowed
  type:
  - 'null'
  - double
  doc: 'Undocumented option Default value: 0.001.'
  inputBinding:
    prefix: --qual-change-allowed
- id: ranksum_change_allowed
  type:
  - 'null'
  - double
  doc: 'Amount of numerical ''noise'' allowed in rank sum annotations Default value:
    0.0.'
  inputBinding:
    prefix: --ranksum-change-allowed
- id: warn_on_errors
  type:
  - 'null'
  - boolean
  doc: 'just emit warnings on errors instead of terminating the run at the first instance.
    Won''t fail unless --finish-before-failing is set Default value: false. Possible
    values: {true, false}'
  inputBinding:
    prefix: --warn-on-errors
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: annotations_to_keep
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --annotations-to-keep
  doc: Annotations that are not recognized by GATK that should be checked, otherwise
    they are removed if ignore-non-ref-data is set. This argument may be specified
    0 or more times.
- id: combine_variants_distance
  type:
  - 'null'
  - int
  doc: 'Maximum distance for variants to be grouped together Default value: 10000.'
  inputBinding:
    prefix: --combine-variants-distance
- id: disable_tool_default_annotations
  type:
  - 'null'
  - boolean
  doc: 'Disable all tool default annotations Default value: false. Possible values:
    {true, false}'
  inputBinding:
    prefix: --disable-tool-default-annotations
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
- id: ignore_reference_blocks
  type:
  - 'null'
  - boolean
  doc: 'Undocumented option Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --ignore-reference-blocks
    valueFrom: '$(self ? ''true'' : ''false'')'
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
outputs: []
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
