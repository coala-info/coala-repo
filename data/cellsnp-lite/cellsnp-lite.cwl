cwlVersion: v1.2
class: CommandLineTool
baseCommand: cellsnp-lite
label: cellsnp-lite
doc: "A lightweight tool for efficient calling and genotyping of single nucleotide
  polymorphisms (SNPs) in single-cell RNA-seq data.\n\nTool homepage: https://github.com/single-cell-genetics/cellSNP"
inputs:
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input BAM/SAM/CRAM file(s), comma separated.
    inputBinding:
      position: 101
      prefix: --bamFiles
  - id: bam_list
    type:
      - 'null'
      - File
    doc: A file containing a list of input BAM/SAM/CRAM files, one per line.
    inputBinding:
      position: 101
      prefix: --bamList
  - id: doublet_gl
    type:
      - 'null'
      - boolean
    doc: If set, calculate genotype likelihood for doublets.
    inputBinding:
      position: 101
      prefix: --doubletGL
  - id: genotype
    type:
      - 'null'
      - boolean
    doc: If set, do genotyping in addition to counting.
    inputBinding:
      position: 101
      prefix: --genotype
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: If set, gzip the output VCF file.
    inputBinding:
      position: 101
      prefix: --gzip
  - id: min_count
    type:
      - 'null'
      - int
    doc: Minimum total counts for a SNP to be output.
    default: 20
    inputBinding:
      position: 101
      prefix: --minCOUNT
  - id: min_maf
    type:
      - 'null'
      - float
    doc: Minimum minor allele frequency for a SNP to be output.
    default: 0.0
    inputBinding:
      position: 101
      prefix: --minMAF
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of processes to use.
    default: 1
    inputBinding:
      position: 101
      prefix: --nproc
  - id: region_file
    type:
      - 'null'
      - File
    doc: A TSV file contains regions (chr, pos) or a VCF file contains SNPs.
    inputBinding:
      position: 101
      prefix: --regionFile
  - id: sample_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input sample file(s), comma separated.
    inputBinding:
      position: 101
      prefix: --sampleFiles
  - id: sample_list
    type:
      - 'null'
      - File
    doc: A file containing a list of input sample files, one per line.
    inputBinding:
      position: 101
      prefix: --sampleList
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: A VCF file containing candidate SNPs.
    inputBinding:
      position: 101
      prefix: --vcfFile
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory for VCF and sparse matrices.
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cellsnp-lite:1.2.3--ha0c3a46_6
