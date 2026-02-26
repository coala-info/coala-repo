cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - MendelScan.jar
  - score
label: mendelscan_score
doc: "Score variants using MendelScan.\n\nTool homepage: https://github.com/genome/mendelscan"
inputs:
  - id: vcf_file
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: anno_score_1
    type:
      - 'null'
      - float
    doc: Score for intergenic mutations
    default: 0.01
    inputBinding:
      position: 102
      prefix: --anno-score-1
  - id: anno_score_10
    type:
      - 'null'
      - float
    doc: Score for nonstop mutations
    default: 1.0
    inputBinding:
      position: 102
      prefix: --anno-score-10
  - id: anno_score_11
    type:
      - 'null'
      - float
    doc: Score for missense mutations not predicted damaging
    default: 0.8
    inputBinding:
      position: 102
      prefix: --anno-score-11
  - id: anno_score_12
    type:
      - 'null'
      - float
    doc: Score for missense mutations damaging by 1/3 algorithms
    default: 0.95
    inputBinding:
      position: 102
      prefix: --anno-score-12
  - id: anno_score_13
    type:
      - 'null'
      - float
    doc: Score for missense mutations damaging by 2/3 algorithms
    default: 0.95
    inputBinding:
      position: 102
      prefix: --anno-score-13
  - id: anno_score_14
    type:
      - 'null'
      - float
    doc: Score for missense mutations damaging by 3/3 algorithms
    default: 0.95
    inputBinding:
      position: 102
      prefix: --anno-score-14
  - id: anno_score_15
    type:
      - 'null'
      - float
    doc: Score for essential splice site mutations
    default: 1.0
    inputBinding:
      position: 102
      prefix: --anno-score-15
  - id: anno_score_16
    type:
      - 'null'
      - float
    doc: Score for frameshift mutations
    default: 1.0
    inputBinding:
      position: 102
      prefix: --anno-score-16
  - id: anno_score_17
    type:
      - 'null'
      - float
    doc: Score for nonsense mutations
    default: 1.0
    inputBinding:
      position: 102
      prefix: --anno-score-17
  - id: anno_score_2
    type:
      - 'null'
      - float
    doc: Score for intronic mutations
    default: 0.01
    inputBinding:
      position: 102
      prefix: --anno-score-2
  - id: anno_score_3
    type:
      - 'null'
      - float
    doc: Score for downstream mutations
    default: 0.01
    inputBinding:
      position: 102
      prefix: --anno-score-3
  - id: anno_score_4
    type:
      - 'null'
      - float
    doc: Score for upstream mutations
    default: 0.01
    inputBinding:
      position: 102
      prefix: --anno-score-4
  - id: anno_score_5
    type:
      - 'null'
      - float
    doc: Score for UTR mutations
    default: 0.01
    inputBinding:
      position: 102
      prefix: --anno-score-5
  - id: anno_score_6
    type:
      - 'null'
      - float
    doc: Score for ncRNA mutations
    default: 0.01
    inputBinding:
      position: 102
      prefix: --anno-score-6
  - id: anno_score_7
    type:
      - 'null'
      - float
    doc: Score for miRNA mutations
    default: 0.01
    inputBinding:
      position: 102
      prefix: --anno-score-7
  - id: anno_score_8
    type:
      - 'null'
      - float
    doc: Score for synonymous coding mutations
    default: 0.05
    inputBinding:
      position: 102
      prefix: --anno-score-8
  - id: anno_score_9
    type:
      - 'null'
      - float
    doc: Score for splice region mutations
    default: 0.2
    inputBinding:
      position: 102
      prefix: --anno-score-9
  - id: gene_file
    type:
      - 'null'
      - File
    doc: A list of gene expression values for tissue of interest
    inputBinding:
      position: 102
      prefix: --gene-file
  - id: inheritance
    type:
      - 'null'
      - string
    doc: 'Presumed model of inheritance: dominant, recessive, x-linked'
    default: dominant
    inputBinding:
      position: 102
      prefix: --inheritance
  - id: max_vaf_for_ref
    type:
      - 'null'
      - float
    doc: Maximum non-ref (variant) allele frequency at ref site to count as ref
    default: 0.05
    inputBinding:
      position: 102
      prefix: --max-vaf-for-ref
  - id: min_read_depth
    type:
      - 'null'
      - int
    doc: Minimum read depth to consider a confident genotype call
    default: 20
    inputBinding:
      position: 102
      prefix: --min-read-depth
  - id: min_vaf_to_recall
    type:
      - 'null'
      - float
    doc: Minimum VAF at which a reference genotype will be considered het. To 
      disable recall, set to 1.01
    default: 0.2
    inputBinding:
      position: 102
      prefix: --min-vaf-to-recall
  - id: ped_file
    type:
      - 'null'
      - File
    doc: Pedigree file in 6-column tab-delimited format
    inputBinding:
      position: 102
      prefix: --ped-file
  - id: pop_score_common
    type:
      - 'null'
      - float
    doc: Variant in dbSNP with GMAF >= 0.05
    default: 0.01
    inputBinding:
      position: 102
      prefix: --pop-score-common
  - id: pop_score_known
    type:
      - 'null'
      - float
    doc: Variant known to dbSNP but no mutation or GMAF info
    default: 0.6
    inputBinding:
      position: 102
      prefix: --pop-score-known
  - id: pop_score_mutation
    type:
      - 'null'
      - float
    doc: Variant from mutation (OMIM) or locus-specific databases
    default: 0.95
    inputBinding:
      position: 102
      prefix: --pop-score-mutation
  - id: pop_score_novel
    type:
      - 'null'
      - float
    doc: Variant is not present in dbSNP according to VCF
    default: 1.0
    inputBinding:
      position: 102
      prefix: --pop-score-novel
  - id: pop_score_rare
    type:
      - 'null'
      - float
    doc: Variant in dbSNP with GMAF < 0.01
    default: 0.2
    inputBinding:
      position: 102
      prefix: --pop-score-rare
  - id: pop_score_uncommon
    type:
      - 'null'
      - float
    doc: Variant in dbSNP with GMAF 0.01-0.05
    default: 0.02
    inputBinding:
      position: 102
      prefix: --pop-score-uncommon
  - id: seg_score_case_het
    type:
      - 'null'
      - float
    doc: A case sample was called heterozygous (NA/0.50)
    default: 0.5
    inputBinding:
      position: 102
      prefix: --seg-score-case-het
  - id: seg_score_case_hom
    type:
      - 'null'
      - float
    doc: A case sample was called homozygous variant (0.80/NA)
    default: 0.8
    inputBinding:
      position: 102
      prefix: --seg-score-case-hom
  - id: seg_score_case_ref
    type:
      - 'null'
      - float
    doc: A case sample was called reference/wild-type (0.50/0.10)
    default: 0.5
    inputBinding:
      position: 102
      prefix: --seg-score-case-ref
  - id: seg_score_control_het
    type:
      - 'null'
      - float
    doc: A case sample was called heterozygous (0.10/NA)
    default: 0.1
    inputBinding:
      position: 102
      prefix: --seg-score-control-het
  - id: seg_score_control_hom
    type:
      - 'null'
      - float
    doc: A case sample was called homozygous variant (0.01/0.10)
    default: 0.01
    inputBinding:
      position: 102
      prefix: --seg-score-control-hom
  - id: vep_file
    type:
      - 'null'
      - File
    doc: Variant annotation in VEP format
    inputBinding:
      position: 102
      prefix: --vep-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to contain human-friendly scored variants
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: Output file to contain scored variants in VCF format
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mendelscan:v1.2.2--0
