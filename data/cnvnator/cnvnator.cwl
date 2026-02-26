cwlVersion: v1.2
class: CommandLineTool
baseCommand: cnvnator
label: cnvnator
doc: "A tool for CNV discovery and genotyping from depth of read mapping\n\nTool homepage:
  https://github.com/abyzovlab/CNVnator"
inputs:
  - id: addchr
    type:
      - 'null'
      - boolean
    doc: Add 'chr' prefix to chromosome names
    inputBinding:
      position: 101
      prefix: -addchr
  - id: baf_bin_size
    type:
      - 'null'
      - int
    doc: Calculate BAF with specified bin size
    inputBinding:
      position: 101
      prefix: -baf
  - id: call_bin_size
    type:
      - 'null'
      - int
    doc: Call CNVs with specified bin size
    inputBinding:
      position: 101
      prefix: -call
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: Chromosome names
    inputBinding:
      position: 101
      prefix: -chrom
  - id: eval_bin_size
    type:
      - 'null'
      - int
    doc: Evaluate specified bin size
    inputBinding:
      position: 101
      prefix: -eval
  - id: fasta_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing fasta files
    inputBinding:
      position: 101
      prefix: -d
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: Fasta file
    inputBinding:
      position: 101
      prefix: -fasta
  - id: genome
    type:
      - 'null'
      - string
    doc: Genome name (e.g., NCBI36, hg18, GRCh37, hg19, mm9, hg38, GRCh38)
    inputBinding:
      position: 101
      prefix: -genome
  - id: genotype_bin_size
    type:
      - 'null'
      - int
    doc: Genotype with specified bin size
    inputBinding:
      position: 101
      prefix: -genotype
  - id: hap
    type:
      - 'null'
      - boolean
    doc: Use haplotype information
    inputBinding:
      position: 101
      prefix: -hap
  - id: his_bin_size
    type:
      - 'null'
      - int
    doc: Generate histogram with specified bin size
    inputBinding:
      position: 101
      prefix: -his
  - id: idvar
    type:
      - 'null'
      - File
    doc: VCF file for variant identification
    inputBinding:
      position: 101
      prefix: -idvar
  - id: lite
    type:
      - 'null'
      - boolean
    doc: Produce a smaller root file
    inputBinding:
      position: 101
      prefix: -lite
  - id: ls
    type:
      - 'null'
      - boolean
    doc: List content of root file
    inputBinding:
      position: 101
      prefix: -ls
  - id: mask
    type:
      - 'null'
      - File
    doc: Strict mask file
    inputBinding:
      position: 101
      prefix: -mask
  - id: merge
    type:
      - 'null'
      - type: array
        items: File
    doc: Merge multiple root files
    inputBinding:
      position: 101
      prefix: -merge
  - id: ngc
    type:
      - 'null'
      - boolean
    doc: Do not use GC correction
    inputBinding:
      position: 101
      prefix: -ngc
  - id: nomask
    type:
      - 'null'
      - boolean
    doc: Do not use mask
    inputBinding:
      position: 101
      prefix: -nomask
  - id: overlap
    type:
      - 'null'
      - float
    doc: Minimum overlap
    default: 0.8
    inputBinding:
      position: 101
      prefix: -over
  - id: partition_bin_size
    type:
      - 'null'
      - int
    doc: Partition with specified bin size
    inputBinding:
      position: 101
      prefix: -partition
  - id: pe_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Analyze paired-end mapping from BAM files
    inputBinding:
      position: 101
      prefix: -pe
  - id: quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    default: 20
    inputBinding:
      position: 101
      prefix: -qual
  - id: rmchr
    type:
      - 'null'
      - boolean
    doc: Remove 'chr' prefix from chromosome names
    inputBinding:
      position: 101
      prefix: -rmchr
  - id: root_file
    type:
      - 'null'
      - File
    doc: Root file for storing/retrieving data
    inputBinding:
      position: 101
      prefix: -root
  - id: stat_bin_size
    type:
      - 'null'
      - int
    doc: Calculate statistics for specified bin size
    inputBinding:
      position: 101
      prefix: -stat
  - id: tree
    type:
      - 'null'
      - type: array
        items: File
    doc: Create root file from BAM files
    inputBinding:
      position: 101
      prefix: -tree
  - id: useid
    type:
      - 'null'
      - boolean
    doc: Use variant IDs
    inputBinding:
      position: 101
      prefix: -useid
  - id: vcf
    type:
      - 'null'
      - File
    doc: VCF file for SNP data
    inputBinding:
      position: 101
      prefix: -vcf
  - id: view_bin_size
    type:
      - 'null'
      - int
    doc: View with specified bin size
    inputBinding:
      position: 101
      prefix: -view
outputs:
  - id: pe_output_file
    type:
      - 'null'
      - File
    doc: Output file for paired-end analysis
    outputBinding:
      glob: $(inputs.pe_output_file)
  - id: cptrees
    type:
      - 'null'
      - File
    doc: Copy trees to a new root file
    outputBinding:
      glob: $(inputs.cptrees)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvnator:0.4.1--py312h99c8fb2_11
