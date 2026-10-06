cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - VcfFilter
label: biopet_tool_VcfFilter
doc: "Filter VCF records on depth, quality, genotype and family (trio) rules.\n\nTool homepage:\
  \ https://github.com/biopet/biopet"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_vcf
    type: File
    doc: Input vcf file
    secondaryFiles:
      - pattern: .tbi
        required: false
    inputBinding:
      position: 101
      prefix: --inputVcf
  - id: output_vcf
    type: string
    doc: Output vcf file
    inputBinding:
      position: 101
      prefix: --outputVcf
  - id: inverted_output_vcf
    type:
      - 'null'
      - string
    doc: inverted output vcf file
    inputBinding:
      position: 101
      prefix: --invertedOutputVcf
  - id: min_sample_depth
    type:
      - 'null'
      - int
    doc: Min value for DP in genotype fields
    inputBinding:
      position: 101
      prefix: --minSampleDepth
  - id: min_total_depth
    type:
      - 'null'
      - int
    doc: Min value of DP field in INFO fields
    inputBinding:
      position: 101
      prefix: --minTotalDepth
  - id: min_alternate_depth
    type:
      - 'null'
      - int
    doc: Min value of AD field in genotype fields
    inputBinding:
      position: 101
      prefix: --minAlternateDepth
  - id: min_samples_pass
    type:
      - 'null'
      - int
    doc: Min number off samples to pass --minAlternateDepth, --minBamAlternateDepth and --minSampleDepth
    inputBinding:
      position: 101
      prefix: --minSamplesPass
  - id: res_to_dom
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --resToDom
    doc: Only shows variants where child is homozygous and both parants hetrozygous (child:father:mother)
    inputBinding:
      position: 101
  - id: trio_compound
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --trioCompound
    doc: Only shows variants where child is a compound variant combined from both parants
      (child:father:mother)
    inputBinding:
      position: 101
  - id: de_novo_in_sample
    type:
      - 'null'
      - string
    doc: Only show variants that contain unique alleles in complete set for given sample
    inputBinding:
      position: 101
      prefix: --deNovoInSample
  - id: de_novo_trio
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --deNovoTrio
    doc: Only show variants that are denovo in the trio (child:father:mother)
    inputBinding:
      position: 101
  - id: trio_loss_of_het
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --trioLossOfHet
    doc: Only show variants where a loss of hetrozygosity is detected (child:father:mother)
    inputBinding:
      position: 101
  - id: must_have_variant
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --mustHaveVariant
    doc: Given sample must have 1 alternative allele
    inputBinding:
      position: 101
  - id: called_in
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --calledIn
    doc: Must be called in this sample
    inputBinding:
      position: 101
  - id: must_have_genotype
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --mustHaveGenotype
    doc: Must have genotoype <genotype> for this sample (sample:genotype). Genotype can be
      NO_CALL, HOM_REF, HET, HOM_VAR, UNAVAILABLE, MIXED
    inputBinding:
      position: 101
  - id: diff_genotype
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --diffGenotype
    doc: Given samples must have a different genotype (sample:sample)
    inputBinding:
      position: 101
  - id: filter_het_var_to_hom_var
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --filterHetVarToHomVar
    doc: Filter variants heterozygous in sample 1 and homozygous alternative in sample 2 (sample:sample)
    inputBinding:
      position: 101
  - id: filter_ref_calls
    type:
      - 'null'
      - boolean
    doc: Filter when there are only ref calls
    inputBinding:
      position: 101
      prefix: --filterRefCalls
  - id: filter_no_calls
    type:
      - 'null'
      - boolean
    doc: Filter when there are only no calls
    inputBinding:
      position: 101
      prefix: --filterNoCalls
  - id: unique_only
    type:
      - 'null'
      - boolean
    doc: Filter when there more then 1 sample have this variant
    inputBinding:
      position: 101
      prefix: --uniqueOnly
  - id: shared_only
    type:
      - 'null'
      - boolean
    doc: Filter when not all samples have this variant
    inputBinding:
      position: 101
      prefix: --sharedOnly
  - id: min_qual_score
    type:
      - 'null'
      - double
    doc: Min qual score
    inputBinding:
      position: 101
      prefix: --minQualScore
  - id: id
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --id
    doc: Id that may pass the filter
    inputBinding:
      position: 101
  - id: id_file
    type:
      - 'null'
      - File
    doc: File that contain list of IDs to get from vcf file
    inputBinding:
      position: 101
      prefix: --idFile
  - id: min_genome_quality
    type:
      - 'null'
      - int
    doc: Min genome quality (GQ) in genotype fields
    inputBinding:
      position: 101
      prefix: --minGenomeQuality
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Level of log information printed. Possible levels: ''debug'', ''info'', ''warn'',
      ''error'''
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: filtered_vcf
    type: File
    doc: Filtered VCF file
    outputBinding:
      glob: $(inputs.output_vcf)
  - id: inverted_vcf
    type:
      - 'null'
      - File
    doc: Inverted output VCF file
    outputBinding:
      glob: '$(inputs.inverted_output_vcf ? inputs.inverted_output_vcf : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
