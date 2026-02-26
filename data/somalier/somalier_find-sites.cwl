cwlVersion: v1.2
class: CommandLineTool
baseCommand: somalier_find-sites
label: somalier_find-sites
doc: "Finds sites from a VCF file based on various criteria.\n\nTool homepage: https://github.com/brentp/somalier"
inputs:
  - id: vcf
    type: File
    doc: population VCF to use to find sites
    inputBinding:
      position: 1
  - id: af_field
    type:
      - 'null'
      - string
    doc: info field in the vcf that contains the allele frequency
    default: AF
    inputBinding:
      position: 102
      prefix: --AF-field
  - id: an_field
    type:
      - 'null'
      - string
    doc: info field in the vcf that contains the allele number
    default: AN
    inputBinding:
      position: 102
      prefix: --AN-field
  - id: exclude
    type:
      - 'null'
      - type: array
        items: File
    doc: optional exclude files
    inputBinding:
      position: 102
      prefix: --exclude
  - id: gnotate_exclude
    type:
      - 'null'
      - string
    doc: sites in slivar gnotation (zip) format to exclude
    inputBinding:
      position: 102
      prefix: --gnotate-exclude
  - id: include
    type:
      - 'null'
      - File
    doc: optional include file. only consider variants that fall in ranges 
      within this file
    inputBinding:
      position: 102
      prefix: --include
  - id: min_af
    type:
      - 'null'
      - float
    doc: minimum allele frequency for a site
    default: 0.15
    inputBinding:
      position: 102
      prefix: --min-AF
  - id: min_an
    type:
      - 'null'
      - int
    doc: minimum number of alleles (AN) at the site. (must be less than twice 
      number of samples in the cohort)
    default: 115000
    inputBinding:
      position: 102
      prefix: --min-AN
  - id: snp_dist
    type:
      - 'null'
      - int
    doc: minimum distance between autosomal SNPs to avoid linkage
    default: 10000
    inputBinding:
      position: 102
      prefix: --snp-dist
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: path to output vcf containing sites
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/somalier:0.3.1--hc78c8e0_0
