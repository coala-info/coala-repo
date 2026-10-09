cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hatchet
  - count-alleles
label: hatchet_count_alleles
doc: "Count the A/B alleles from a matched-normal BAM file and multiple tumor BAM files in specified SNP positions or estimated heterozygous SNPs in the normal genome (WGS or WES).

Tool homepage: https://github.com/raphael-group/hatchet"
inputs:
  - id: normal
    type: File
    secondaryFiles:
      - '.bai'
    doc: BAM file corresponding to matched normal sample
    inputBinding:
      position: 10
      prefix: -N
  - id: tumors
    type:
      type: array
      items: File
    secondaryFiles:
      - '.bai'
    doc: BAM files corresponding to samples from the same tumor
    inputBinding:
      position: 10
      prefix: -T
  - id: reference
    type: File
    secondaryFiles:
      - '.fai'
      - '^.dict'
    doc: Human reference genome of BAMs
    inputBinding:
      position: 10
      prefix: -r
  - id: snps
    type:
      type: array
      items: File
    doc: List of SNPs to consider in the normal sample
    inputBinding:
      position: 10
      prefix: -L
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: Sample names for each BAM (given in the same order where the normal name is first)
    inputBinding:
      position: 10
      prefix: -S
  - id: samtools
    type:
      - 'null'
      - string
    doc: "Path to the directory to \"samtools\" executable"
    inputBinding:
      position: 10
      prefix: -st
  - id: bcftools
    type:
      - 'null'
      - string
    doc: "Path to the directory of \"bcftools\" executable"
    inputBinding:
      position: 10
      prefix: -bt
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of available parallel processes (default: 2)"
    inputBinding:
      position: 10
      prefix: -j
  - id: readquality
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality for an aligned read to be considered (default: 0)"
    inputBinding:
      position: 10
      prefix: -q
  - id: basequality
    type:
      - 'null'
      - int
    doc: "Minimum base quality for a base to be considered (default: 11)"
    inputBinding:
      position: 10
      prefix: -Q
  - id: snpquality
    type:
      - 'null'
      - int
    doc: "Minimum SNP-variant quality, QUAL, for a variant to be considered (default: 11)"
    inputBinding:
      position: 10
      prefix: -U
  - id: gamma
    type:
      - 'null'
      - float
    doc: "Level of confidence to determine heterozigosity of SNPs (default: 0.05)"
    inputBinding:
      position: 10
      prefix: -g
  - id: maxshift
    type:
      - 'null'
      - float
    doc: "Maximum allowed absolute difference of BAF from 0.5 for selected heterozygous SNPs in the normal sample (default: 0.5)"
    inputBinding:
      position: 10
      prefix: -b
  - id: mincov
    type:
      - 'null'
      - int
    doc: "Minimum coverage for SNPs to be considered (default: 0)"
    inputBinding:
      position: 10
      prefix: -c
  - id: maxcov
    type:
      - 'null'
      - int
    doc: "Maximum coverage for SNPs to be considered (default: 1000)"
    inputBinding:
      position: 10
      prefix: -C
  - id: newbaq
    type:
      - 'null'
      - boolean
    doc: "Recompute alignment of reads on the fly during SNP calling (default: false)"
    inputBinding:
      position: 10
      prefix: -E
  - id: outputnormal
    type:
      - 'null'
      - string
    doc: "Filename of output for allele counts in the normal sample (default: standard output)"
    inputBinding:
      position: 10
      prefix: -O
  - id: outputtumors
    type:
      - 'null'
      - string
    doc: "Output filename for allele counts in tumor samples (default: standard output)"
    inputBinding:
      position: 10
      prefix: -o
  - id: outputsnps
    type:
      - 'null'
      - string
    doc: "Output directory for lists of selected SNPs (default: ./)"
    inputBinding:
      position: 10
      prefix: -l
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more chromosomes to process (default: blank to process all chromosomes)"
    inputBinding:
      position: 10
      prefix: --chromosomes
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Use verbose log messages
    inputBinding:
      position: 10
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: normal_alleles
    type:
      - 'null'
      - File
    doc: Allele counts of the normal sample
    outputBinding:
      glob: $(inputs.outputnormal)
  - id: tumor_alleles
    type:
      - 'null'
      - File
    doc: Allele counts of the tumor samples (1bed)
    outputBinding:
      glob: $(inputs.outputtumors)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
stdout: hatchet_count_alleles.out
