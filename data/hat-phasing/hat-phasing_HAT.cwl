cwlVersion: v1.2
class: CommandLineTool
baseCommand: HAT
label: hat-phasing_HAT
doc: "HAT\n\nTool homepage: https://github.com/AbeelLab/hat/"
inputs:
  - id: chromosome_name
    type: string
    doc: The chromosome which is getting phased
    inputBinding:
      position: 1
  - id: vcf_file
    type: File
    doc: VCF file name
    inputBinding:
      position: 2
  - id: short_read_alignment
    type: File
    doc: short reads alignment file
    inputBinding:
      position: 3
  - id: long_read_alignment
    type: File
    doc: long reads alignment file
    inputBinding:
      position: 4
  - id: ploidy
    type: int
    doc: ploidy of the chromosome
    inputBinding:
      position: 5
  - id: output
    type: string
    doc: output prefix file name
    inputBinding:
      position: 6
  - id: output_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 7
  - id: haplotype_assembly
    type:
      - 'null'
      - File
    doc: Assembly of the haplotype sequences
    inputBinding:
      position: 108
      prefix: --haplotype_assembly
  - id: longreads_fasta
    type:
      - 'null'
      - File
    doc: long reads fasta file
    inputBinding:
      position: 108
      prefix: --longreads_fasta
  - id: multiple_genome_alignment
    type:
      - 'null'
      - File
    doc: Multiple genome alignment file of haplotypes to the reference
    inputBinding:
      position: 108
      prefix: --multiple_genome_alignment
  - id: phasing_location
    type:
      - 'null'
      - string
    doc: the location in the chromosome which is phased
    inputBinding:
      position: 108
      prefix: --phasing_location
  - id: read_length
    type:
      - 'null'
      - int
    doc: short reads length
    inputBinding:
      position: 108
      prefix: --read_length
  - id: reference_file
    type:
      - 'null'
      - File
    doc: reference file
    inputBinding:
      position: 108
      prefix: --reference_file
  - id: shortreads_1_fastq
    type:
      - 'null'
      - File
    doc: first pair fastq file
    inputBinding:
      position: 108
      prefix: --shortreads_1_fastq
  - id: shortreads_2_fastq
    type:
      - 'null'
      - File
    doc: second pair fastq file
    inputBinding:
      position: 108
      prefix: --shortreads_2_fastq
  - id: true_haplotypes
    type:
      - 'null'
      - File
    doc: the correct haplotypes file
    inputBinding:
      position: 108
      prefix: --true_haplotypes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hat-phasing:0.1.8--pyh5e36f6f_0
stdout: hat-phasing_HAT.out
