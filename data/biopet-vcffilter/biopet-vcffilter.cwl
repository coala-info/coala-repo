cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfFilter
label: biopet-vcffilter
doc: "A tool for filtering VCF files based on various criteria such as depth, genotypes,
  and trio relationships.\n\nTool homepage: https://github.com/biopet/vcffilter"
inputs:
  - id: advanced_groups
    type:
      - 'null'
      - string
    doc: All members of groups sprated with a ','
    inputBinding:
      position: 101
      prefix: --advancedGroups
  - id: called_in
    type:
      - 'null'
      - string
    doc: Must be called in this sample
    inputBinding:
      position: 101
      prefix: --calledIn
  - id: de_novo_in_sample
    type:
      - 'null'
      - string
    doc: Only show variants that contain unique alleles in complete set for given
      sample
    inputBinding:
      position: 101
      prefix: --deNovoInSample
  - id: de_novo_trio
    type:
      - 'null'
      - string
    doc: Only show variants that are denovo in the trio
    inputBinding:
      position: 101
      prefix: --deNovoTrio
  - id: diff_genotype
    type:
      - 'null'
      - string
    doc: Given samples must have a different genotype
    inputBinding:
      position: 101
      prefix: --diffGenotype
  - id: filter_het_var_to_hom_var
    type:
      - 'null'
      - string
    doc: If variants in sample 1 are heterogeneous and alternative alleles are homogeneous
      in sample 2 variants are filtered
    inputBinding:
      position: 101
      prefix: --filterHetVarToHomVar
  - id: filter_no_calls
    type:
      - 'null'
      - boolean
    doc: Filter when there are only no calls
    inputBinding:
      position: 101
      prefix: --filterNoCalls
  - id: filter_ref_calls
    type:
      - 'null'
      - boolean
    doc: Filter when there are only ref calls
    inputBinding:
      position: 101
      prefix: --filterRefCalls
  - id: id
    type:
      - 'null'
      - string
    doc: Id that may pass the filter
    inputBinding:
      position: 101
      prefix: --id
  - id: id_file
    type:
      - 'null'
      - File
    doc: File that contain list of IDs to get from vcf file
    inputBinding:
      position: 101
      prefix: --idFile
  - id: info_array_must_contain
    type:
      - 'null'
      - string
    doc: 'Info field must be a array and should match the given regex (format: key=value)'
    inputBinding:
      position: 101
      prefix: --infoArrayMustContain
  - id: input_vcf
    type: File
    doc: Input vcf file
    inputBinding:
      position: 101
      prefix: --inputVcf
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Level of log information printed. Possible levels: 'debug', 'info', 'warn',
      'error'"
    inputBinding:
      position: 101
      prefix: --log_level
  - id: min_alternate_depth
    type:
      - 'null'
      - int
    doc: Min value of AD field in genotype fields
    inputBinding:
      position: 101
      prefix: --minAlternateDepth
  - id: min_avg_variant_gq
    type:
      - 'null'
      - float
    doc: Filter on the average GQ of variants
    inputBinding:
      position: 101
      prefix: --minAvgVariantGQ
  - id: min_called
    type:
      - 'null'
      - int
    doc: Number of sample where a call must be made
    inputBinding:
      position: 101
      prefix: --minCalled
  - id: min_genome_quality
    type:
      - 'null'
      - float
    doc: The minimum value in the Genome Quality field.
    inputBinding:
      position: 101
      prefix: --minGenomeQuality
  - id: min_qual_score
    type:
      - 'null'
      - float
    doc: Min qual score
    inputBinding:
      position: 101
      prefix: --minQualScore
  - id: min_sample_depth
    type:
      - 'null'
      - int
    doc: Min value for DP in genotype fields
    inputBinding:
      position: 101
      prefix: --minSampleDepth
  - id: min_samples_pass
    type:
      - 'null'
      - int
    doc: Min number off samples to pass --minAlternateDepth, --minBamAlternateDepth
      and --minSampleDepth
    inputBinding:
      position: 101
      prefix: --minSamplesPass
  - id: min_total_depth
    type:
      - 'null'
      - int
    doc: Min value of DP field in INFO fields
    inputBinding:
      position: 101
      prefix: --minTotalDepth
  - id: must_have_genotype
    type:
      - 'null'
      - string
    doc: Must have genotoype <genotype> for this sample. Genotype can be NO_CALL,
      HOM_REF, HET, HOM_VAR, UNAVAILABLE, MIXED
    inputBinding:
      position: 101
      prefix: --mustHaveGenotype
  - id: must_have_variant
    type:
      - 'null'
      - string
    doc: Given sample must have 1 alternative allele
    inputBinding:
      position: 101
      prefix: --mustHaveVariant
  - id: must_not_have_variant
    type:
      - 'null'
      - string
    doc: Given sample may not have alternative alleles
    inputBinding:
      position: 101
      prefix: --mustNotHaveVariant
  - id: res_to_dom
    type:
      - 'null'
      - string
    doc: Only shows variants where child is homozygous and both parants hetrozygous
    inputBinding:
      position: 101
      prefix: --resToDom
  - id: shared_only
    type:
      - 'null'
      - boolean
    doc: Filter when not all samples have this variant
    inputBinding:
      position: 101
      prefix: --sharedOnly
  - id: trio_compound
    type:
      - 'null'
      - string
    doc: Only shows variants where child is a compound variant combined from both
      parants
    inputBinding:
      position: 101
      prefix: --trioCompound
  - id: trio_loss_of_het
    type:
      - 'null'
      - string
    doc: Only show variants where a loss of hetrozygosity is detected
    inputBinding:
      position: 101
      prefix: --trioLossOfHet
  - id: unique_only
    type:
      - 'null'
      - boolean
    doc: Filter when there more then 1 sample have this variant
    inputBinding:
      position: 101
      prefix: --uniqueOnly
outputs:
  - id: output_vcf
    type: File
    doc: Output vcf file
    outputBinding:
      glob: $(inputs.output_vcf)
  - id: inverted_output_vcf
    type:
      - 'null'
      - File
    doc: inverted output vcf file
    outputBinding:
      glob: $(inputs.inverted_output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-vcffilter:0.2--0
