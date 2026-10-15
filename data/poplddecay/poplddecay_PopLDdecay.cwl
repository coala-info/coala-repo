cwlVersion: v1.2
class: CommandLineTool
baseCommand: PopLDdecay
label: poplddecay_PopLDdecay
doc: "Calculates and summarizes linkage disequilibrium (LD) decay (r^2 and D' against distance) from a VCF or genotype file.\n\nTool homepage: https://github.com/BGI-shenzhen/PopLDdecay"
inputs:
  - id: input_vcf
    type:
      - 'null'
      - File
    doc: "Input SNP VCF format (compressed or uncompressed)"
    inputBinding:
      position: 1
      prefix: -InVCF
  - id: input_genotype
    type:
      - 'null'
      - File
    doc: "Input SNP genotype format"
    inputBinding:
      position: 1
      prefix: -InGenotype
  - id: out_stat
    type: string
    doc: "Output stat file (Dist ~ r^2/D'), for example LDdecay.stat.gz"
    inputBinding:
      position: 1
      prefix: -OutStat
  - id: subpop
    type:
      - 'null'
      - File
    doc: "Sub-group sample list file (default: all samples)"
    inputBinding:
      position: 1
      prefix: -SubPop
  - id: max_dist
    type:
      - 'null'
      - int
    doc: "Max distance (kb) between two SNPs. Default: 300"
    inputBinding:
      position: 1
      prefix: -MaxDist
  - id: maf
    type:
      - 'null'
      - float
    doc: "Min minor allele frequency filter. Default: 0.005"
    inputBinding:
      position: 1
      prefix: -MAF
  - id: het
    type:
      - 'null'
      - float
    doc: "Max ratio of heterozygous alleles filter. Default: 0.88"
    inputBinding:
      position: 1
      prefix: -Het
  - id: miss
    type:
      - 'null'
      - float
    doc: "Max ratio of missing alleles filter. Default: 0.25"
    inputBinding:
      position: 1
      prefix: -Miss
  - id: ehh
    type:
      - 'null'
      - string
    doc: "Run EHH region decay at this site, format chr:site"
    inputBinding:
      position: 1
      prefix: -EHH
  - id: out_filter_snp
    type:
      - 'null'
      - boolean
    doc: "Output the final SNP set used for the calculation"
    inputBinding:
      position: 1
      prefix: -OutFilterSNP
  - id: out_type
    type:
      - 'null'
      - int
    doc: "1: r^2 result, 2: r^2 and D' result, 3: pairwise LD output (more types 4-8 in the manual). Default: 1"
    inputBinding:
      position: 1
      prefix: -OutType
  - id: method
    type:
      - 'null'
      - int
    doc: "Algorithm: 1 (default, faster) or 2 (may use more memory)"
    inputBinding:
      position: 1
      prefix: -Method
outputs:
  - id: stat_file
    type:
      - 'null'
      - File
    doc: "LD decay statistics (Dist, mean r^2, mean D', pair counts)"
    outputBinding:
      glob: "$(inputs.out_stat)"
  - id: pairwise_ld
    type:
      - 'null'
      - File
    doc: "Pairwise LD result (OutType 3 or higher)"
    outputBinding:
      glob: "*.LD.gz"
  - id: filtered_snps
    type:
      - 'null'
      - File
    doc: "Final SNP set (with OutFilterSNP)"
    outputBinding:
      glob: "*.vcf.filter.gz"
  - id: ehh_file
    type:
      - 'null'
      - File
    doc: "EHH decay result (with EHH)"
    outputBinding:
      glob: "*.ehh.gz"
  - id: stdout
    type: stdout
    doc: "Log"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poplddecay:3.43--hdcf5f25_1
stdout: PopLDdecay.log
