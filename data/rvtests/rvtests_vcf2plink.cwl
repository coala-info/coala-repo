cwlVersion: v1.2
class: CommandLineTool
baseCommand: [vcf2plink]
label: rvtests_vcf2plink
doc: "Convert a VCF file to PLINK binary files (.bed/.bim/.fam), with site, people, quality and frequency filters.\n\nTool homepage: https://github.com/zhanxw/rvtests"
inputs:
  - id: anno_type
    type:
      - 'null'
      - string
    doc: "Specify the type of annotation to extract"
    inputBinding:
      position: 101
      prefix: --annoType
  - id: biallelic
    type:
      - 'null'
      - boolean
    doc: "Specify only include bi-allelic SNP sites"
    inputBinding:
      position: 101
      prefix: --biallelic
  - id: gene
    type:
      - 'null'
      - string
    doc: "Specify the gene names to extract"
    inputBinding:
      position: 101
      prefix: --gene
  - id: gene_file
    type:
      - 'null'
      - File
    doc: "Specify the gene file (refFlat format), so we know gene start and end."
    inputBinding:
      position: 101
      prefix: --geneFile
  - id: in_vcf
    type: File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: "Input VCF file (plain, bgzip, or BCF). Range filters need a tabix index (.tbi) beside it."
    inputBinding:
      position: 101
      prefix: --inVcf
  - id: make_bed
    type:
      - 'null'
      - string
    doc: "Output prefix of the PLINK binary files (<prefix>.bed/.bim/.fam)"
    inputBinding:
      position: 101
      prefix: --make-bed
  - id: max_maf
    type:
      - 'null'
      - double
    doc: "Specify maximum accepted minor allele frequency"
    inputBinding:
      position: 101
      prefix: --maxMAF
  - id: min_call_rate
    type:
      - 'null'
      - double
    doc: "Specify minimum call rate threshold"
    inputBinding:
      position: 101
      prefix: --minCallRate
  - id: min_gd
    type:
      - 'null'
      - double
    doc: "Specify the minimum genotype depth, otherwise marked as missing genotype"
    inputBinding:
      position: 101
      prefix: --minGD
  - id: min_gq
    type:
      - 'null'
      - double
    doc: "Specify the minimum genotype quality, otherwise marked as missing genotype"
    inputBinding:
      position: 101
      prefix: --minGQ
  - id: min_hwe
    type:
      - 'null'
      - double
    doc: "Specify minimum accepted HWE p-value"
    inputBinding:
      position: 101
      prefix: --minHWE
  - id: min_maf
    type:
      - 'null'
      - double
    doc: "Specify minimum accepted minor allele frequency"
    inputBinding:
      position: 101
      prefix: --minMAF
  - id: min_site_qual
    type:
      - 'null'
      - double
    doc: "Specify minimum site qual"
    inputBinding:
      position: 101
      prefix: --minSiteQual
  - id: out_vcf
    type:
      - 'null'
      - string
    doc: "Output VCF file name (filtered VCF, written as given)"
    inputBinding:
      position: 101
      prefix: --outVcf
  - id: pass
    type:
      - 'null'
      - boolean
    doc: "Only output variants that pass filters"
    inputBinding:
      position: 101
      prefix: --pass
  - id: people_exclude_file
    type:
      - 'null'
      - File
    doc: "From given file, set IDs of people that will be excluded from study"
    inputBinding:
      position: 101
      prefix: --peopleExcludeFile
  - id: people_exclude_id
    type:
      - 'null'
      - type: array
        items: string
    doc: "Give IDs of people that will be excluded from study (comma separated)"
    inputBinding:
      position: 101
      itemSeparator: ','
      prefix: --peopleExcludeID
  - id: people_include_file
    type:
      - 'null'
      - File
    doc: "From given file, set IDs of people that will be included in study"
    inputBinding:
      position: 101
      prefix: --peopleIncludeFile
  - id: people_include_id
    type:
      - 'null'
      - type: array
        items: string
    doc: "Give IDs of people that will be included in study (comma separated)"
    inputBinding:
      position: 101
      itemSeparator: ','
      prefix: --peopleIncludeID
  - id: plink_chrom
    type:
      - 'null'
      - boolean
    doc: "Specify only include chromosome 1-22, X, Y, MT as PLINK required"
    inputBinding:
      position: 101
      prefix: --plinkChrom
  - id: range_file
    type:
      - 'null'
      - File
    doc: "Specify the file containing ranges, please use chr:begin-end format."
    inputBinding:
      position: 101
      prefix: --rangeFile
  - id: range_list
    type:
      - 'null'
      - type: array
        items: string
    doc: "Specify some ranges to use, please use chr:begin-end format."
    inputBinding:
      position: 101
      itemSeparator: ','
      prefix: --rangeList
  - id: site_file
    type:
      - 'null'
      - File
    doc: "Specify the file containing site to extract, please use chr:pos format."
    inputBinding:
      position: 101
      prefix: --siteFile
  - id: update_id
    type:
      - 'null'
      - File
    doc: "Update VCF sample id using given file (column 1 and 2 are old and new id)."
    inputBinding:
      position: 101
      prefix: --update-id
  - id: variant_only
    type:
      - 'null'
      - boolean
    doc: "Only variant sites from the VCF file will be processed."
    inputBinding:
      position: 101
      prefix: --variantOnly
outputs:
  - id: bed
    type: File?
    doc: "PLINK genotype file"
    outputBinding:
      glob: "$(inputs.make_bed).bed"
  - id: bim
    type: File?
    doc: "PLINK variant file"
    outputBinding:
      glob: "$(inputs.make_bed).bim"
  - id: fam
    type: File?
    doc: "PLINK sample file"
    outputBinding:
      glob: "$(inputs.make_bed).fam"
  - id: filtered_vcf
    type: File?
    doc: "Filtered VCF file (only with --outVcf)"
    outputBinding:
      glob: "$(inputs.out_vcf)"
  - id: conversion_log
    type: stdout
    doc: "Conversion summary printed by the tool"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
stdout: $(inputs.in_vcf.basename).vcf2plink.out
