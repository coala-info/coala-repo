cwlVersion: v1.2
class: CommandLineTool
baseCommand: smeg_growth_est
label: smeg_growth_est
doc: "Estimate growth rate of bacterial populations from sequencing reads.\n\nTool
  homepage: https://github.com/ohlab/SMEG"
inputs:
  - id: cluster_detection_threshold
    type:
      - 'null'
      - float
    doc: Cluster detection threshold (range 0.1 - 1)
    default: 0.2
    inputBinding:
      position: 101
      prefix: -d
  - id: coverage_cutoff
    type:
      - 'null'
      - float
    doc: Coverage cutoff (>= 0.5)
    default: 0.5
    inputBinding:
      position: 101
      prefix: -c
  - id: desman_strains_file
    type:
      - 'null'
      - File
    doc: File listing FULL PATH to DESMAN-resolved strains in fasta format 
      (core-genes)
    inputBinding:
      position: 101
      prefix: -a
  - id: max_mismatch
    type:
      - 'null'
      - int
    doc: Max number of mismatch
    default: use default bowtie2 threshold
    inputBinding:
      position: 101
      prefix: -n
  - id: merge_output
    type:
      - 'null'
      - boolean
    doc: merge output tables into a single matrix file and generate heatmap
    inputBinding:
      position: 101
      prefix: -e
  - id: min_snps
    type:
      - 'null'
      - int
    doc: Minimum number of SNPs to estimate growth rate
    default: 100
    inputBinding:
      position: 101
      prefix: -u
  - id: output_directory
    type: Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: -o
  - id: reads_directory
    type: Directory
    doc: Reads directory (single-end reads)
    inputBinding:
      position: 101
      prefix: -r
  - id: reference_genomes_file
    type:
      - 'null'
      - File
    doc: File listing reference genomes for growth rate estimation
    inputBinding:
      position: 101
      prefix: -g
  - id: sample_extension
    type:
      - 'null'
      - string
    doc: Sample filename extension (fq, fastq, fastq.gz)
    default: fastq
    inputBinding:
      position: 101
      prefix: -x
  - id: sample_snp_assignment_threshold
    type:
      - 'null'
      - float
    doc: Sample-specific SNP assignment threshold (range 0.1 - 1)
    default: 0.6
    inputBinding:
      position: 101
      prefix: -t
  - id: smeg_method
    type:
      - 'null'
      - int
    doc: SMEG method (0 = de novo-based method, 1 = reference-based method)
    default: 0
    inputBinding:
      position: 101
      prefix: -m
  - id: species_database_directory
    type: Directory
    doc: Species database directory
    inputBinding:
      position: 101
      prefix: -s
  - id: subset_reads_file
    type:
      - 'null'
      - File
    doc: Path to file listing a subset of reads for analysis [default = analyze 
      all samples in Reads directory]
    inputBinding:
      position: 101
      prefix: -l
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 4
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smeg:1.1.5--0
stdout: smeg_growth_est.out
