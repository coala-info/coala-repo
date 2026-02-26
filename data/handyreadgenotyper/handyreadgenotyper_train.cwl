cwlVersion: v1.2
class: CommandLineTool
baseCommand: train
label: handyreadgenotyper_train
doc: "Classify reads in BAM file using existing model or train a model from bam files\n\
  \nTool homepage: https://github.com/AntonS-bio/HandyReadGenotyper"
inputs:
  - id: bams_matrix
    type:
      - 'null'
      - File
    doc: Matrix with precalculated BAM matrices ()
    inputBinding:
      position: 101
      prefix: --bams_matrix
  - id: cpus
    type:
      - 'null'
      - int
    doc: Directory for output files
    inputBinding:
      position: 101
      prefix: --cpus
  - id: negative_bams
    type:
      - 'null'
      - Directory
    doc: Directory with or list of TARGET BAM files and corresponding BAM index 
      files (.bai)
    inputBinding:
      position: 101
      prefix: --negative_bams
  - id: positive_bams
    type: Directory
    doc: Directory with or list of NON-target BAM files and corresponding BAM 
      index files (.bai)
    inputBinding:
      position: 101
      prefix: --positive_bams
  - id: reference
    type: File
    doc: FASTA file with the reference to which reads where mapped
    inputBinding:
      position: 101
      prefix: --reference
  - id: special_cases
    type:
      - 'null'
      - File
    doc: Tab delimited file specifying amplicon for which presence/absense 
      should be reported
    inputBinding:
      position: 101
      prefix: --special_cases
  - id: target_regions
    type: File
    doc: Bed file that specifies reference intervals to which reads where mapped
    inputBinding:
      position: 101
      prefix: --target_regions
  - id: vcf
    type: File
    doc: VCF file containing positions that will be excluded from training as 
      well as genotype defining SNPs (also excluded)
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: output_dir
    type: Directory
    doc: Directory for output files
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/handyreadgenotyper:0.1.24--pyhdfd78af_0
