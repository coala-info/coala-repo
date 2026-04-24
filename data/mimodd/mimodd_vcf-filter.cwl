cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf-filter
label: mimodd_vcf-filter
doc: "Filters VCF files based on various criteria.\n\nTool homepage: http://sourceforge.net/projects/mimodd"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: a vcf input file
    inputBinding:
      position: 1
  - id: allele_fraction_filters
    type:
      - 'null'
      - type: array
        items: string
    doc: the fraction of reads supporting a specific ALLELE# must be between 
      MIN_FRACTION and MAX_FRACTION to include the site in the output
    inputBinding:
      position: 102
      prefix: --af
  - id: dp_thresholds
    type:
      - 'null'
      - type: array
        items: int
    doc: minimal coverage (one per sample, use 0 to skip the requirement for a 
      given sample) required to include a site in the output
    inputBinding:
      position: 102
      prefix: --dp
  - id: gq_thresholds
    type:
      - 'null'
      - type: array
        items: int
    doc: minimal genotype quality (one per sample, use 0 to skip the requirement
      for a given sample) required to include a site in the output
    inputBinding:
      position: 102
      prefix: --gq
  - id: gt_patterns
    type:
      - 'null'
      - type: array
        items: string
    doc: 'genotype patterns (one per sample, use ANY to skip the requirement for a
      given sample) to be included in the output; format: x/x where x = 0 and x =
      1 stand for the reference and the variant allele, respectively; multiple allowed
      genotypes for a sample can be specified as a comma-separated list'
    inputBinding:
      position: 102
      prefix: --gt
  - id: indels_only
    type:
      - 'null'
      - boolean
    doc: keep only indels in the output
    inputBinding:
      position: 102
      prefix: --indels-only
  - id: no_indels
    type:
      - 'null'
      - boolean
    doc: skip indels in the output
    inputBinding:
      position: 102
      prefix: --no-indels
  - id: region_filters
    type:
      - 'null'
      - type: array
        items: string
    doc: 'keep only variants that fall in one of the given chromosomal regions (specified
      in the format CHROM:START-STOP or CHROM: for a whole chromosome)'
    inputBinding:
      position: 102
      prefix: --region
  - id: sample_names
    type:
      - 'null'
      - type: array
        items: string
    doc: one or more sample names that the sample-specific filters --gt, --dp, 
      and --gq should work on.
    inputBinding:
      position: 102
      prefix: --samples
  - id: vfilter
    type:
      - 'null'
      - type: array
        items: string
    doc: vertical sample names filter; if given, only sample columns specified 
      by name will be retained in the output
    inputBinding:
      position: 102
      prefix: --vfilter
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: redirect the output to the specified file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimodd:0.1.9--py35_0
