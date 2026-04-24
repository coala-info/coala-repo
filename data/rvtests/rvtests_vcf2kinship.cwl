cwlVersion: v1.2
class: CommandLineTool
baseCommand: rvtests_vcf2kinship
label: rvtests_vcf2kinship
doc: "Calculate kinship from VCF files.\n\nTool homepage: https://github.com/zhanxw/rvtests"
inputs:
  - id: anno
    type:
      - 'null'
      - string
    doc: Specify the annotation type to be included in calculating kinship.
    inputBinding:
      position: 101
      prefix: --anno
  - id: bn
    type:
      - 'null'
      - boolean
    doc: Use Balding-Nicols method.
    inputBinding:
      position: 101
      prefix: --bn
  - id: dosage
    type:
      - 'null'
      - string
    doc: Specify which dosage tag to use (e.g. EC/DS). Typical dosage are 
      between 0.0 and 2.0.
    inputBinding:
      position: 101
      prefix: --dosage
  - id: ibs
    type:
      - 'null'
      - boolean
    doc: Use IBS method.
    inputBinding:
      position: 101
      prefix: --ibs
  - id: in_vcf
    type: File
    doc: Input VCF File
    inputBinding:
      position: 101
      prefix: --inVcf
  - id: max_miss
    type:
      - 'null'
      - float
    doc: Specify the maximum allows missing rate to be inclued in calculating 
      kinship.
    inputBinding:
      position: 101
      prefix: --maxMiss
  - id: min_gd
    type:
      - 'null'
      - float
    doc: Specify the minimum genotype depth, otherwise marked as missing 
      genotype
    inputBinding:
      position: 101
      prefix: --minGD
  - id: min_gq
    type:
      - 'null'
      - float
    doc: Specify the minimum genotype quality, otherwise marked as missing 
      genotype
    inputBinding:
      position: 101
      prefix: --minGQ
  - id: min_maf
    type:
      - 'null'
      - float
    doc: Specify the minimum MAF threshold to be included in calculating 
      kinship.
    inputBinding:
      position: 101
      prefix: --minMAF
  - id: min_site_qual
    type:
      - 'null'
      - float
    doc: Specify minimum site qual
    inputBinding:
      position: 101
      prefix: --minSiteQual
  - id: out
    type: string
    doc: Output prefix for autosomal kinship calculation
    inputBinding:
      position: 101
      prefix: --out
  - id: pca
    type:
      - 'null'
      - boolean
    doc: Decomoposite calculated kinship matrix.
    inputBinding:
      position: 101
      prefix: --pca
  - id: ped
    type:
      - 'null'
      - File
    doc: Use pedigree method or specify ped file for X chromosome analysis.
    inputBinding:
      position: 101
      prefix: --ped
  - id: people_exclude_file
    type:
      - 'null'
      - File
    doc: From given file, set IDs of people that will be included in study
    inputBinding:
      position: 101
      prefix: --peopleExcludeFile
  - id: people_exclude_id
    type:
      - 'null'
      - type: array
        items: string
    doc: List IDs of people that will be included in study
    inputBinding:
      position: 101
      prefix: --peopleExcludeID
  - id: people_include_file
    type:
      - 'null'
      - File
    doc: From given file, set IDs of people that will be included in study
    inputBinding:
      position: 101
      prefix: --peopleIncludeFile
  - id: people_include_id
    type:
      - 'null'
      - type: array
        items: string
    doc: List IDs of people that will be included in study
    inputBinding:
      position: 101
      prefix: --peopleIncludeID
  - id: range_file
    type:
      - 'null'
      - File
    doc: Specify the file containing ranges, please use chr:begin-end format.
    inputBinding:
      position: 101
      prefix: --rangeFile
  - id: range_list
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify some ranges to use, please use chr:begin-end format.
    inputBinding:
      position: 101
      prefix: --rangeList
  - id: store_genotype
    type:
      - 'null'
      - boolean
    doc: Store genotye matrix (sample by genotype).
    inputBinding:
      position: 101
      prefix: --storeGenotype
  - id: thread
    type:
      - 'null'
      - int
    doc: Specify number of parallel threads to speed up
    inputBinding:
      position: 101
      prefix: --thread
  - id: update_id
    type:
      - 'null'
      - File
    doc: Update VCF sample id using given file (column 1 and 2 are old and new 
      id).
    inputBinding:
      position: 101
      prefix: --update-id
  - id: x_hemi
    type:
      - 'null'
      - boolean
    doc: Calculate kinship using non-PAR region X chromosome markers.
    inputBinding:
      position: 101
      prefix: --xHemi
  - id: x_label
    type:
      - 'null'
      - string
    doc: 'Specify X chromosome label (default: 23,X'
    inputBinding:
      position: 101
      prefix: --xLabel
  - id: x_region
    type:
      - 'null'
      - string
    doc: "Specify PAR region (default: hg19), can be build number e.g. hg38, b37;
      or specify region, e.g. '60001-2699520,154931044-155260560'"
    inputBinding:
      position: 101
      prefix: --xRegion
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
stdout: rvtests_vcf2kinship.out
