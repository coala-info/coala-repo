cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- VariantAnnotator
label: gatk_VariantAnnotator
doc: |-
  Tool for adding annotations to VCF files

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: output
  type: string
  doc: The file to which variants should be written
  inputBinding:
    position: 1
    prefix: --output
- id: variant
  type: File
  doc: A VCF file containing variants
  inputBinding:
    position: 1
    prefix: --variant
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
- id: annotation
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --annotation
  doc: 'One or more specific annotations to add to variant calls Possible values:
    AlleleFraction, AllelePseudoDepth, AS_BaseQualityRankSumTest, AS_FisherStrand,
    AS_InbreedingCoeff, AS_MappingQualityRankSumTest, AS_QualByDepth, AS_ReadPosRankSumTest,
    AS_RMSMappingQuality, AS_StrandBiasMutectAnnotation, AS_StrandOddsRatio, AssemblyComplexity,
    BaseQuality, BaseQualityHistogram, BaseQualityRankSumTest, ChromosomeCounts, ClippingRankSumTest,
    CountNs, Coverage, CycleSkipStatus, DepthPerAlleleBySample, DepthPerSampleHC,
    ExcessHet, FisherStrand, FragmentDepthPerAlleleBySample, FragmentLength, GcContent,
    GenotypeSummaries, HaplotypeFilteringAnnotation, HmerIndelLength, HmerIndelNuc,
    HmerMotifs, InbreedingCoeff, IndelClassify, IndelLength, LikelihoodRankSumTest,
    MappingQuality, MappingQualityRankSumTest, MappingQualityZero, OrientationBiasReadCounts,
    OriginalAlignment, PossibleDeNovo, QualByDepth, RawGtCount, ReadPosition, ReadPosRankSumTest,
    ReferenceBases, RMSMappingQuality, SampleList, StrandBiasBySample, StrandOddsRatio,
    TandemRepeat, TransmittedSingleton, UniqueAltReadCount, VariantType.'
  inputBinding:
    position: 1
- id: annotation_group
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --annotation-group
  doc: 'One or more groups of annotations to apply to variant calls Possible values:
    AlleleSpecificAnnotation, AS_StandardAnnotation, GenotypeAnnotation, InfoFieldAnnotation,
    JumboGenotypeAnnotation, JumboInfoAnnotation, ReducibleAnnotation, StandardAnnotation,
    StandardFlowBasedAnnotation, StandardHCAnnotation, StandardMutectAnnotation, VariantAnnotation.'
  inputBinding:
    position: 1
- id: annotations_to_exclude
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --annotations-to-exclude
  doc: One or more specific annotations to exclude from variant calls
  inputBinding:
    position: 1
- id: dbsnp
  type:
  - 'null'
  - File
  doc: dbSNP file
  inputBinding:
    position: 1
    prefix: --dbsnp
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
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
  doc: One or more genomic intervals to exclude from processing
  inputBinding:
    position: 1
- id: expression
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --expression
  doc: One or more specific expressions to apply to variant calls
  inputBinding:
    position: 1
- id: flow_order_for_annotations
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --flow-order-for-annotations
  doc: flow order used for this annotations. [readGroup:]flowOrder
  inputBinding:
    position: 1
- id: founder_id
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --founder-id
  doc: Samples representing the population "founders"
  inputBinding:
    position: 1
- id: input
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --input
  doc: BAM/SAM/CRAM file containing reads
  inputBinding:
    position: 1
- id: intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --intervals
  doc: One or more genomic intervals over which to operate
  inputBinding:
    position: 1
- id: min_base_quality_score
  type:
  - 'null'
  - int
  doc: Minimum base quality required to confidently assign a read to an allele
  inputBinding:
    position: 1
    prefix: --min-base-quality-score
- id: pedigree
  type:
  - 'null'
  - File
  doc: Pedigree file for determining the population "founders"
  inputBinding:
    position: 1
    prefix: --pedigree
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence
  inputBinding:
    position: 1
    prefix: --reference
  secondaryFiles:
  - .fai
  - ^.dict
- id: resource
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --resource
  doc: External resource VCF file
  inputBinding:
    position: 1
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
- id: resource_allele_concordance
  type:
  - 'null'
  - boolean
  doc: 'Check for allele concordances when using an external resource VCF file Possible
    values: true, false.'
  inputBinding:
    position: 1
    prefix: --resource-allele-concordance
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: sequence_dictionary
  type:
  - 'null'
  - File
  doc: Use the given sequence dictionary as the master/canonical sequence dictionary.
    Must be a .dict file.
  inputBinding:
    position: 1
    prefix: --sequence-dictionary
- id: comparison
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --comparison
  doc: Comparison VCF file(s)
  inputBinding:
    position: 1
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
- id: disable_tool_default_annotations
  type:
  - 'null'
  - boolean
  doc: 'Disable all tool default annotations Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --disable-tool-default-annotations
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: enable_all_annotations
  type:
  - 'null'
  - boolean
  doc: 'Use all possible annotations (not for the faint of heart) Possible values:
    true, false.'
  inputBinding:
    position: 1
    prefix: --enable-all-annotations
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: variant_output_filtering
  type:
  - 'null'
  - string
  doc: Restrict the output variants to ones that match the specified intervals according
    to the specified matching mode.
  inputBinding:
    position: 1
    prefix: --variant-output-filtering
outputs:
- id: output_file
  type: File
  doc: The file to which variants should be written
  outputBinding:
    glob: $(inputs.output)
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
