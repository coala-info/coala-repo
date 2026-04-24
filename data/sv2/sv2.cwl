cwlVersion: v1.2
class: CommandLineTool
baseCommand: sv2
label: sv2
doc: "Support Vector Structural Variation Genotyper\n\nTool homepage: https://github.com/dantaki/SV2"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: bam file(s)
    inputBinding:
      position: 101
      prefix: -bam
  - id: bed_files
    type:
      type: array
      items: File
    doc: bed files(s) of SVs
    inputBinding:
      position: 101
      prefix: -bed
  - id: bwa_mem_m_compatibility
    type:
      - 'null'
      - boolean
    doc: bwa mem -M compatibility, split-reads flagged as secondary instead of 
      supplementary
    inputBinding:
      position: 101
      prefix: -M
  - id: classifier
    type:
      - 'null'
      - string
    doc: define classifier for genotyping
    inputBinding:
      position: 101
      prefix: -clf
  - id: config_ini_file
    type:
      - 'null'
      - File
    doc: configuration INI file
    inputBinding:
      position: 101
      prefix: -ini
  - id: download_data
    type:
      - 'null'
      - boolean
    doc: download required data files
    inputBinding:
      position: 101
      prefix: -download
  - id: feature_extraction_output_dir
    type:
      - 'null'
      - Directory
    doc: feature extraction output directory, skips feature extraction
    inputBinding:
      position: 101
      prefix: -feats
  - id: genome
    type:
      - 'null'
      - string
    doc: reference genome build <hg19, hg38, mm10>
    inputBinding:
      position: 101
      prefix: -genome
  - id: hg19_fasta
    type:
      - 'null'
      - File
    doc: hg19 fasta file
    inputBinding:
      position: 101
      prefix: -hg19
  - id: hg38_fasta
    type:
      - 'null'
      - File
    doc: hg38 fasta file
    inputBinding:
      position: 101
      prefix: -hg38
  - id: load_classifiers
    type:
      - 'null'
      - type: array
        items: File
    doc: add custom classifiers (-load-clf <clf.json>)
    inputBinding:
      position: 101
      prefix: -load-clf
  - id: log_file
    type:
      - 'null'
      - File
    doc: log file for standard error messages
    inputBinding:
      position: 101
      prefix: -log
  - id: merge_sv
    type:
      - 'null'
      - boolean
    doc: merge overlapping SV breakpoints after genotyping
    inputBinding:
      position: 101
      prefix: -merge
  - id: min_overlap_merge
    type:
      - 'null'
      - float
    doc: minimum reciprocal overlap for merging
    inputBinding:
      position: 101
      prefix: -min-ovr
  - id: mm10_fasta
    type:
      - 'null'
      - File
    doc: mm10 fasta file
    inputBinding:
      position: 101
      prefix: -mm10
  - id: no_annotation
    type:
      - 'null'
      - boolean
    doc: genotype without annotating variants
    inputBinding:
      position: 101
      prefix: -no-anno
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output path, location for sv2 output directories
    inputBinding:
      position: 101
      prefix: -odir
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output prefix
    inputBinding:
      position: 101
      prefix: -out
  - id: pcrfree
    type:
      - 'null'
      - boolean
    doc: GC content normalization for pcr free sequences
    inputBinding:
      position: 101
  - id: ped_files
    type:
      type: array
      items: File
    doc: ped files(s)
    inputBinding:
      position: 101
      prefix: -ped
  - id: preprocessing_output_dir
    type:
      - 'null'
      - Directory
    doc: preprocessing output directory, skips preprocessing
    inputBinding:
      position: 101
      prefix: -pre
  - id: random_seed
    type:
      - 'null'
      - int
    doc: random seed for preprocessing shuffling
    inputBinding:
      position: 101
      prefix: -seed
  - id: snv_vcf_files
    type:
      type: array
      items: File
    doc: snv vcf files(s), must be bgzipped and tabixed
    inputBinding:
      position: 101
      prefix: -snv
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 101
      prefix: -tmp-dir
  - id: vcf_files
    type:
      type: array
      items: File
    doc: vcf files(s) of SVs
    inputBinding:
      position: 101
      prefix: -vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sv2:1.4.3.4--py27h3010b51_2
stdout: sv2.out
