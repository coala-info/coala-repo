cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvkit.py
  - call
label: cnvkit_call
doc: "Call copy number variants from segmented log2 ratios.\n\nTool homepage: https://github.com/etal/cnvkit"
inputs:
  - id: filename
    type: File
    doc: "Copy ratios (.cnr or .cns)."
    inputBinding:
      position: 1
  - id: center
    type:
      - 'null'
      - string
    doc: "Re-center the log2 ratio values using this estimator of the center or average value. ('median' if no argument given.) (choices: mean, median, mode, biweight)"
    inputBinding:
      position: 101
      prefix: --center
  - id: center_at
    type:
      - 'null'
      - float
    doc: "Subtract a constant number from all log2 ratios. For \"manual\" re-centering, in case the --center option gives unsatisfactory results.)"
    inputBinding:
      position: 101
      prefix: --center-at
  - id: filters
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --filter
    doc: "Merge segments flagged by the specified filter(s) with the adjacent segment(s). (choices: ampdel, cn, ci, sem)"
    inputBinding:
      position: 101
  - id: method
    type:
      - 'null'
      - string
    doc: "Calling method. [Default: threshold] (choices: threshold, clonal, none)"
    inputBinding:
      position: 101
      prefix: --method
  - id: thresholds
    type:
      - 'null'
      - string
    doc: "Hard thresholds for calling each integer copy number, separated by commas. Use the '=' sign on the command line, e.g.: -t=-1,0,1 [Default: -1.1,-0.25,0.2,0.7]"
    inputBinding:
      position: 101
      prefix: --thresholds
  - id: ploidy
    type:
      - 'null'
      - int
    doc: "Ploidy of the sample cells. [Default: %(default)d]"
    inputBinding:
      position: 101
      prefix: --ploidy
  - id: purity
    type:
      - 'null'
      - float
    doc: "Estimated tumor cell fraction, a.k.a. purity or cellularity."
    inputBinding:
      position: 101
      prefix: --purity
  - id: drop_low_coverage
    type:
      - 'null'
      - boolean
    doc: "Drop very-low-coverage bins before segmentation to avoid false-positive deletions in poor-quality tumor samples."
    inputBinding:
      position: 101
      prefix: --drop-low-coverage
  - id: sample_sex
    type:
      - 'null'
      - string
    doc: "Specify the sample's chromosomal sex as male or female. (Otherwise guessed from X and Y coverage). (choices: m, y, male, Male, f, x, female, Female)"
    inputBinding:
      position: 101
      prefix: --sample-sex
  - id: male_reference
    type:
      - 'null'
      - boolean
    doc: "Was a male reference used? If so, expect half ploidy on chrX and chrY; otherwise, only chrY has half ploidy. In CNVkit, if a male reference was used, the \"neutral\" copy number (ploidy) of chrX is 1; chrY is haploid for either reference sex."
    inputBinding:
      position: 101
      prefix: --male-reference
  - id: output
    type: string
    doc: "Output table file name (CNR-like table of segments, .cns)."
    inputBinding:
      position: 101
      prefix: --output
  - id: vcf
    type:
      - 'null'
      - File
    doc: "VCF file name containing variants for calculation of b-allele frequencies."
    inputBinding:
      position: 101
      prefix: --vcf
  - id: sample_id
    type:
      - 'null'
      - string
    doc: "Name of the sample in the VCF (-v/--vcf) to use for b-allele frequency extraction."
    inputBinding:
      position: 101
      prefix: --sample-id
  - id: normal_id
    type:
      - 'null'
      - string
    doc: "Corresponding normal sample ID in the input VCF (-v/--vcf). This sample is used to select only germline SNVs to calculate b-allele frequencies."
    inputBinding:
      position: 101
      prefix: --normal-id
  - id: min_variant_depth
    type:
      - 'null'
      - int
    doc: "Minimum read depth for a SNV to be used in the b-allele frequency calculation. [Default: 20]"
    inputBinding:
      position: 101
      prefix: --min-variant-depth
  - id: zygosity_freq
    type:
      - 'null'
      - float
    doc: "Ignore VCF's genotypes (GT field) and instead infer zygosity from allele frequencies. [Default if used without a number: %(const)s]"
    inputBinding:
      position: 101
      prefix: --zygosity-freq
  - id: diploid_parx_genome
    type:
      - 'null'
      - string
    doc: "Considers the given human genome's PAR of chromosome X as autosomal. Example: 'grch38'"
    inputBinding:
      position: 101
      prefix: --diploid-parx-genome
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: "Output table file name (CNR-like table of segments, .cns)."
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1
