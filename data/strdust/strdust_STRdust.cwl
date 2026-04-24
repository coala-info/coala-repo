cwlVersion: v1.2
class: CommandLineTool
baseCommand: STRdust
label: strdust_STRdust
doc: "Tool to genotype STRs from long reads\n\nTool homepage: https://github.com/wdecoster/STRdust"
inputs:
  - id: fasta
    type: File
    doc: reference genome
    inputBinding:
      position: 1
  - id: bam
    type: File
    doc: BAM or CRAM file to call STRs in
    inputBinding:
      position: 2
  - id: alignment_all
    type:
      - 'null'
      - boolean
    doc: Always use full alignment (disable fast reference check via CIGAR)
    inputBinding:
      position: 103
      prefix: --alignment-all
  - id: consensus_reads
    type:
      - 'null'
      - int
    doc: Max number of reads to use to generate consensus alt sequence
    inputBinding:
      position: 103
      prefix: --consensus-reads
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug mode
    inputBinding:
      position: 103
      prefix: --debug
  - id: find_outliers
    type:
      - 'null'
      - boolean
    doc: Identify poorly supported outlier expansions (only with --unphased)
    inputBinding:
      position: 103
      prefix: --find-outliers
  - id: haploid
    type:
      - 'null'
      - string
    doc: comma-separated list of haploid (sex) chromosomes
    inputBinding:
      position: 103
      prefix: --haploid
  - id: max_locus
    type:
      - 'null'
      - int
    doc: Maximum locus size to consider (intervals larger than this will be 
      filtered out)
    inputBinding:
      position: 103
      prefix: --max-locus
  - id: max_number_reads
    type:
      - 'null'
      - int
    doc: Max number of reads to extract per locus from the bam file for 
      genotyping (use -1 for all reads)
    inputBinding:
      position: 103
      prefix: --max-number-reads
  - id: min_haplotype_fraction
    type:
      - 'null'
      - float
    doc: Minimum fraction of reads required for a cluster to be considered a 
      haplotype (only with --unphased)
    inputBinding:
      position: 103
      prefix: --min-haplotype-fraction
  - id: minlen
    type:
      - 'null'
      - int
    doc: minimal length of insertion/deletion operation
    inputBinding:
      position: 103
      prefix: --minlen
  - id: pathogenic
    type:
      - 'null'
      - boolean
    doc: Genotype the pathogenic STRs from STRchive
    inputBinding:
      position: 103
      prefix: --pathogenic
  - id: region
    type:
      - 'null'
      - string
    doc: 'Region string to genotype expansion in (format: chr:start-end)'
    inputBinding:
      position: 103
      prefix: --region
  - id: region_file
    type:
      - 'null'
      - File
    doc: Bed file with region(s) to genotype expansion(s) in
    inputBinding:
      position: 103
      prefix: --region-file
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample name to use in VCF header, if not provided, the bam file name is
      used
    inputBinding:
      position: 103
      prefix: --sample
  - id: somatic
    type:
      - 'null'
      - boolean
    doc: Print information on somatic variability
    inputBinding:
      position: 103
      prefix: --somatic
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: Sort output by chrom, start and end
    inputBinding:
      position: 103
      prefix: --sorted
  - id: support
    type:
      - 'null'
      - int
    doc: minimal number of supporting reads per haplotype
    inputBinding:
      position: 103
      prefix: --support
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel threads to use
    inputBinding:
      position: 103
      prefix: --threads
  - id: unphased
    type:
      - 'null'
      - boolean
    doc: Reads are not phased
    inputBinding:
      position: 103
      prefix: --unphased
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strdust:0.16.0--hcdda2d0_0
stdout: strdust_STRdust.out
