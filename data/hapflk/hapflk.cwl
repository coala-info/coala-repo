cwlVersion: v1.2
class: CommandLineTool
baseCommand: hapflk
label: hapflk
doc: "hapflk\n\nTool homepage: https://github.com/BertrandServin/hapflk"
inputs:
  - id: bfile_prefix
    type:
      - 'null'
      - string
    doc: PLINK bfile prefix (bim,fam,bed)
    inputBinding:
      position: 101
      prefix: --bfilePREFIX
  - id: chr
    type:
      - 'null'
      - string
    doc: Select chromosome C
    inputBinding:
      position: 101
      prefix: --chr
  - id: eigen
    type:
      - 'null'
      - boolean
    doc: Perform eigen decomposition of tests
    inputBinding:
      position: 101
      prefix: --eigen
  - id: file_prefix
    type:
      - 'null'
      - string
    doc: PLINK file prefix (ped,map)
    inputBinding:
      position: 101
      prefix: --filePREFIX
  - id: from_pos
    type:
      - 'null'
      - string
    doc: "Select SNPs with position > x (in bp/cM) Warning :\ndoes not work with BED
      files"
    inputBinding:
      position: 101
      prefix: --from
  - id: inbred
    type:
      - 'null'
      - boolean
    doc: Haplotype data provided
    inputBinding:
      position: 101
      prefix: --inbred
  - id: keep_outgroup
    type:
      - 'null'
      - boolean
    doc: Keep outgroup in population set
    inputBinding:
      position: 101
      prefix: --keep-outgroup
  - id: kinship_file
    type:
      - 'null'
      - File
    doc: "Read population kinship from file (if None, kinship is\n               \
      \         estimated)"
    inputBinding:
      position: 101
      prefix: --kinship
  - id: map_file
    type:
      - 'null'
      - File
    doc: MAP file
    inputBinding:
      position: 101
      prefix: --map
  - id: miss_geno
    type:
      - 'null'
      - string
    doc: Missing Genotype Code
    inputBinding:
      position: 101
      prefix: --miss_geno
  - id: miss_parent
    type:
      - 'null'
      - string
    doc: Missing Parent Code
    inputBinding:
      position: 101
      prefix: --miss_parent
  - id: miss_pheno
    type:
      - 'null'
      - string
    doc: Missing Phenotype Code
    inputBinding:
      position: 101
      prefix: --miss_pheno
  - id: miss_sex
    type:
      - 'null'
      - string
    doc: Missing Sex Code
    inputBinding:
      position: 101
      prefix: --miss_sex
  - id: ncpu
    type:
      - 'null'
      - int
    doc: Use N processors when possible
    inputBinding:
      position: 101
      prefix: --ncpu
  - id: nfit
    type:
      - 'null'
      - int
    doc: Set the number of model fit to use
    inputBinding:
      position: 101
      prefix: --nfit
  - id: no_kfrq
    type:
      - 'null'
      - boolean
    doc: Do not write Cluster frequencies
    inputBinding:
      position: 101
      prefix: --no-kfrq
  - id: num_clusters
    type:
      - 'null'
      - int
    doc: "Set the number of clusters to K. hapFLK calculations\n                 \
      \       switched off if K<0"
    inputBinding:
      position: 101
      prefix: -K
  - id: other_map
    type:
      - 'null'
      - boolean
    doc: Use alternative map (genetic/RH)
    inputBinding:
      position: 101
      prefix: --other_map
  - id: outgroup
    type:
      - 'null'
      - string
    doc: "Use population POP as outgroup for tree rooting (if\n                  \
      \      None, use midpoint rooting)"
    inputBinding:
      position: 101
      prefix: --outgroup
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: prefix for output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: ped_file
    type:
      - 'null'
      - File
    doc: PED file
    inputBinding:
      position: 101
      prefix: --ped
  - id: phased
    type:
      - 'null'
      - boolean
    doc: Haplotype data provided
    inputBinding:
      position: 101
      prefix: --phased
  - id: reynolds_snps
    type:
      - 'null'
      - int
    doc: Number of SNPs to use to estimate Reynolds distances
    inputBinding:
      position: 101
      prefix: --reynolds-snps
  - id: to_pos
    type:
      - 'null'
      - string
    doc: Select SNPs with position < x (in bp/cM) Warning :does not work with 
      BED files
    inputBinding:
      position: 101
      prefix: --to
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapflk:1.3.0--py27_0
stdout: hapflk.out
