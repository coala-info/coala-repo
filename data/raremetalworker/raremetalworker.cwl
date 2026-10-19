cwlVersion: v1.2
class: CommandLineTool
baseCommand: raremetalworker
label: raremetalworker
doc: "RAREMETALWORKER: a forerunner of RAREMETAL. It computes single-variant score statistics and covariance (LD) matrices for rare-variant meta-analysis.\n\nTool homepage: http://genome.sph.umich.edu/wiki/RAREMETALWORKER"
inputs:
  - id: ped_file
    type: File
    doc: Pedigree file with phenotypes and covariates
    inputBinding:
      position: 1
      prefix: --ped
  - id: dat_file
    type: File
    doc: Data file that describes the columns of the pedigree file
    inputBinding:
      position: 2
      prefix: --dat
  - id: vcf_file
    type: File
    doc: Genotype VCF file (bgzip compressed and tabix indexed)
    secondaryFiles:
      - pattern: .tbi
        required: false
    inputBinding:
      position: 3
      prefix: --vcf
  - id: prefix
    type: string
    doc: Prefix of the output files
    inputBinding:
      position: 4
      prefix: --prefix
  - id: dosage
    type:
      - 'null'
      - boolean
    doc: Input genotypes are dosages
    inputBinding:
      position: 5
      prefix: --dosage
  - id: noeof
    type:
      - 'null'
      - boolean
    doc: Do not require an EOF marker in the VCF
    inputBinding:
      position: 5
      prefix: --noeof
  - id: zip
    type:
      - 'null'
      - boolean
    doc: Compress the output files
    inputBinding:
      position: 5
      prefix: --zip
  - id: thin
    type:
      - 'null'
      - boolean
    doc: Thin the output (fewer positions)
    inputBinding:
      position: 5
      prefix: --thin
  - id: label_hits
    type:
      - 'null'
      - boolean
    doc: Label hits in the output
    inputBinding:
      position: 5
      prefix: --labelHits
  - id: vcx
    type:
      - 'null'
      - boolean
    doc: Run the variance component analysis for chromosome X
    inputBinding:
      position: 5
      prefix: --vcX
  - id: separate_x
    type:
      - 'null'
      - boolean
    doc: Analyse chromosome X separately
    inputBinding:
      position: 5
      prefix: --separateX
  - id: make_residuals
    type:
      - 'null'
      - boolean
    doc: Make residuals of the trait after adjusting for covariates
    inputBinding:
      position: 5
      prefix: --makeResiduals
  - id: inverse_normal
    type:
      - 'null'
      - boolean
    doc: Apply inverse normal transformation to the residuals
    inputBinding:
      position: 5
      prefix: --inverseNormal
  - id: recessive
    type:
      - 'null'
      - boolean
    doc: Use a recessive genetic model
    inputBinding:
      position: 5
      prefix: --recessive
  - id: dominant
    type:
      - 'null'
      - boolean
    doc: Use a dominant genetic model
    inputBinding:
      position: 5
      prefix: --dominant
  - id: kin_pedigree
    type:
      - 'null'
      - boolean
    doc: Take the kinship matrix from the pedigree
    inputBinding:
      position: 5
      prefix: --kinPedigree
  - id: kin_geno
    type:
      - 'null'
      - boolean
    doc: Estimate the kinship matrix from genotypes
    inputBinding:
      position: 5
      prefix: --kinGeno
  - id: kin_save
    type:
      - 'null'
      - boolean
    doc: Save the kinship matrix
    inputBinding:
      position: 5
      prefix: --kinSave
  - id: kin_only
    type:
      - 'null'
      - boolean
    doc: Only compute the kinship matrix
    inputBinding:
      position: 5
      prefix: --kinOnly
  - id: merged_vcf_id
    type:
      - 'null'
      - boolean
    doc: VCF sample IDs are merged family and individual IDs
    inputBinding:
      position: 5
      prefix: --mergedVCFID
  - id: no_phone_home
    type:
      - 'null'
      - boolean
    doc: Do not contact the developers' server
    inputBinding:
      position: 5
      prefix: --noPhoneHome
  - id: kin_file
    type:
      - 'null'
      - File
    doc: Kinship matrix file
    inputBinding:
      position: 5
      prefix: --kinFile
  - id: kinx_file
    type:
      - 'null'
      - File
    doc: Kinship matrix file for chromosome X
    inputBinding:
      position: 5
      prefix: --kinxFile
  - id: gene_map
    type:
      - 'null'
      - File
    doc: Gene map file (refFlat format)
    inputBinding:
      position: 5
      prefix: --geneMap
  - id: flag_dosage
    type:
      - 'null'
      - string
    doc: VCF FORMAT field that holds the dosage (default DS)
    inputBinding:
      position: 5
      prefix: --flagDosage
  - id: trait_name
    type:
      - 'null'
      - string
    doc: Name of the trait to analyse
    inputBinding:
      position: 5
      prefix: --traitName
  - id: x_label
    type:
      - 'null'
      - string
    doc: Chromosome label for X (default X)
    inputBinding:
      position: 5
      prefix: --xLabel
  - id: male_label
    type:
      - 'null'
      - string
    doc: Label for males (default 1)
    inputBinding:
      position: 5
      prefix: --maleLabel
  - id: female_label
    type:
      - 'null'
      - string
    doc: Label for females (default 2)
    inputBinding:
      position: 5
      prefix: --femaleLabel
  - id: ld_window
    type:
      - 'null'
      - int
    doc: Window size for LD (default 1000000)
    inputBinding:
      position: 5
      prefix: --LDwindow
  - id: x_start
    type:
      - 'null'
      - int
    doc: Start of the X-chromosome non-PAR region
    inputBinding:
      position: 5
      prefix: --xStart
  - id: x_end
    type:
      - 'null'
      - int
    doc: End of the X-chromosome non-PAR region
    inputBinding:
      position: 5
      prefix: --xEnd
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of CPUs
    inputBinding:
      position: 5
      prefix: --cpu
  - id: phone_home_thinning
    type:
      - 'null'
      - int
    doc: Phone home thinning interval
    inputBinding:
      position: 5
      prefix: --phoneHomeThinning
  - id: kin_maf
    type:
      - 'null'
      - float
    doc: Minimum minor allele frequency for kinship (default 0.05)
    inputBinding:
      position: 5
      prefix: --kinMaf
  - id: kin_miss
    type:
      - 'null'
      - float
    doc: Maximum missing rate for kinship (default 0.05)
    inputBinding:
      position: 5
      prefix: --kinMiss
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written with the output prefix (score statistics, covariance, kinship and log)
    outputBinding:
      glob: $(inputs.prefix)*
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/raremetalworker:v4.13.7_cv3
stdout: raremetalworker.out
