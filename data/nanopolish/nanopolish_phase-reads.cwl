cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanopolish phase-reads
label: nanopolish_phase-reads
doc: "Output a BAM file where each record shows the combination of alleles from variants.vcf
  that each read supports. variants.vcf can be any VCF file but only SNPs will be
  phased and variants that have a homozygous reference genotype (0/0) will be skipped.\n\
  \nTool homepage: https://github.com/jts/nanopolish"
inputs:
  - id: variants_vcf
    type: File
    doc: variants.vcf can be any VCF file but only SNPs will be phased and 
      variants that have a homozygous reference genotype (0/0) will be skipped.
    inputBinding:
      position: 1
  - id: bam_file
    type: File
    doc: the reads aligned to the genome assembly are in bam FILE
    inputBinding:
      position: 102
      prefix: --bam
  - id: genome_file
    type: File
    doc: the reference genome is in FILE
    inputBinding:
      position: 102
      prefix: --genome
  - id: progress
    type:
      - 'null'
      - boolean
    doc: print out a progress message
    inputBinding:
      position: 102
      prefix: --progress
  - id: reads_file
    type: File
    doc: the ONT reads are in fasta FILE
    inputBinding:
      position: 102
      prefix: --reads
  - id: threads
    type:
      - 'null'
      - int
    doc: 'use NUM threads (default: 1)'
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: window
    type:
      - 'null'
      - string
    doc: 'only phase reads in the window STR (format: ctg:start-end)'
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
stdout: nanopolish_phase-reads.out
