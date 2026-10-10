cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MotifRaptor
  - preprocess
label: motifraptor_preprocess
doc: "Pre-process the summary statistics\n\nTool homepage: https://github.com/pinellolab/MotifRaptor"
inputs:
  - id: gwas_summary
    type:
      - 'null'
      - File
    doc: "GWAS summary statistic file"
    inputBinding:
      position: 1
      prefix: -gwas
  - id: column_numbers
    type:
      - 'null'
      - string
    doc: "provide six column numbers for information in such order: ID,CHR,POS,A1,A2,SCORE eg. 1,2,3,4,5,6"
    inputBinding:
      position: 1
      prefix: -cn
  - id: score_type
    type:
      - 'null'
      - string
    doc: "Score type in GWAS summary statistic file: pvalue or zscore or chisquare"
    inputBinding:
      position: 1
      prefix: -st
  - id: score_pvalue_threshold
    type:
      - 'null'
      - float
    doc: "threshold for pvalue - default 5E-8"
    inputBinding:
      position: 1
      prefix: -th
outputs:
  - id: hit_snp_list
    type:
      - 'null'
      - File
    doc: "SNPs passing the threshold"
    outputBinding:
      glob: hitSNP_list.txt
  - id: nonhit_snp_list
    type:
      - 'null'
      - File
    doc: "SNPs not passing the threshold"
    outputBinding:
      glob: nonhitSNP_list.txt
  - id: hit_snp_vcf
    type:
      - 'null'
      - File
    doc: "Hit SNPs as VCF"
    outputBinding:
      glob: hitSNP_list.vcf
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motifraptor:0.3.0--py36h40b2fa4_5
stdout: motifraptor_preprocess.out
