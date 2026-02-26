cwlVersion: v1.2
class: CommandLineTool
baseCommand: haptools_clump
label: haptools_clump
doc: "Performs clumping on datasets with SNPs, SNPs and STRs, and STRs. Clumping is
  the process of identifying SNPs or STRs that are highly correlated with one another
  and concatenating them all together into a single \"clump\" in order to not repeat
  the same effect size due to LD.\n\nTool homepage: https://github.com/cast-genomics/haptools"
inputs:
  - id: clump_chrom_field
    type:
      - 'null'
      - string
    doc: Column header of the chromosome
    inputBinding:
      position: 101
      prefix: --clump-chrom-field
  - id: clump_field
    type:
      - 'null'
      - string
    doc: Column header of the p-values
    inputBinding:
      position: 101
      prefix: --clump-field
  - id: clump_id_field
    type:
      - 'null'
      - string
    doc: Column header of the variant ID
    inputBinding:
      position: 101
      prefix: --clump-id-field
  - id: clump_kb
    type:
      - 'null'
      - float
    doc: clump kb radius
    inputBinding:
      position: 101
      prefix: --clump-kb
  - id: clump_p1
    type:
      - 'null'
      - float
    doc: Max pval to start a new clump
    inputBinding:
      position: 101
      prefix: --clump-p1
  - id: clump_p2
    type:
      - 'null'
      - float
    doc: Filter for pvalue less than
    inputBinding:
      position: 101
      prefix: --clump-p2
  - id: clump_pos_field
    type:
      - 'null'
      - string
    doc: Column header of the position
    inputBinding:
      position: 101
      prefix: --clump-pos-field
  - id: clump_r2
    type:
      - 'null'
      - float
    doc: r^2 threshold
    inputBinding:
      position: 101
      prefix: --clump-r2
  - id: gts_snps
    type:
      - 'null'
      - File
    doc: SNP genotypes (VCF or PGEN)
    inputBinding:
      position: 101
      prefix: --gts-snps
  - id: gts_strs
    type:
      - 'null'
      - File
    doc: STR genotypes (VCF)
    inputBinding:
      position: 101
      prefix: --gts-strs
  - id: ld
    type:
      - 'null'
      - string
    doc: Calculation type to infer LD, Exact Solution or Pearson R. 
      (Exact|Pearson). Note the Exact Solution works best when all three 
      genotypes are present (0,1,2) in the variants being compared.
    default: Pearson
    inputBinding:
      position: 101
      prefix: --ld
  - id: summstats_snps
    type:
      - 'null'
      - File
    doc: File to load snps summary statistics
    inputBinding:
      position: 101
      prefix: --summstats-snps
  - id: summstats_strs
    type:
      - 'null'
      - File
    doc: File to load strs summary statistics
    inputBinding:
      position: 101
      prefix: --summstats-strs
  - id: verbosity
    type:
      - 'null'
      - string
    doc: The level of verbosity desired
    default: INFO
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: out
    type: File
    doc: Output filename
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haptools:0.6.2--pyhdfd78af_0
