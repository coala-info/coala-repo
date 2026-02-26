cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemma
label: gemma
doc: "Genome-wide Efficient Mixed Model Association (GEMMA) provides a standard linear
  mixed model for genome-wide association studies (GWAS).\n\nTool homepage: https://github.com/genetics-statistics/GEMMA"
inputs:
  - id: annotation_file
    type:
      - 'null'
      - File
    doc: Specify SNP annotation file name.
    inputBinding:
      position: 101
      prefix: -a
  - id: bfile_prefix
    type:
      - 'null'
      - string
    doc: Specify PLINK binary ped file prefix.
    inputBinding:
      position: 101
      prefix: -bfile
  - id: bslmm_analysis
    type:
      - 'null'
      - int
    doc: 'Specify BSLMM analysis type: 1: Probit model; 2: Linear model.'
    inputBinding:
      position: 101
      prefix: -bslmm
  - id: calculate_kinship
    type:
      - 'null'
      - int
    doc: 'Specify kinship matrix calculation type: 1: centered; 2: standardized.'
    inputBinding:
      position: 101
      prefix: -gk
  - id: genotype_file
    type:
      - 'null'
      - File
    doc: Specify genotype file name.
    inputBinding:
      position: 101
      prefix: -g
  - id: kinship_file
    type:
      - 'null'
      - File
    doc: Specify kinship matrix file name.
    inputBinding:
      position: 101
      prefix: -k
  - id: lmm_analysis
    type:
      - 'null'
      - int
    doc: 'Specify LMM analysis type: 1: Wald test; 2: Likelihood ratio test; 3: Score
      test; 4: All three tests.'
    inputBinding:
      position: 101
      prefix: -lmm
  - id: maf_threshold
    type:
      - 'null'
      - float
    doc: Minor allele frequency threshold.
    default: 0.01
    inputBinding:
      position: 101
      prefix: -maf
  - id: missing_threshold
    type:
      - 'null'
      - float
    doc: Missingness threshold.
    default: 0.05
    inputBinding:
      position: 101
      prefix: -miss
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads for parallel computing.
    inputBinding:
      position: 101
      prefix: -thread
  - id: phenotype_column
    type:
      - 'null'
      - int
    doc: Specify which phenotype column to use.
    default: 1
    inputBinding:
      position: 101
      prefix: -n
  - id: phenotype_file
    type:
      - 'null'
      - File
    doc: Specify phenotype file name.
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Specify output file prefix.
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemma:0.98.5--ha36d3ea_0
